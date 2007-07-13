From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 11:12:36 -0400
Message-ID: <87abu01gnv.fsf__20602.5592321113$1184339652$gmane$org@jbms.ath.cx>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707131129.34974.rjw@sisk.pl>
	<Pine.LNX.4.64.0707130227310.25614@asgard.lang.hm>
	<200707131359.53309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[snip]

> Not necessarily.  If we don't put devices into low power states before creating
> the image, that should work just fine (quiesce devices, create the image or
> kexec the new kernel, reprobe devices, save the image, suspend to RAM,
> resume from RAM, continue - or restore from the image if power failed in the
> meantime).  Still, for this purpose, both kernels need to be able to handle the
> same set of devices.

I don't know much about the suspend to RAM, but it seems that it would
indeed be necessary to have a device driver for a device in order to
switch it from e.g. a quiesced state to a low power state.  If, however,
the original kernel already completely turned off the device, then it
seems that the "save image" kernel shouldn't have to do anything to it
in order to suspend to RAM.  The drawback, though, is that since the old
kernel would have no way (unless the user tells it) to know which
devices should be left quiesced and which should be turned off, it would
have to turn them all off, which would mean spinning up and down the
disks.

On the other hand, being able to build the "save image" kernel with only
minimal hardware support could save a significant amount of the time
required to boot it.

[snip]

> No, it can't.  For example, it can't access filesystems mounted by the
> hibernated kernel, or they may get corrupted after the restore (if they are
> journaling, it can't even read from them).

That is true, but this also holds for the current hibernate
implementations.

> Which reminds me of one more issue, which is that the image-saving kernel
> won't be able to use these filesystems either, so its modules and user space
> will have to be available from somewhere else (like a RAM disk or dedicated
> partition).  So things get ugly.

This is not the issue that it appears to be, though.  Under the current
hibernate implementations, this very same userspace and set of modules
must be available "somewhere else" (i.e. an initrd) because it is needed
by the restore path.  Note that under the kexec approach, save and
restore become rather symmetric operations.

> Apart from this, the new kernel's user space cannot blindly modify swap space
> that might be in use by the hibernated kernel.

But it seems easy enough to swapoff in order to completely free up the
swap space.  I suppose the disadvantage is that instead of failing
cleanly if there is insufficient memory, the OOM killer will be invoked
and cause all sorts of havoc.  This suggests that it may indeed be
important to support "cooperation" with the old kernel on saving the
image sooner, rather than later.

[snip]

-- 
Jeremy Maitin-Shepard
