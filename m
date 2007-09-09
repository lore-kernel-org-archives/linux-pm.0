From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 8995] New: /proc/acpi/alarm worked;
	update to 2.6.22.2 and /sys/class/rtc/rtc0/wakealarm don't
Date: Sun, 9 Sep 2007 13:32:43 +0200
Message-ID: <200709091332.44709.rjw@sisk.pl>
References: <bug-8995-10286@http.bugzilla.kernel.org/>
	<20070908172911.7f9fc44f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070908172911.7f9fc44f.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, huffcslists@gmail.com
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 September 2007 02:29, Andrew Morton wrote:
> On Sat,  8 Sep 2007 09:29:18 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=8995
> > 
> >            Summary: /proc/acpi/alarm worked; update to 2.6.22.2 and
> >                     /sys/class/rtc/rtc0/wakealarm don't
> >            Product: ACPI
> >            Version: 2.5
> >      KernelVersion: 2.6.22.2
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Power-Sleep-Wake
> >         AssignedTo: acpi_power-sleep-wake@kernel-bugs.osdl.org
> >         ReportedBy: huffcslists@gmail.com
> > 
> > 
> > Most recent kernel where this bug did not occur:2.6.20
> > Distribution: FC6
> > Hardware Environment: ASUS A8N-SLI mobo, Athlon 64 3200+, PATA Disk
> > Software Environment: FC6, MythTV 0.20.2-164
> > Problem Description:
> > Change in kernel code from support for /proc/acpi/alarm to
> > /sys/class/rtc/rtc0/wakealarm and supporting code borked working system.  Will
> > no longer wake at set time.
> > Time set <> time reported by cat /sys.../wakealarm.  Return value off by large
> > constant.  Note: Mobo doesn't support month, day, or year in alarm setting.
> > 
> > Steps to reproduce:
> > Before upgrade from 2.6.20 to 2.6.22.2, suspend-to-disk with powerdown to
> > standby would wake at time echoed into /proc/acpi/alarm.  Change of wakeup time
> > setting code to echo 0 to /sys/class/rtc/rtc0/wakealarm followed by echo of
> > seconds since epoch of desired wakeup time under 2.6.22.2 does not work. 
> > System will not wake up at specified time.  Will wake by keyboard keystroke,
> > such as Ctrl+Esc.  Tried enabling APM (BIOS) alarm setting and all entries
> > under /proc/acpi/wakeup (all on at once), but no improvement.
> > Test sequence:
> > # echo 0 > /sys/class/rtc/rtc0/wakealarm
> > # t=`date +%s`; w=`expr $t + 60`; echo $w > /sys/class/rtc/rtc0/wakealarm
> > # echo $w
> > 1189268800
> > # cat /sys/class/rtc/rtc0/wakealarm
> > 2076101696
> > # expr 2076101696 - 1189268800
> > 886832896
> > <invoke your favorite code to suspend to disk and power down system leaving
> > standby power on>
> > <wait>
> > <wait some more>
> > <hit power on button>
> > 
> 
> Guys, can we please work out where the problem lies here?  Is it in the 
> new RTC code, ACPI or what?

I think the suspend/hibernation code ordering changes after 2.6.20 are to blame
here.

Reportedly, the problem can be fixed by applying the patch from
http://lkml.org/lkml/2007/8/27/392 , but that requires some other changes which
are not present in 2.6.22.

It would be nice if that could be tested on 2.6.23-rc5 with the patchset from
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc5/patches/ applied
and the patch from http://lkml.org/lkml/2007/8/27/392 on top of it.

Greetings,
Rafael
