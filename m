From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [regression,bisected] restore of disks after suspend-to-disk
 broken in 3.9.x
Date: Mon, 27 May 2013 13:07:06 +0800
Message-ID: <1369631226.2159.5.camel@rzhang1-mobl4>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Giacomo Perale <giacomo.perale@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
> Hello,
> 
> after upgrading from 3.8.7 to 3.9.x I noticed some slightly longer
> delays when resuming from suspend-to-disk and a few new error messages
> in the logs:
> 
> ata1: link is slow to respond, please be patient (ready=0)
> ata3: link is slow to respond, please be patient (ready=0)
> ata1: SRST failed (errno=-16)
> ata3: SRST failed (errno=-16)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ACPI cmd ef/03:46:00:00:00:a0 (SET FEATURES) filtered out
> ata1.00: configured for UDMA/133
> sd 0:0:0:0: [sda] Starting disk
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ACPI cmd ef/03:46:00:00:00:a0 (SET FEATURES) filtered out
> ata3.00: configured for UDMA/133
> sd 2:0:0:0: [sdc] Starting disk
> PM: restore of devices complete after 11448.044 msecs
> 
> (compared to ~2900 msecs with 3.8.x).
> 
> I didn't mind the messages since things were working anyway, but
> lately in a couple of cases some disks were dropped and disabled, with
> the obvious consequences for the functionality of the system:
> 
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: SRST failed (errno=-16)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2: SRST failed (errno=-16)
> ata2: reset failed, giving up
> ata2.00: disabled
> sd 1:0:0:0: [sdb] Starting disk
> sd 1:0:0:0: [sdb] START_STOP FAILED
> sd 1:0:0:0: [sdb]
> Result: hostbyte=0x04 driverbyte=0x00
> dpm_run_callback(): scsi_bus_restore+0x0/0x20 returns 262144
> PM: Device 1:0:0:0 failed to restore async: error 262144
> PM: restore of devices complete after 61130.778 msecs
> ...
> sd 1:0:0:0: [sdb] Unhandled error code
> sd 1:0:0:0: [sdb]
> Result: hostbyte=0x04 driverbyte=0x00
> sd 1:0:0:0: [sdb] CDB:
> cdb[0]=0x28: 28 00 00 00 00 6f 00 00 08 00
> end_request: I/O error, dev sdb, sector 111
> XFS (sdb1): metadata I/O error: block 0x30 ("xfs_trans_read_buf_map")
> error 5 numblks 8
> ffff88006f710000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> XFS (sdb1): Internal error xfs_dir2_leaf_verify at line 62 of file
> fs/xfs/xfs_dir2_leaf.c.  Caller 0xffffffff811d17d8
> 
> 
> Not having connected the issue with the previous error messages I
> initially blamed the disk and replaced it with a new one thinking it
> was broken, but the problem persisted so I started a bisection run
> that pointed to this commit:
> 
> 
> b8bb6cb999858043489c1ddef08eed2127559169 is the first bad commit
> commit b8bb6cb999858043489c1ddef08eed2127559169
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Thu Nov 22 15:45:02 2012 +0800
> 
>     step_wise: Unify the code for both throttle and dethrottle
> 
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
I do not see how this would affect the sata hibernation/resume.
but anyway, would you please try the four patches in comment #10, #11,
#12 and #13 in
https://bugzilla.kernel.org/show_bug.cgi?id=58301
and check if they help?

thanks,
rui

