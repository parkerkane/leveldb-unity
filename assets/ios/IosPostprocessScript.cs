#if UNITY_IPHONE

using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;

using System;
using System.Diagnostics;

public class IosPostprocessScript : MonoBehaviour
{
	[PostProcessBuild(100)]
	public static void OnPostprocessBuild(BuildTarget target, string pathToBuildProject)
	{
		Process myCustomProcess = new Process();		
		myCustomProcess.StartInfo.FileName = "python";
        myCustomProcess.StartInfo.Arguments = string.Format("Assets/Editor/post_process.py \"{0}\"", pathToBuildProject);
        myCustomProcess.StartInfo.UseShellExecute = false;
        myCustomProcess.StartInfo.RedirectStandardOutput = false;
		myCustomProcess.Start(); 
		myCustomProcess.WaitForExit();
		UnityEngine.Debug.Log("iOS project post processed.");  
	}
}

#endif