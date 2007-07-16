From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Mon, 16 Jul 2007 22:42:30 +0800
Message-ID: <1184596950.24143.28.camel__33739.9917807945$1184597143$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707160059.08277.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151549200.25614@asgard.lang.hm>
	<200707161417.50166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707161417.50166.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-07-16 at 14:17 +0200, Rafael J. Wysocki wrote:
> > is this  a matter of running some test to find out, or is this a question 
> > for the kexec implemantors?
> 
> Actually, I'd like someone to tell me. ;-)
> 
> I've browsed the kexec code, but haven't found anything related to the devices
> in it.  Perhaps I didn't know where to look ...

There are two stages for kexec. For "normal" kexec, first the
sys_kexe_load is called to load the kernel image, then
sys_reboot(LINUX_REBOOT_CMD_KEXEC) is called to boot the new kernel. The
call chain is as follow:

sys_reboot(LINUX_REBOOT_CMD_KEXEC)
    kernel_kexec
        kernel_restart_prepare
            device_shutdown
        machine_shutdown
        machine_kexec

In device_shutdown, the dev->bus->shutdown or dev->driver->shutdown of
every device is called to put device in quiescent state. In
machine_kexec, the new kernel is booted.

So, for normal kexec, there is no code path for device state saving and
restoring. State of device can be restore after shutdown? I don't think
so.

> I think that the right approach is to separate devices' suspend from the
> devices' hibernation-related operations FIRST.  Then, many different approaches
> to hibernation will be much easier to implement than they are now.
> 
> I've been saying this for weeks now, but no one seems to listen frankly I'm
> tired of repeating it:

I agree with you on this. :)

> If we want to improve things, let's do that IN AN ORDERED WAY.  If everyone
> will come up with a new idea every two days, we won't be able to get anything
> actually _done_.

Yes, and I am very glad to collaborate with everybody who is interested
in this subject. But I think we should try to verify our idea with code
as early as possible. Now, I am trying to implement a prototype of
kexec/kdump based image writing/reading mechanism to verify the
feasibility. (I suppose you are working on separating device suspend and
device hibernate).

What do you think about the pattern of collaboration?

At last, thank you very much for your valuable reminding in the mail of
"hibernation considerations".

Best Regards,
Huang Ying
