From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug
 documentation
Date: Fri, 12 Aug 2016 08:22:41 +0200
Message-ID: <20160812062241.GB30992@amd>
References: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39449 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbcHLG3q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 02:29:46 -0400
Content-Disposition: inline
In-Reply-To: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

Hi!

> Update the description of test_resume mode for hibernation.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  Documentation/power/basic-pm-debugging.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

That's certainly step in the right direction, but I guess it should be
mentioned in the other places, too. Something like this?

Additionally, we have testproc. Should we move it to test_proc for
consistency (or replace test_resume with simple "resume"? That's what
it does... it is hibernate+resume...

Thanks,
								Pavel



diff --git a/Documentation/power/interface.txt b/Documentation/power/interface.txt
index f1f0f59a..d4ac8f7 100644
--- a/Documentation/power/interface.txt
+++ b/Documentation/power/interface.txt
@@ -23,8 +23,8 @@ few options for putting the system to sleep - using the platform driver
 (e.g. ACPI or other suspend_ops), powering off the system or rebooting the
 system (for testing).
 
-Additionally, /sys/power/disk can be used to turn on one of the two testing
-modes of the suspend-to-disk mechanism: 'testproc' or 'test'.  If the
+Additionally, /sys/power/disk can be used to turn on one of the three testing
+modes of the suspend-to-disk mechanism: 'test_resume', 'testproc' or 'test'.  If the
 suspend-to-disk mechanism is in the 'testproc' mode, writing 'disk' to
 /sys/power/state will cause the kernel to disable nonboot CPUs and freeze
 tasks, wait for 5 seconds, unfreeze tasks and enable nonboot CPUs.  If it is
@@ -32,12 +32,13 @@ in the 'test' mode, writing 'disk' to /sys/power/state will cause the kernel
 to disable nonboot CPUs and freeze tasks, shrink memory, suspend devices, wait
 for 5 seconds, resume devices, unfreeze tasks and enable nonboot CPUs.  Then,
 we are able to look in the log messages and work out, for example, which code
-is being slow and which device drivers are misbehaving.
+is being slow and which device drivers are misbehaving. In 'test_resume' mode,
+... (insert your description here).
 
 Reading from this file will display all supported modes and the currently
 selected one in brackets, for example
 
-	[shutdown] reboot test testproc
+	[shutdown] reboot test testproc test_resume
 
 Writing to this file will accept one of
 


> diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
> index b96098c..5f1f228 100644
> --- a/Documentation/power/basic-pm-debugging.txt
> +++ b/Documentation/power/basic-pm-debugging.txt
> @@ -36,6 +36,13 @@ button to make the system resume).
>  If neither "platform" nor "shutdown" hibernation mode works, you will need to
>  identify what goes wrong.
>  
> +Besides, if all the modes described above work, "test_resume" mode can be used to
> +verify if the snapshot data written to swap device can be successfully restored
> +to memory:
> +# echo test_resume > /sys/power/disk
> +# echo disk > /sys/power/state
> +If everything goes well, the system will resume back without BIOSes involved in.
> +
>  a) Test modes of hibernation
>  
>  To find out why hibernation fails on your system, you can use a special testing

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
