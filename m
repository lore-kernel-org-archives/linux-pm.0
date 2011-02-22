From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Tue, 22 Feb 2011 10:36:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102221029100.1968-100000__12609.2800674543$1298389114$gmane$org@iolanthe.rowland.org>
References: <4D6377B8.7080805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D6377B8.7080805@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@suse.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Feb 2011, Jiri Slaby wrote:

> On 02/04/2011 08:33 PM, Alan Stern wrote:
> > On Fri, 4 Feb 2011, Jiri Slaby wrote:
> > 
> >>>> It seems to suffice... No hangs still. Should I enable pm_async back
> >>>> again to confirm the issue is still present?
> >>>
> >>> Yes, please, it would be good to know for sure.
> >>
> >> Ok, confirmed right now :).
> >>
> >> I disabled pm_async for USB again. What do you suggest next?
> > 
> > What happens if you leave pm_async enabled but unplug all the USB 
> > devices before suspending?  If there are any USB devices you can't 
> > unplug, you can get an equivalent result by unconfiguring the root 
> > hubs:
> > 
> > 	for a in /sys/bus/usb/devices/usb* ; do
> > 		echo 0 >$a/bConfigurationValue
> > 	done
> 
> This doesn't seem to help. The hang happened 3 times during the 2 weeks.
> 
> I have /etc/pm/sleep.d/99usb-debug with:
> #!/bin/bash
> 
> send() {
>         for a in /sys/bus/usb/devices/usb* ; do
>                 echo $1 >$a/bConfigurationValue
>         done
> }
> 
> case "$1" in
>         hibernate|suspend)
>                         send 0
>                 ;;
>         thaw|resume)
>                         send 1
>                 ;;
>         *)
>                 ;;
> esac
> 
> exit 0
> 
> And it indeed properly enable/disable usb before/after suspend.

Strange indeed.  It's worth noting that the async stuff affects only
the normal suspend and resume operations, not the late-suspend and
early-resume operations.  This means that it all likelihood, the system
crashes either before finishing the suspend or after doing a fair
amount of the resume.  And yet that's not consistent with what you see
on the screen.

By the way, are you booting with no_console_suspend?  And do you do 
"echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
suspending?

What about if you leave async enabled for all the USB devices _except_ 
usb[1-N]?

Alan Stern
