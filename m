From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8995] New: /proc/acpi/alarm worked;
 update to 2.6.22.2 and /sys/class/rtc/rtc0/wakealarm don't
Date: Sat, 8 Sep 2007 17:29:11 -0700
Message-ID: <20070908172911.7f9fc44f.akpm@linux-foundation.org>
References: <bug-8995-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <bug-8995-10286@http.bugzilla.kernel.org/>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>, Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-fo>
Cc: huffcslists@gmail.com, bugme-daemon@bugzilla.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat,  8 Sep 2007 09:29:18 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8995
> 
>            Summary: /proc/acpi/alarm worked; update to 2.6.22.2 and
>                     /sys/class/rtc/rtc0/wakealarm don't
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.22.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Sleep-Wake
>         AssignedTo: acpi_power-sleep-wake@kernel-bugs.osdl.org
>         ReportedBy: huffcslists@gmail.com
> 
> 
> Most recent kernel where this bug did not occur:2.6.20
> Distribution: FC6
> Hardware Environment: ASUS A8N-SLI mobo, Athlon 64 3200+, PATA Disk
> Software Environment: FC6, MythTV 0.20.2-164
> Problem Description:
> Change in kernel code from support for /proc/acpi/alarm to
> /sys/class/rtc/rtc0/wakealarm and supporting code borked working system.  Will
> no longer wake at set time.
> Time set <> time reported by cat /sys.../wakealarm.  Return value off by large
> constant.  Note: Mobo doesn't support month, day, or year in alarm setting.
> 
> Steps to reproduce:
> Before upgrade from 2.6.20 to 2.6.22.2, suspend-to-disk with powerdown to
> standby would wake at time echoed into /proc/acpi/alarm.  Change of wakeup time
> setting code to echo 0 to /sys/class/rtc/rtc0/wakealarm followed by echo of
> seconds since epoch of desired wakeup time under 2.6.22.2 does not work. 
> System will not wake up at specified time.  Will wake by keyboard keystroke,
> such as Ctrl+Esc.  Tried enabling APM (BIOS) alarm setting and all entries
> under /proc/acpi/wakeup (all on at once), but no improvement.
> Test sequence:
> # echo 0 > /sys/class/rtc/rtc0/wakealarm
> # t=`date +%s`; w=`expr $t + 60`; echo $w > /sys/class/rtc/rtc0/wakealarm
> # echo $w
> 1189268800
> # cat /sys/class/rtc/rtc0/wakealarm
> 2076101696
> # expr 2076101696 - 1189268800
> 886832896
> <invoke your favorite code to suspend to disk and power down system leaving
> standby power on>
> <wait>
> <wait some more>
> <hit power on button>
> 

Guys, can we please work out where the problem lies here?  Is it in the 
new RTC code, ACPI or what?

Thanks.
