From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug
 documentation
Date: Fri, 12 Aug 2016 23:56:20 +0200
Message-ID: <20160812215620.GB10803@amd>
References: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0jo3r+XFCkh1oH726bwu0CfMnq7xr-seT1Cq_0r6BcTFg@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028786F3F@shsmsx102.ccr.corp.intel.com>
 <1760965.g7WzOE9Hrf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1760965.g7WzOE9Hrf@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Index: linux-pm/Documentation/power/interface.txt
> ===================================================================
> --- linux-pm.orig/Documentation/power/interface.txt
> +++ linux-pm/Documentation/power/interface.txt
...
> -CAUTION: Using it will cause your machine's real-time (CMOS) clock to be
> -set to a random invalid time after a resume.
> +'freeze' (Suspend-to-Idle)
> +'standby' (Power-On Suspend)
> +'mem' (Suspend-to-RAM)
> +'disk' (Suspend-to-Disk)
> +
> +Suspend-to-Idle is always supported.  Suspend-to-Disk is always supported
> +too as long the kernel has been configured to support hibernation at all
> +(ie. CONFIG_HIBERNATION is set in the kernel configuration file).  Support
> +for Suspend-to-RAM and Power-On Suspend depends on the capabilities of the
> +platform.
> +
> +If one of the strings listed in /sys/power/state is writtent to it, the system

Typo at writtent.

> +will attempt to transition into the corresponding sleep state.  Refer to
> +Documentation/power/states.txt for a description of each of those states.
> +
> +/sys/power/disk controls the operating mode of hibernation (Suspend-to-Disk).
> +Specifically, it tells the kernel what to do after creating a hibernation image.
> +
> +Reading from it returs a list of supported options encoded as:
> +
> +'platform' (put the system into sleep using a platform-provided method)
> +'shutdown' (shut the system down)
> +'reboot' (reboot the system)
> +'suspend' (trigger a Suspend-to-RAM transition)
> +'test_resume' (resume-after-hibernation test mode)
> +
> +The currently selected option is printed in brackets.

-> in square brackets ("[]")?

> +The 'platform' option is only available if the platform provides a special
> +mechanism to put the system to sleep after creating a hibernation image (ACPI
> +does that, for example).  The 'suspend' option is available if Suspend-to-RAM
> +is supported.  Refer to Documentation/power/basic_pm_debugging.txt for the
> +description of the 'test_resume' option.
> +
> +To select an option, write the string representing it to /sys/power/disk.
> +
> +/sys/power/image_size controls the size of hibernation images.
> +
> +It can be written a string representing a non-negative integer that will be
> +used as a best-effort upper limit of the image size, in bytes.  The hibernation
> +core will do its best to ensure that the image size will not exceed that number.
> +However, if that turns out to be impossible to achieve, a hibernation image will
> +still be created and its size will be as small as possible.  In particular,
> +writing '0' to this file will enforce hibernation images to be possibly small.

-> as small as possible.

> +On architectures and platforms that support using different kernels to restore
> +hibernation images (that is, the kernel used to read the image from storage and
> +load it into memory is different from the one included in the image) or support
> +kernel address space randomization, it also can be used to check if failures
> +to resume may be related to the differences between the restore and image
> +kernels.

Hmm. Actually we should document which architectures support suspend &
restore in different kernel... somewhere.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
