From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Kernel panic after resuming from S4 on Napa dual-core.
Date: Wed, 26 Jul 2006 08:19:36 +0200
Message-ID: <200607260819.37012.rjw@sisk.pl>
References: <076F541A621E59428B837DCEA0AEDB5887C0C1@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <076F541A621E59428B837DCEA0AEDB5887C0C1@bjsmsx401>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: "Hu, Fenghua" <fenghua.hu@intel.com>, Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org, lhcs-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 July 2006 07:45, Hu, Fenghua wrote:
> Here is the message:
> 
> Linux version 2.6.16.9-9-s4-hufh (root@localhost.localdomain) (gcc version 3.4.3 20041212 (Asianux 2.0 3.4.3-9.EL4.2)) #24 SMP Thu Jul 27 11:36:08 CST 2006
]--snip--[
> Thawing cpus ...
> Booting processor 1/1 eip 3000
> Not responding.
> Inquiring remote APIC #1...
> ... APIC #1 ID: failed
> ... APIC #1 VERSION: failed
> ... APIC #1 SPIV: failed
> Error taking cpu 1 up: -22
> Kernel panic - not syncing: Not enough cpus
>  <0>Rebooting in 10 seconds. 

This is a problem related to the CPU hotplug, but the panic is from
kernel/power/smp.c#enable_nonboot_cpus().

I don't think we should be panicking here.  It's better to just continue with
one CPU online IMHO.

Please apply the appended patch.  It should prevent the system from panicking,
but you will run on one CPU after resume.  Then, please check what's in the
file /sys/devices/system/cup/cpu1/online.  If 0, please do

# cat 1 >  /sys/devices/system/cup/cpu1/online

and see what happens.  If it doesn't go online, in which case
/sys/devices/system/cup/cpu1/online will contain 1, there should be some
error messages in dmesg.

Also after a fresh boot please try doing:

# cat 0 >  /sys/devices/system/cup/cpu1/online
# cat /proc/interrupts
(there should be no cpu1 in the output)
# cat 1 >  /sys/devices/system/cup/cpu1/online
# cat /proc/interrupts
(cpu1 should be present again)

If this doesn't work, CPU hotplug is totally broken on your system.
Otherwise, something in the suspend/resume code paths breaks it and we'll
have to figure out what it is.

Greetings,
Rafael


--
 kernel/power/smp.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.18-rc1-mm2/kernel/power/smp.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/kernel/power/smp.c
+++ linux-2.6.18-rc1-mm2/kernel/power/smp.c
@@ -55,7 +55,6 @@ void enable_nonboot_cpus(void)
 			continue;
 		}
 		printk("Error taking cpu %d up: %d\n", cpu, error);
-		panic("Not enough cpus");
 	}
 	cpus_clear(frozen_cpus);
 }
