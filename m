From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Tue, 17 Jul 2007 13:46:51 +0200
Message-ID: <200707171346.52542.rjw__15615.9665472389$1184672426$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707161740.26703.rjw@sisk.pl>
	<Pine.LNX.4.64.0707162112180.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707162112180.19248@asgard.lang.hm>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 06:18, david@lang.hm wrote:
> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
> 
> > On Monday, 16 July 2007 16:42, Huang, Ying wrote:
> >> On Mon, 2007-07-16 at 14:17 +0200, Rafael J. Wysocki wrote:
> >>>> is this  a matter of running some test to find out, or is this a question
> >>>> for the kexec implemantors?
> >>>
> >>> Actually, I'd like someone to tell me. ;-)
> >>>
> >>> I've browsed the kexec code, but haven't found anything related to the devices
> >>> in it.  Perhaps I didn't know where to look ...
> >>
> >> There are two stages for kexec. For "normal" kexec, first the
> >> sys_kexe_load is called to load the kernel image, then
> >> sys_reboot(LINUX_REBOOT_CMD_KEXEC) is called to boot the new kernel.
> >
> > OK, thanks.  This is the information that I was missing.
> >
> >> The call chain is as follow:
> >>
> >> sys_reboot(LINUX_REBOOT_CMD_KEXEC)
> >>     kernel_kexec
> >>         kernel_restart_prepare
> >>             device_shutdown
> >>         machine_shutdown
> >>         machine_kexec
> >>
> >> In device_shutdown, the dev->bus->shutdown or dev->driver->shutdown of
> >> every device is called to put device in quiescent state. In
> >> machine_kexec, the new kernel is booted.
> >
> > Yes.
> >
> >> So, for normal kexec, there is no code path for device state saving and
> >> restoring.
> >
> > Exactly.
> >
> >> State of device can be restore after shutdown? I don't think so.
> >
> > No, it can't, but we need something like this for hibernation and
> > device_shutdown() is not appropriate for this purpose IMO.
> 
> is the only reason that device_shutdown() is not appropriate the amount of 
> time it takes to shutdown some devices and then start them up again? (I'm 
> specificly thinking of drive spin down/up as an example)

Not only that.  You also need to save some driver data so that it can restore
the devices state from before the hibernation.  [Say you have a task blocked
on the driver's mutex in .read().  In that case you'd want the .read() to be
carried out after the restore in the same way in which it would have been
caried out if the hibernation hadn't occur.]

> if so, it is probably worth implementing a demo with the long times 
> involved to hash out any other problems, and then implemnt shortcuts to 
> avoid the device_shutdown only where the time involved is excessive.

I think that device_shutdown() is just inappropriate, because in principle
it doesn't allow you to save any information related to the device state
before hibernation that may be needed after the restore.

> so, exactly where in the process above does the memory map need to be 
> created? is this in the machine_shutdown step or would it need to be in 
> the machine_kexec step?

I would do in in the machine_kexec step.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
