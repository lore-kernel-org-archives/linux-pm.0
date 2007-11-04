From: Pavel Machek <pavel@ucw.cz>
Subject: Re: acpi_video_flags Reset on Resume-From-RAM
Date: Sun, 4 Nov 2007 12:41:50 +0000
Message-ID: <20071104124149.GD3921@ucw.cz>
References: <20071009000038.GA23726@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071009000038.GA23726@best.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leo L. Schwab" <ewhac@best.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2007-10-08 17:00:38, Leo L. Schwab wrote:
> 	Suspend-to-RAM used to (mostly) work on this machine, but there
> seems to have been a regression between 2.6.22.1 and 2.6.22.5.
> 
> 	I have a ThinkPad Z61t, with an Intel Core 2 Duo and Intel 945GM
> graphics.  My kernel command line contains the argument,
> "acpi_sleep=s3_bios,s3_mode", which is the same as setting
> /proc/sys/kernel/acpi_video_flags to 3.  This setting is suggested by
> ThinkWiki.org for getting the Intel graphics to recover properly after
> suspend-to-RAM.
> 
> 	Under 2.6.22.1, this arrangement worked fine.  However, since I
> upgraded the kernel to 2.6.22.5, the text console refuses to come back.
> When I inspect acpi_video_flags, the value has been reset to zero.
> 
> 	Sequence:
> 	- Boot system.
> 	- Inspect /proc/sys/kernel/acpi_video_flags -- it contains 3.
> 	- Trigger suspend-to-RAM (done via 'hibernate-ram').  I have
> 	  configured 'hibernate' to leave acpi_video_flags alone.
> 	- Resume system.  Text console does not come back.  I can force X to
> 	  recover the display by pressing CTRL-ALT-F1 (switch to console)
> 	  followed by ALT-F7 (switch to X).
> 	- Inspect /proc/sys/kernel/acpi_video_flags -- it contains 0.
> 	- Force acpi_video_flags back to 3:
> 	  echo 3 > /proc/sys/kernel/acpi_video_flags
> 	- Inspect /proc/sys/kernel/acpi_video_flags -- it contains 3.
> 	- Trigger suspend-to-RAM.
> 	- Resume system.  Text console does not come back.  acpi_video_flags
> 	  contains zero again.
> 
> 	I'm running a custom-compiled kernel (config available upon
> request).  The highlights are SMP, PREEMPT, and NOHZ.
> 
> 	Note that nothing short of a full reboot will restore the console.
> Switching to a virtual console results in a blank screen.  Switching back to
> X so far always works.  Since the console's busted, it's not immediately
> clear how I might diagnose this further.  Suggestions?

Try updating to 2.6.24-rc.... Or find out which patch causes the
regression, and talk to its author.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
