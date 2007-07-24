From: "Huang, Ying" <ying.huang@intel.com>
Subject: RE: Re: Hibernation considerations
Date: Tue, 24 Jul 2007 21:26:35 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC236CF5C__21051.1234392927$1185283654$gmane$org@pdsmsx415.ccr.corp.intel.com>
References: <Pine.LNX.4.44L0.0707231605410.2556-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.44L0.0707231605410.2556-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Pavel Machek <pavel@ucw.cz>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>It can't.  Indeed, in the absence of a freezer, user threads will need
>devices (more accurately, will submit I/O requests for devices) that
>have to be kept quiescent or low-power.  Drivers will need to delay
>those requests until the devices are returned to full operation.
>
>That's exactly what I've been saying all along: Drivers will need to
>be changed to delay I/O requests, if there is no freezer.

If it is a too big work to implement "delaying I/O requests" for every
driver, is it possible to implement it as follow:

1. It is triggered to suspend to RAM/DISK.
2. Replace the driver related syscall entries (such as sys_read,
sys_write, sys_ioctl, etc) in sys_call_table with special wrapper
entries provided by "suspend to RAM/DISK" subsystem, which will delay
I/O requests if appropriate.
3. When devices are quiesced, they are put into "low power" state and
system is put into suspend state; or the image is written to disk
(through snapshot/uswsusp or kexeced kernel).
4. After resuming from RAM/DISK, devices are put into "normal" state and
the syscall entries replaced in step 2 are restored.

Best Regards,
Huang Ying
