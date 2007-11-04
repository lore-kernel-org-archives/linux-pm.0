From: David Brownell <david-b@pacbell.net>
Subject: Re: [Bugme-new] [Bug 8995] New: /proc/acpi/alarm worked;
	update to 2.6.22.2 and /sys/class/rtc/rtc0/wakealarm don't
Date: Sun, 4 Nov 2007 12:25:34 -0700
Message-ID: <200711041125.35163.david-b@pacbell.net>
References: <bug-8995-10286@http.bugzilla.kernel.org/>
	<20070908172911.7f9fc44f.akpm@linux-foundation.org>
	<200709091332.44709.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709091332.44709.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, huffcslists@gmail.com, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Re http://bugzilla.kernel.org/show_bug.cgi?id=8995 ...

On Sunday 09 September 2007, Rafael J. Wysocki wrote:
> I think the suspend/hibernation code ordering changes after
> 2.6.20 are to blame here.

So what's the status of this now ... are we back to having
the /sys/class/rtc/rtc0/wakealarm work with ACPI again, with
/sys/power/state written as "standby", "mem", or "disk"

(At least on the systems where it used to work.  I've had
bad luck with ACPI wake on most systems.  So while it'd be
great to see it working everywhere, I'm just asking about
the regression here.)

- Dave

p.s. some folk may need the appended patch.

=====	CUT HERE
From: Mark Lord <lkml@rtr.ca>

This patch fixes rtc-cmos to ignore the two upper bits when reading
the BCD mday (day of month) register from CMOS.  Some systems (eg. mine)
seem to have the top bit set to "1" for some reason.

Signed-off-by: Mark Lord <mlord@pobox.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>

--- a/drivers/rtc/rtc-cmos.c	2007-11-03 16:24:09.000000000 -0400
+++ b/drivers/rtc/rtc-cmos.c	2007-11-03 16:26:51.000000000 -0400
@@ -120,7 +120,8 @@
 	t->time.tm_hour = CMOS_READ(RTC_HOURS_ALARM);
 
 	if (cmos->day_alrm) {
-		t->time.tm_mday = CMOS_READ(cmos->day_alrm);
+		/* ignore upper bits on readback per ACPI spec */
+		t->time.tm_mday = CMOS_READ(cmos->day_alrm) & 0x3f;
 		if (!t->time.tm_mday)
 			t->time.tm_mday = -1;
 
