From: Don Zickus <dzickus@redhat.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Tue, 1 Jun 2010 09:50:04 -0400
Message-ID: <20100601135004.GP15159__48433.5912079134$1275405841$gmane$org@redhat.com>
References: <4C03C608.1040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C03C608.1040600@gmail.com>
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 31, 2010 at 04:22:00PM +0200, Jiri Slaby wrote:
> Hi,
> 
> with -next I get the following errors while trying to hibernate in
> qemu-kvm after the image is stored on disk:

Is this the host that is hibernating or the guest?

KVM guests don't emulate the performance counters, so the nmi piece
shouldn't be functioning and the soft lockup piece just sits on top of an
hrtimer, so off the top of my head it is hard to imagine it intefering
with a sata driver.

I'll need your whole boot up log to see how the lockup detector
initialized itself.

Cheers,
Don

> sd 0:0:0:0: [sda] Starting disk
> sd 0:0:1:0: [sdb] Starting disk
> e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> ata1.00: configured for MWDMA2
> ata1.01: configured for MWDMA2
> PM: thaw of devices complete after 168.017 msecs
> ata2.01: qc timeout (cmd 0xec)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> sd 0:0:1:0: [sdb] Stopping disk
> sd 0:0:0:0: [sda] Stopping disk
> uhci_hcd 0000:00:01.2: PCI INT D disabled
> e1000 0000:00:03.0: PCI INT A disabled
> ata2.01: qc timeout (cmd 0xec)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.01: qc timeout (cmd 0xec)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ...
> 
> I bisected it down to:
> commit 58687acba59266735adb8ccd9b5b9aa2c7cd205b
> Author: Don Zickus <dzickus@redhat.com>
> Date:   Fri May 7 17:11:44 2010 -0400
> 
>     lockup_detector: Combine nmi_watchdog and softlockup detector
> 
>     The new nmi_watchdog (which uses the perf event subsystem) is very
>     similar in structure to the softlockup detector.  Using Ingo's
>     suggestion, I combined the two functionalities into one file:
>     kernel/watchdog.c.
> ...
> 
> 
> 
> The config difference against 58687acb^:
> --- .config.old     2010-05-31 16:01:51.727312636 +0200
> +++ .config 2010-05-31 16:11:08.682136175 +0200
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
>  # Linux kernel version: 2.6.34-rc7
> -# Mon May 31 16:01:51 2010
> +# Mon May 31 16:11:08 2010
>  #
>  CONFIG_64BIT=y
>  # CONFIG_X86_32 is not set
> @@ -2133,7 +2133,7 @@
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_SHIRQ=y
>  CONFIG_DETECT_SOFTLOCKUP=y
> -CONFIG_NMI_WATCHDOG=y
> +CONFIG_LOCKUP_DETECTOR=y
>  # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>  CONFIG_DETECT_HUNG_TASK=y
> 
> 
> 
> 
> 'nowatchdog' parameter helps.
> 
> $ grep PERF .config
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_EVENTS=y
> # CONFIG_PERF_COUNTERS is not set
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> 
> -- 
> js
