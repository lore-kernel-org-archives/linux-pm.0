From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in
	sysfs
Date: Sat, 06 Jan 2007 19:35:18 +0800
Message-ID: <1168083318.5619.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Create /sys/power/alarm.
The way it works is exactly the same as /proc/acpi/alarm.
I.e. "#echo yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports existing absolute time.
And "#echo +yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports a duration.

NOTE: It's not very clean to refer struct subsystem power_subsys in ACPI.
But I think /sys/power is the most reasonable place to locate this "alarm" attribute.
So anybody who get better ideas, please let me know.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep/proc.c |  313 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 287 insertions(+), 26 deletions(-)

Index: linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/sleep/proc.c	2007-01-06 17:53:17.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c	2007-01-06 18:17:53.000000000 +0800
@@ -15,6 +15,290 @@
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("sleep")
+
+static int get_date_field(char **p, u32 * value)
+{
+	char *next = NULL;
+	char *string_end = NULL;
+	int result = -EINVAL;
+
+	/*
+	 * Try to find delimeter, only to insert null.  The end of the
+	 * string won't have one, but is still valid.
+	 */
+	next = strpbrk(*p, "- :");
+	if (next)
+		*next++ = '\0';
+
+	*value = simple_strtoul(*p, &string_end, 10);
+
+	/* Signal success if we got a good digit */
+	if (string_end != *p)
+		result = 0;
+
+	if (next)
+		*p = next;
+
+	return result;
+}
+
+/* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+
+static ssize_t alarm_show(struct subsystem *subsys, char *buf){
+	u32 sec, min, hr;
+	u32 day, mo, yr;
+	unsigned char rtc_control = 0;
+	unsigned long flags;
+	ssize_t result = 0;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+
+	sec = CMOS_READ(RTC_SECONDS_ALARM);
+	min = CMOS_READ(RTC_MINUTES_ALARM);
+	hr = CMOS_READ(RTC_HOURS_ALARM);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+
+	/* If we ever get an FACP with proper values... */
+	if (acpi_gbl_FADT->day_alrm)
+		/* ACPI spec: only low 6 its should be cared */
+		day = CMOS_READ(acpi_gbl_FADT->day_alrm) & 0x3F;
+	else
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+	if (acpi_gbl_FADT->mon_alrm)
+		mo = CMOS_READ(acpi_gbl_FADT->mon_alrm);
+	else
+		mo = CMOS_READ(RTC_MONTH);
+	if (acpi_gbl_FADT->century)
+		yr = CMOS_READ(acpi_gbl_FADT->century) * 100 +
+		    CMOS_READ(RTC_YEAR);
+	else
+		yr = CMOS_READ(RTC_YEAR);
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hr);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mo);
+		BCD_TO_BIN(yr);
+	}
+
+	/* we're trusting the FADT (see above) */
+	if (!acpi_gbl_FADT->century)
+		/* If we're not trusting the FADT, we should at least make it
+		 * right for _this_ century... ehm, what is _this_ century?
+		 *
+		 * TBD:
+		 *  ASAP: find piece of code in the kernel, e.g. star tracker driver,
+		 *        which we can trust to determine the century correctly. Atom
+		 *        watch driver would be nice, too...
+		 *
+		 *  if that has not happened, change for first release in 2050:
+		 *        if (yr<50)
+		 *                yr += 2100;
+		 *        else
+		 *                yr += 2000;   // current line of code
+		 *
+		 *  if that has not happened either, please do on 2099/12/31:23:59:59
+		 *        s/2000/2100
+		 *
+		 */
+		yr += 2000;
+
+	result = sprintf(buf+result, "%4.4u-", yr);
+	if (mo > 12)
+		result += sprintf(buf+result, "**-");
+	else
+		result +=  sprintf(buf+result, "%2.2u-", mo);
+	if(day > 31)
+		result += sprintf(buf+result, "** ");
+	else
+		result +=  sprintf(buf+result, "%2.2u ", day);
+	if(hr > 23)
+		result += sprintf(buf+result, "**:");
+	else
+		result +=  sprintf(buf+result, "%2.2u:", hr);
+	if(min > 59)
+		result += sprintf(buf+result, "**:");
+	else
+		result +=  sprintf(buf+result, "%2.2u:", min);
+	if(sec > 59)
+		result += sprintf(buf+result, "**\n");
+	else
+		result +=  sprintf(buf+result, "%2.2u\n", sec);
+
+	return result;
+}
+
+static ssize_t alarm_store(struct subsystem *subsys, const char *buf, size_t count){
+	int result = 0;
+	char *p = (char*)buf;
+	u32 sec, min, hr, day, mo, yr;
+	int adjust = 0;
+	unsigned char rtc_control = 0;
+
+	if (buf[0] == '+') {
+			p++;
+			adjust = 1;
+		}
+
+	if ((result = get_date_field(&p, &yr)))
+		goto end;
+	if ((result = get_date_field(&p, &mo)))
+		goto end;
+	if ((result = get_date_field(&p, &day)))
+		goto end;
+	if ((result = get_date_field(&p, &hr)))
+		goto end;
+	if ((result = get_date_field(&p, &min)))
+		goto end;
+	if ((result = get_date_field(&p, &sec)))
+		goto end;
+
+	if (sec > 59) {
+		min += 1;
+		sec -= 60;
+	}
+	if (min > 59) {
+		hr += 1;
+		min -= 60;
+	}
+	if (hr > 23) {
+		day += 1;
+		hr -= 24;
+	}
+	if (day > 31) {
+		mo += 1;
+		day -= 31;
+	}
+	if (mo > 12) {
+		yr += 1;
+		mo -= 12;
+	}
+	spin_lock_irq(&rtc_lock);
+
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BIN_TO_BCD(yr);
+		BIN_TO_BCD(mo);
+		BIN_TO_BCD(day);
+		BIN_TO_BCD(hr);
+		BIN_TO_BCD(min);
+		BIN_TO_BCD(sec);
+	}
+
+	if (adjust) {
+		yr += CMOS_READ(RTC_YEAR);
+		mo += CMOS_READ(RTC_MONTH);
+		day += CMOS_READ(RTC_DAY_OF_MONTH);
+		hr += CMOS_READ(RTC_HOURS);
+		min += CMOS_READ(RTC_MINUTES);
+		sec += CMOS_READ(RTC_SECONDS);
+	}
+
+	spin_unlock_irq(&rtc_lock);
+
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(yr);
+		BCD_TO_BIN(mo);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(hr);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(sec);
+	}
+
+	if (sec > 59) {
+		min++;
+		sec -= 60;
+	}
+	if (min > 59) {
+		hr++;
+		min -= 60;
+	}
+	if (hr > 23) {
+		day++;
+		hr -= 24;
+	}
+	if (day > 31) {
+		mo++;
+		day -= 31;
+	}
+	if (mo > 12) {
+		yr++;
+		mo -= 12;
+	}
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BIN_TO_BCD(yr);
+		BIN_TO_BCD(mo);
+		BIN_TO_BCD(day);
+		BIN_TO_BCD(hr);
+		BIN_TO_BCD(min);
+		BIN_TO_BCD(sec);
+	}
+
+	spin_lock_irq(&rtc_lock);
+	/*
+	 * Disable alarm interrupt before setting alarm timer or else
+	 * when ACPI_EVENT_RTC is enabled, a spurious ACPI interrupt occurs
+	 */
+	rtc_control &= ~RTC_AIE;
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	/* write the fields the rtc knows about */
+	CMOS_WRITE(hr, RTC_HOURS_ALARM);
+	CMOS_WRITE(min, RTC_MINUTES_ALARM);
+	CMOS_WRITE(sec, RTC_SECONDS_ALARM);
+
+	/*
+	 * If the system supports an enhanced alarm it will have non-zero
+	 * offsets into the CMOS RAM here -- which for some reason are pointing
+	 * to the RTC area of memory.
+	 */
+	if (acpi_gbl_FADT->day_alrm)
+		CMOS_WRITE(day, acpi_gbl_FADT->day_alrm);
+	if (acpi_gbl_FADT->mon_alrm)
+		CMOS_WRITE(mo, acpi_gbl_FADT->mon_alrm);
+	if (acpi_gbl_FADT->century)
+		CMOS_WRITE(yr / 100, acpi_gbl_FADT->century);
+	/* enable the rtc alarm interrupt */
+	rtc_control |= RTC_AIE;
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	spin_unlock_irq(&rtc_lock);
+
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_enable_event(ACPI_EVENT_RTC, 0);
+
+	result = count;
+
+      end:
+	return result;
+}
+
+static struct subsys_attribute alarm_attr = {
+	.attr	= {
+		.name = __stringify(alarm),
+		.mode = 0644,
+	},
+	.show	= alarm_show,
+	.store	= alarm_store,
+};
+
+extern struct subsystem power_subsys;
+static int alarm_add_sysfs(void)
+{
+	return sysfs_create_file(&power_subsys.kset.kobj, &alarm_attr.attr);
+}
+
+/* --------------------------------------------------------------------------
+                              FS Interface (/proc)
+   -------------------------------------------------------------------------- */
 #ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
 static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
 {
@@ -150,32 +434,6 @@ static int acpi_system_alarm_open_fs(str
 	return single_open(file, acpi_system_alarm_seq_show, PDE(inode)->data);
 }
 
-static int get_date_field(char **p, u32 * value)
-{
-	char *next = NULL;
-	char *string_end = NULL;
-	int result = -EINVAL;
-
-	/*
-	 * Try to find delimeter, only to insert null.  The end of the
-	 * string won't have one, but is still valid.
-	 */
-	next = strpbrk(*p, "- :");
-	if (next)
-		*next++ = '\0';
-
-	*value = simple_strtoul(*p, &string_end, 10);
-
-	/* Signal success if we got a good digit */
-	if (string_end != *p)
-		result = 0;
-
-	if (next)
-		*p = next;
-
-	return result;
-}
-
 static ssize_t
 acpi_system_write_alarm(struct file *file,
 			const char __user * buffer, size_t count, loff_t * ppos)
@@ -498,6 +756,9 @@ static int acpi_sleep_proc_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_wakeup_device_fops;
 
+	if(alarm_add_sysfs())
+		return -EINVAL;
+
 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
 	return 0;
 }
