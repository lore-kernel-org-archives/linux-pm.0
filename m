From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: (fwd) empty /sys/power/state?
Date: Sat, 19 May 2007 21:55:17 +0200
Message-ID: <464F5625.9020905@s5r6.in-berlin.de>
References: <464F53C2.8070802@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F53C2.8070802@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Maybe linux-pm is the more appropriate list for this question:

I wrote at suspend-devel@lists.sourceforge.net:
> What's wrong here?
> 
> # cat /sys/power/state
> # echo mem > /sys/power/state
> -su: echo: write error: No such device
> # uname -a
> Linux mini 2.6.22-rc2 #3 SMP PREEMPT Sat May 19 20:56:46 CEST 2007
> x86_64 Intel(R) Core(TM)2 CPU         T7600  @ 2.33GHz GenuineIntel
> GNU/Linux
> # grep -e _PM -e _ACPI /usr/src/linux/.config
> CONFIG_PM=y
> # CONFIG_PM_LEGACY is not set
> # CONFIG_PM_DEBUG is not set
> # CONFIG_PM_SYSFS_DEPRECATED is not set
> CONFIG_ACPI=y
> CONFIG_ACPI_PROCFS=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
> # CONFIG_ACPI_SBS is not set
> CONFIG_X86_ACPI_CPUFREQ=m
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_THINKPAD_ACPI is not set
> CONFIG_ATA_ACPI=y
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_PM3 is not set
> 

Thanks for advice,
-- 
Stefan Richter
-=====-=-=== -=-= =--==
http://arcgraph.de/sr/
