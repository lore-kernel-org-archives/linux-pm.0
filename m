From: David Brownell <david-b@pacbell.net>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sat, 26 Aug 2006 14:15:32 -0700
Message-ID: <200608261415.33353.david-b@pacbell.net>
References: <20060725124941.GD5034@ucw.cz> <20060826145920.GA1826@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060826145920.GA1826@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 26 August 2006 7:59 am, Pavel Machek wrote:

> Your new RTC driver seems to work for me (thinkpad x60), but no, I
> can't get wakeup using RTC to work:

Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
doesn't work on Linux ... hence my pleasant surprise to see it work
at last, albeit just with the RTC, on every system I tried.  (That's
using swsusp; and on the system where STR works, also STR.)

Of course, as you noted by implication, RTC wake does not involve the
mechanisms exposed by /proc/acpi/wakeup ... that surely helps.


However:

> root@amd:~# sync; /tmp/rtcwake -s $((2 * 60)) -m disk
> rtcwake: wakeup from "disk" using rtc0 at Sun Aug 27 16:54:49 2006
> root@amd:~#

That's what it should look like -- with "date" immediately after rtcwake
returns showing some time after 16:54.  That is, assuming your system
can suspend in 2 minutes ... current versions of swsusp seem to take almost
that long to write snapshots for me, on two different systems with 1GB
of RAM, so I've taken to doing "-m disk" tests with 5 minute sleeps.

So you're sure it didn't actually suspend, right?


> Any ideas? (I tried suspending to RAM, too; no change).

An updated rtcwake.c is appended, which is a bit pickier about noticing
when the write to /sys/power/state fails ... the original code was lazy
and used fwrite(), which isn't as good about fault reporting.  (I'll just
assume STR works properly on your system -- a pleasant rarity!)

So for example, check dmesg output to see if the suspend worked; the
older version of rtcwake wouldn't have noticed errors if it failed
because e.g. one driver refused to suspend.  This one should notice
and report them.

There could also be BIOS issues; folk keep mentioning issues that are
specific to the x60.  Make sure you didn't disable RTC wake there,
and that the RTC reported something like

  rtc-acpi 00:06: AT compatible RTC (S4wake) (y3k), 1 year alarm

at boot time ... if it doesn't report S4 wake capability, or you're
not actually using S4, I'd expect rtc wakeup wouldn't work except
from "real" suspend states (S1/standby, S3/STR).


> Is acpi-rtc code likely to be merged?

Likely not in its current form.  I'll post an updated version soonish,
which doesn't depend so much on PNPACPI.  One issue is how to to have
coupling to ACPI be cleaner.

- Dave


#include <stdio.h>
#include <getopt.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>

#include <linux/rtc.h>

//#define	DEBUG


/*
 * rtcwake -- enter a system sleep state until specified wakeup time.
 *
 * This uses cross-platform Linux interfaces to enter a system sleep state,
 * and leave it no later than a specified time.  It uses any RTC framework
 * driver that supports standard driver model wakeup flags.
 *
 * This is normally used like the old "apmsleep" utility, to wake from a
 * suspend state like ACPI S1 (standby) or S3 (suspend-to-RAM).  Most
 * platforms can implement those without analogues of BIOS, APM, or ACPI.
 *
 * On some systems, this can also be used like "nvram-wakeup", waking
 * from states like ACPI S4 (suspend to disk).  Not all systems have
 * persistent media that are appropriate for such suspend modes.
 */

static char		*progname;

#ifdef	DEBUG
#define	VERSION	"1.0 dev (" __DATE__ " " __TIME__ ")"
#else
#define	VERSION	"0.9"
#endif

static unsigned		verbose;

static int may_wakeup(const char *devname)
{
	char	buf[128], *s;
	FILE	*f;

	snprintf(buf, sizeof buf, "/sys/class/rtc/%s/device/power/wakeup",
			devname);
	f =3D fopen(buf, "r");
	if (!f) {
		perror(buf);
		return 0;
	}
	fgets(buf, sizeof buf, f);
	fclose(f);

	s =3D strchr(buf, '\n');
	if (!s)
		return 0;
	*s =3D 0;

	/* wakeup events could be disabled or not supported */
	return strcmp(buf, "enabled") =3D=3D 0;
}

/* all times should be in UTC */
static time_t	sys_time;
static time_t	rtc_time;

static int get_basetimes(int fd)
{
	struct tm	tm;
	time_t		offset;
	struct rtc_time	rtc;

	/* record offset of mktime(), so we can reverse it */
	memset(&tm, 0, sizeof tm);
	tm.tm_year =3D 70;
	offset =3D mktime(&tm);

	/* read system and rtc clocks "at the same time"; both in UTC */
	sys_time =3D time(0);
	if (sys_time =3D=3D (time_t)-1) {
		perror("read system time");
		return 0;
	}
	if (ioctl(fd, RTC_RD_TIME, &rtc) < 0) {
		perror("read rtc time");
		return 0;
	}

	/* convert rtc_time to normal arithmetic-friendly form */
	tm.tm_sec =3D rtc.tm_sec;
	tm.tm_min =3D rtc.tm_min;
	tm.tm_hour =3D rtc.tm_hour;
	tm.tm_mday =3D rtc.tm_mday;
	tm.tm_mon =3D rtc.tm_mon;
	tm.tm_year =3D rtc.tm_year;
	tm.tm_wday =3D rtc.tm_wday;
	tm.tm_yday =3D rtc.tm_yday;
	tm.tm_isdst =3D rtc.tm_isdst;

	if (verbose) {
		printf("\toffset  =3D %ld\n", offset);
		printf("\tsystime =3D %s", asctime(gmtime(&sys_time)));
		printf("\trtctime =3D %s", asctime(&tm));
	}

	rtc_time =3D mktime(&tm) - offset;
	if (rtc_time =3D=3D (time_t)-1) {
		perror("convert rtc time");
		return 0;
	}

	return 1;
}

static int setup_alarm(int fd, time_t *wakeup)
{
	struct tm		*tm;
	struct rtc_wkalrm	wake;

	tm =3D gmtime(wakeup);

	wake.time.tm_sec =3D tm->tm_sec;
	wake.time.tm_min =3D tm->tm_min;
	wake.time.tm_hour =3D tm->tm_hour;
	wake.time.tm_mday =3D tm->tm_mday;
	wake.time.tm_mon =3D tm->tm_mon;
	wake.time.tm_year =3D tm->tm_year;
	wake.time.tm_wday =3D tm->tm_wday;
	wake.time.tm_yday =3D tm->tm_yday;
	wake.time.tm_isdst =3D tm->tm_isdst;

	/* many rtc alarms only support up to 24 hours from 'now' ... */
	if ((rtc_time + 24 * 60 * 60) > *wakeup) {
		if (ioctl(fd, RTC_ALM_SET, &wake.time) < 0) {
			perror("set rtc alarm");
			return 0;
		}
		if (ioctl(fd, RTC_AIE_ON, 0) < 0) {
			perror("enable rtc alarm");
			return 0;
		}

	/* ... so use the "more than 24 hours" request only if we must */
	} else {
		/* avoid an extra AIE_ON call */
		wake.enabled =3D 1;

		if (ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
			perror("set rtc wake alarm");
			return 0;
		}
	}

	return 1;
}

static void suspend_system(const char *suspend)
{
	char	buf[20];
	int	f =3D open("/sys/power/state", O_WRONLY);
	int	len;
	ssize_t	n;

	if (f < 0) {
		perror("open /sys/power/state");
		return;
	}

	len =3D sprintf(buf, "%s\n", suspend) - 1;
	len =3D strlen(buf);
	n =3D write(f, buf, len);

	/* this executes after wake from suspend */
	if (n < 0)
		perror("write /sys/power/state");
	else if (n !=3D len)
		fprintf(stderr, "short write to %s\n", "/sys/power/state");
	close(f);
}

int main(int argc, char **argv)
{
	static char		*devname =3D "rtc0";
	static unsigned		seconds =3D 0;
	static char		*suspend =3D "standby";

	int		t;
	int		fd;
	time_t		alarm =3D 0;

	progname =3D strrchr(argv[0], '/');
	if (progname)
		progname++;
	else
		progname =3D argv[0];
	if (chdir("/dev/") < 0) {
		perror("chdir /dev");
		return 1;
	}

	while ((t =3D getopt(argc, argv, "d:m:s:t:Vv")) !=3D EOF) {
		switch (t) {

		case 'd':
			devname =3D optarg;
			break;

		/* what system power mode to use?  for now handle only
		 * standardized mode names; eventually when systems define
		 * their own state names, parse /sys/power/state.
		 *
		 * "on" is used just to test the RTC alarm mechanism,
		 * bypassing all the wakeup-from-sleep infrastructure.
		 */
		case 'm':
			if (strcmp(optarg, "standby") =3D=3D 0
					|| strcmp(optarg, "mem") =3D=3D 0
					|| strcmp(optarg, "disk") =3D=3D 0
					|| strcmp(optarg, "on") =3D=3D 0
					) {
				suspend =3D optarg;
				break;
			}
			printf("%s: unrecognized suspend state '%s'\n",
					progname, optarg);
			goto usage;

		/* alarm time, seconds-to-sleep (relative) */
		case 's':
			t =3D atoi(optarg);
			if (t < 0) {
				printf("%s: illegal interval %s seconds\n",
						progname, optarg);
				goto usage;
			}
			seconds =3D t;
			break;

		/* alarm time, time_t (absolute, seconds since 1/1 1970 UTC) */
		case 't':
			t =3D atoi(optarg);
			if (t < 0) {
				printf("%s: illegal time_t value %s\n",
						progname, optarg);
				goto usage;
			}
			alarm =3D t;
			break;

		case 'v':
			verbose++;
			break;

		case 'V':
			printf("%s: version %s\n", progname, VERSION);
			break;

		default:
usage:
			printf("usage: %s [options]"
				"\n\t"
				"-d rtc0|rtc1|...\t(select rtc)"
				"\n\t"
				"-m standby|mem|...\t(sleep mode)"
				"\n\t"
				"-s seconds\t\t(seconds to sleep)"
				"\n\t"
				"-t time_t\t\t(time to wake)"
				"\n\t"
				"-v\t\t\t(verbose messages)"
				"\n\t"
				"-V\t\t\t(show version)"
				"\n",
				progname);
			return 1;
		}
	}

	if (!alarm && !seconds) {
		printf("%s: must provide wake time\n", progname);
		goto usage;
	}

	/* this RTC must exist and (if we'll sleep) be wakeup-enabled */
	fd =3D open(devname, O_RDONLY);
	if (fd < 0) {
		perror(devname);
		return 1;
	}
	if (strcmp(suspend, "on") !=3D 0 && !may_wakeup(devname)) {
		printf("%s: %s not enabled for wakeup events\n",
				progname, devname);
		return 1;
	}

	/* relative or absolute alarm time, normalized to time_t */
	if (!get_basetimes(fd))
		return 1;
	if (verbose)
		printf("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n",
				alarm, sys_time, rtc_time, seconds);
	if (alarm) {
		if (alarm < sys_time) {
			printf("%s: time doesn't go backward to %s",
					progname, ctime(&alarm));
			return 1;
		}
		alarm +=3D sys_time - rtc_time;
	} else
		alarm =3D rtc_time + seconds + 1;
	if (!setup_alarm(fd, &alarm))
		return 1;

	printf("%s: wakeup from \"%s\" using %s at %s",
			progname, suspend, devname,
			ctime(&alarm));
	fflush(stdout);
	usleep(10 * 1000);

	if (strcmp(suspend, "on") !=3D 0)
		suspend_system(suspend);
	else {
		unsigned long data;

		(void) read(fd, &data, sizeof data);
	}

	if (ioctl(fd, RTC_AIE_OFF, 0) < 0)
		perror("disable rtc alarm interrupt");

	close(fd);
	return 0;
}
