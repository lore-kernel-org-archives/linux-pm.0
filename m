From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] Add some basic resume trace facilities
Date: Tue, 13 Jun 2006 14:35:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131430380.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


Considering that there isn't a lot of hw we can depend on during
resume, this is about as good as it gets.

Use "#include <linux/resume-trace.h>", and then sprinkle TRACE_RESUME(0) =

commands liberally over the driver that you're trying to figure out why =

and where it hangs. Expect to waste a _lot_ of time, but at least this =

gives you _some_ chance to actually debug it, instead of just staring at a =

dead machine.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Not a lot of space in the RTC, but it's the only piece of hardware that is =

(a) reachable at all times, regardless of any other setup and (b) doesn't =

lose it state or have firmware reset the memory of at boot.

Side note: you really don't want to do this unless you have an external =

time-source like NTP that resets the clock to the right value after the =

boot is done ;)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 8831303..509af98 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -37,6 +37,13 @@ SECTIONS
 =

   RODATA
 =

+  . =3D ALIGN(4);
+  __tracedata_start =3D .;
+  .tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {
+	*(.tracedata)
+  }
+  __tracedata_end =3D .; =

+
   /* writeable */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index c0219ad..adc4250 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,5 +1,5 @@
 obj-y			:=3D shutdown.o
-obj-$(CONFIG_PM)	+=3D main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+=3D main.o suspend.o resume.o runtime.o sysfs.o trace.o
 =

 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS +=3D -DDEBUG
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
new file mode 100644
index 0000000..bcc5f12
--- /dev/null
+++ b/drivers/base/power/trace.c
@@ -0,0 +1,228 @@
+/*
+ * drivers/base/power/trace.c
+ *
+ * Copyright (C) 2006 Linus Torvalds
+ *
+ * Trace facility for suspend/resume problems, when none of the
+ * devices may be working.
+ */
+
+#include <linux/resume-trace.h>
+#include <linux/rtc.h>
+
+#include <asm/rtc.h>
+
+#include "power.h"
+
+/*
+ * Horrid, horrid, horrid.
+ *
+ * It turns out that the _only_ piece of hardware that actually
+ * keeps its value across a hard boot (and, more importantly, the
+ * POST init sequence) is literally the realtime clock.
+ *
+ * Never mind that an RTC chip has 114 bytes (and often a whole
+ * other bank of an additional 128 bytes) of nice SRAM that is
+ * _designed_ to keep data - the POST will clear it. So we literally
+ * can just use the few bytes of actual time data, which means that
+ * we're really limited.
+ *
+ * It means, for example, that we can't use the seconds at all
+ * (since the time between the hang and the boot might be more
+ * than a minute), and we'd better not depend on the low bits of
+ * the minutes either.
+ *
+ * There are the wday fields etc, but I wouldn't guarantee those
+ * are dependable either. And if the date isn't valid, either the
+ * hw or POST will do strange things.
+ *
+ * So we're left with:
+ *  - year: 0-99
+ *  - month: 0-11
+ *  - day-of-month: 1-28
+ *  - hour: 0-23
+ *  - min: (0-30)*2
+ *
+ * Giving us a total range of 0-16128000 (0xf61800), ie less
+ * than 24 bits of actual data we can save across reboots.
+ *
+ * And if your box can't boot in less than three minutes,
+ * you're screwed.
+ *
+ * Now, almost 24 bits of data is pitifully small, so we need
+ * to be pretty dense if we want to use it for anything nice.
+ * What we do is that instead of saving off nice readable info,
+ * we save off _hashes_ of information that we can hopefully
+ * regenerate after the reboot.
+ *
+ * In particular, this means that we might be unlucky, and hit
+ * a case where we have a hash collision, and we end up not
+ * being able to tell for certain exactly which case happened.
+ * But that's hopefully unlikely.
+ *
+ * What we do is to take the bits we can fit, and split them
+ * into three parts (16*997*1009 =3D 16095568), and use the values
+ * for:
+ *  - 0-15: user-settable
+ *  - 0-996: file + line number
+ *  - 0-1008: device
+ */
+#define USERHASH (16)
+#define FILEHASH (997)
+#define DEVHASH (1009)
+
+#define DEVSEED (7919)
+
+static unsigned int dev_hash_value;
+
+static int set_magic_time(unsigned int user, unsigned int file, unsigned i=
nt device)
+{
+	unsigned int n =3D user + USERHASH*(file + FILEHASH*device);
+
+	// June 7th, 2006
+	static struct rtc_time time =3D {
+		.tm_sec =3D 0,
+		.tm_min =3D 0,
+		.tm_hour =3D 0,
+		.tm_mday =3D 7,
+		.tm_mon =3D 5,	// June - counting from zero
+		.tm_year =3D 106,
+		.tm_wday =3D 3,
+		.tm_yday =3D 160,
+		.tm_isdst =3D 1
+	};
+
+	time.tm_year =3D (n % 100);
+	n /=3D 100;
+	time.tm_mon =3D (n % 12);
+	n /=3D 12;
+	time.tm_mday =3D (n % 28) + 1;
+	n /=3D 28;
+	time.tm_hour =3D (n % 24);
+	n /=3D 24;
+	time.tm_min =3D (n % 20) * 3;
+	n /=3D 20;
+	set_rtc_time(&time);
+	return n ? -1 : 0;
+}
+
+static unsigned int read_magic_time(void)
+{
+	struct rtc_time time;
+	unsigned int val;  =

+
+	get_rtc_time(&time);
+	printk("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
+		time.tm_hour, time.tm_min, time.tm_sec,
+		time.tm_mon, time.tm_mday, time.tm_year);
+	val =3D time.tm_year;				/* 100 years */
+	if (val > 100)
+		val -=3D 100;
+	val +=3D time.tm_mon * 100;			/* 12 months */
+	val +=3D (time.tm_mday-1) * 100 * 12;		/* 28 month-days */
+	val +=3D time.tm_hour * 100 * 12 * 28;		/* 24 hours */
+	val +=3D (time.tm_min / 3) * 100 * 12 * 28 * 24;	/* 20 3-minute intervals=
 */
+	return val;
+}
+
+/*
+ * This is just the sdbm hash function with a user-supplied
+ * seed and final size parameter.
+ */
+static unsigned int hash_string(unsigned int seed, const char *data, unsig=
ned int mod)
+{
+	unsigned char c;
+	while ((c =3D *data++) !=3D 0) {
+		seed =3D (seed << 16) + (seed << 6) - seed + c;
+	}
+	return seed % mod;
+}
+
+void set_trace_device(struct device *dev)
+{
+	dev_hash_value =3D hash_string(DEVSEED, dev->bus_id, DEVHASH);
+}
+
+/*
+ * We could just take the "tracedata" index into the .tracedata
+ * section instead. Generating a hash of the data gives us a
+ * chance to work across kernel versions, and perhaps more
+ * importantly it also gives us valid/invalid check (ie we will
+ * likely not give totally bogus reports - if the hash matches,
+ * it's not any guarantee, but it's a high _likelihood_ that
+ * the match is valid).
+ */
+void generate_resume_trace(void *tracedata, unsigned int user)
+{
+	unsigned short lineno =3D *(unsigned short *)tracedata;
+	const char *file =3D *(const char **)(tracedata + 2);
+	unsigned int user_hash_value, file_hash_value;
+
+	user_hash_value =3D user % USERHASH;
+	file_hash_value =3D hash_string(lineno, file, FILEHASH);
+	set_magic_time(user_hash_value, file_hash_value, dev_hash_value);
+}
+
+extern char __tracedata_start, __tracedata_end;
+static int show_file_hash(unsigned int value)
+{
+	int match;
+	char *tracedata;
+
+	match =3D 0;
+	for (tracedata =3D &__tracedata_start ; tracedata < &__tracedata_end ; tr=
acedata +=3D 6) {
+		unsigned short lineno =3D *(unsigned short *)tracedata;
+		const char *file =3D *(const char **)(tracedata + 2);
+		unsigned int hash =3D hash_string(lineno, file, FILEHASH);
+		if (hash !=3D value)
+			continue;
+		printk("  hash matches %s:%u\n", file, lineno);
+		match++;
+	}
+	return match;
+}
+
+static int show_dev_hash(unsigned int value)
+{
+	int match =3D 0;
+	struct list_head * entry =3D dpm_active.prev;
+
+	while (entry !=3D &dpm_active) {
+		struct device * dev =3D to_device(entry);
+		unsigned int hash =3D hash_string(DEVSEED, dev->bus_id, DEVHASH);
+		if (hash =3D=3D value) {
+			printk("  hash matches device %s\n", dev->bus_id);
+			match++;
+		}
+		entry =3D entry->prev;
+	}
+	return match;
+}
+
+static unsigned int hash_value_early_read;
+
+static int early_resume_init(void)
+{
+	hash_value_early_read =3D read_magic_time();
+	return 0;
+}
+
+static int late_resume_init(void)
+{
+	unsigned int val =3D hash_value_early_read;
+	unsigned int user, file, dev;
+
+	user =3D val % USERHASH;
+	val =3D val / USERHASH;
+	file =3D val % FILEHASH;
+	val =3D val / FILEHASH;
+	dev =3D val /* % DEVHASH */;
+
+	printk("  Magic number: %d:%d:%d\n", user, file, dev);
+	show_file_hash(file);
+	show_dev_hash(dev);
+	return 0;
+}
+
+core_initcall(early_resume_init);
+late_initcall(late_resume_init);
diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
index cef08db..4087037 100644
--- a/include/asm-generic/rtc.h
+++ b/include/asm-generic/rtc.h
@@ -114,6 +114,7 @@ #endif
 /* Set the current date and time in the real time clock. */
 static inline int set_rtc_time(struct rtc_time *time)
 {
+	unsigned long flags;
 	unsigned char mon, day, hrs, min, sec;
 	unsigned char save_control, save_freq_select;
 	unsigned int yrs;
@@ -131,7 +132,7 @@ #endif
 	if (yrs > 255)	/* They are unsigned */
 		return -EINVAL;
 =

-	spin_lock_irq(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 #ifdef CONFIG_MACH_DECSTATION
 	real_yrs =3D yrs;
 	leap_yr =3D ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
@@ -152,7 +153,7 @@ #endif
 	 * whether the chip is in binary mode or not.
 	 */
 	if (yrs > 169) {
-		spin_unlock_irq(&rtc_lock);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 		return -EINVAL;
 	}
 =

@@ -187,7 +188,7 @@ #endif
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
 =

-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 =

 	return 0;
 }
diff --git a/include/linux/resume-trace.h b/include/linux/resume-trace.h
new file mode 100644
index 0000000..e2e1e14
--- /dev/null
+++ b/include/linux/resume-trace.h
@@ -0,0 +1,21 @@
+#ifndef RESUME_TRACE_H
+#define RESUME_TRACE_H
+
+struct device;
+extern void set_trace_device(struct device *);
+extern void generate_resume_trace(void *tracedata, unsigned int user);
+
+#define TRACE_DEVICE(dev) set_trace_device(dev)
+#define TRACE_RESUME(user) do {				\
+	void *tracedata;				\
+	asm volatile("movl $1f,%0\n"			\
+		".section .tracedata,\"a\"\n"		\
+		"1:\t.word %c1\n"			\
+		"\t.long %c2\n"				\
+		".previous"				\
+		:"=3Dr" (tracedata)			\
+		: "i" (__LINE__), "i" (__FILE__));	\
+	generate_resume_trace(tracedata, user);		\
+} while (0)
+
+#endif
