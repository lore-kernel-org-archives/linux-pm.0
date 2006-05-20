From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Sat, 20 May 2006 13:54:39 -0700
Message-ID: <200605201354.41229.david-b@pacbell.net>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605181925.30967.david-b@pacbell.net>
	<20060520172051.GL2946@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RI4bE+0v0J7qCxt"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060520172051.GL2946@elf.ucw.cz>
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
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_RI4bE+0v0J7qCxt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 20 May 2006 10:20 am, Pavel Machek wrote:

> > Things that really *must* wake up periodically should be using some API that
> > interacts with RTC alarms, and those RTC alarms should be acting as system
> > wakeup events.
> 
> But that means completely rewriting userspace.

Completely?  No.  Hardly anything really _requires_ real-time wakeups.

In any case, I can't possibly believe it's news to you that userspace code
which uses periodic polling is troublesome ... it wasn't news in the 1980s,
or 1990s, so it can't be news now.  That's not just from the power management
perspective; it also makes trouble in GUI applications architecture too.


> > There's also non-automated sleep too ... what "apmsleep" used to do when
> > you told it to suspend until 7am (or for two hours, etc).  The same thing
> > can be done with /sys/power/state and a wakeup-enabled RTC.
> 
> Yep, I should get it working one day.

See the attached.  "rtcwake -t $(( 5 * 60 * 60))" to sleep in standby mode
for five hours, or until some other wakeup event kicks in.  :)

- Dave


--Boundary-00=_RI4bE+0v0J7qCxt
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="rtcwake.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtcwake.c"

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


/*
 * rtcwake -- enter a system sleep state until specified wakeup time.
 *
 * This is sort of like the old "apmsleep" utility, except that it uses
 * cross-platform Linux calls not APM.  It expects two newish capabilities
 * in the RTC driver:  using the 2.6.16+ RTC class, and supporting the
 * driver model wakeup flags.
 *
 * This is unlike the x86 "nvram-wakeup", since it doesn't wake from
 * any kind of "soft off".  It wakes from a Linux suspend state, which
 * doesn't necessarily involve BIOS or ACPI even on x86 platforms.
 */

static char		*progname = "rtcwake";

static int may_wakeup(const char *devname)
{
	char	buf[128], *s;
	FILE	*f;

	snprintf(buf, sizeof buf, "/sys/class/rtc/%s/device/power/wakeup",
			devname);
	f = fopen(buf, "r");
	if (!f) {
		perror(buf);
		return 0;
	}
	fgets(buf, sizeof buf, f);
	fclose(f);

	s = strchr(buf, '\n');
	if (!s)
		return 0;
	*s = 0;

	return strcmp(buf, "enabled") == 0;
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
	tm.tm_year = 70;
	offset = mktime(&tm);

	/* read system and rtc clocks "at the same time"; both in UTC */
	sys_time = time(0);
	if (sys_time == (time_t)-1) {
		perror("read system time");
		return 0;
	}
	if (ioctl(fd, RTC_RD_TIME, &rtc) < 0) {
		perror("read rtc time");
		return 0;
	}

	/* convert rtc_time to normal arithmetic-friendly form */
	tm.tm_sec = rtc.tm_sec;
	tm.tm_min = rtc.tm_min;
	tm.tm_hour = rtc.tm_hour;
	tm.tm_mday = rtc.tm_mday;
	tm.tm_mon = rtc.tm_mon;
	tm.tm_year = rtc.tm_year;
	tm.tm_wday = rtc.tm_wday;
	tm.tm_yday = rtc.tm_yday;
	tm.tm_isdst = rtc.tm_isdst;

	rtc_time = mktime(&tm) - offset;
	if (rtc_time == (time_t)-1) {
		perror("convert rtc time");
		return 0;
	}

	return 1;
}

static int setup_alarm(int fd, time_t *wakeup)
{
	struct tm	tm;
	struct rtc_time	rtc;

	tm = *gmtime(wakeup);

	rtc.tm_sec = tm.tm_sec;
	rtc.tm_min = tm.tm_min;
	rtc.tm_hour = tm.tm_hour;
	rtc.tm_mday = tm.tm_mday;
	rtc.tm_mon = tm.tm_mon;
	rtc.tm_year = tm.tm_year;
	rtc.tm_wday = tm.tm_wday;
	rtc.tm_yday = tm.tm_yday;
	rtc.tm_isdst = tm.tm_isdst;

	/* some rtcs only support up to 24 hours from 'now' ... */
	if (ioctl(fd, RTC_ALM_SET, &rtc) < 0) {
		perror("set rtc alarm");
		return 0;
	}

	if (ioctl(fd, RTC_AIE_ON, 0) < 0) {
		perror("enable rtc alarm");
		return 0;
	}

	return 1;
}

static void suspend_system(const char *suspend)
{
	FILE	*f = fopen("/sys/power/state", "w");

	if (!f) {
		perror("/sys/power/state");
		return;
	}

	fprintf(f, "%s\n", suspend);
	fflush(f);

	/* this executes after wake from suspend */
	fclose(f);
}

int main(int argc, char **argv)
{
	static char		*devname = "rtc0";
	static unsigned		seconds = 60;
	static char		*suspend = "standby";

	int		t;
	int		fd;
	time_t		alarm;

	// progname = argv[0];
	if (chdir("/dev/") < 0) {
		perror("chdir /dev");
		return 1;
	}

	while ((t = getopt(argc, argv, "d:m:s:t:")) != EOF) {
		switch (t) {

		case 'd':
			devname = optarg;
			break;

		/* what system power mode to use?  for now handle
		 * only "on", "standby" and "mem".
		 */
		case 'm':
			if (strcmp(optarg, "standby") == 0
					|| strcmp(optarg, "mem") == 0
					|| strcmp(optarg, "on") == 0
					) {
				suspend = optarg;
				break;
			}
			printf("%s: suspend state %s != 'standby' || 'str'\n",
					progname, optarg);
			goto usage;

		/* absolute alarm time, seconds since 1/1 1970 UTC */
		case 's':
			t = atoi(optarg);
			if (t < 0) {
				printf("%s: illegal time_t value %s\n",
						progname, optarg);
				goto usage;
			}
			alarm = t;
			break;

		/* relative alarm time, in seconds */
		case 't':
			t = atoi(optarg);
			if (t < 0) {
				printf("%s: illegal interval %s seconds\n",
						progname, optarg);
				goto usage;
			}
			seconds = t;
			break;

		default:
usage:
			printf("usage: %s "
					"[-d rtc0|rtc1|...] "
					"[-m on|standby|str] "
					"[-s time_t] "
					"[-t relative seconds] "
					"\n",
					progname);
			return 1;
		}
	}

	/* this RTC must exist and be wakeup-enabled */
	fd = open(devname, O_RDONLY);
	if (fd < 0) {
		perror(devname);
		return 1;
	}
	if (!may_wakeup(devname)) {
		printf("%s: %s not enabled for wakeup events\n",
				progname, devname);
		return 1;
	}

	/* relative or absolute alarm time, normalized to time_t */
	if (!get_basetimes(fd))
		return 1;
	if (alarm)
		alarm -= sys_time - rtc_time;
	else
		alarm = rtc_time + seconds + 1;
	if (setup_alarm(fd, &alarm) < 0)
		return 1;

	printf("%s: wakeup from %s using %s at %s",
			progname, suspend, devname,
			ctime(&alarm));
	fflush(stdout);
	usleep(10 * 1000);

	if (strcmp(suspend, "on") != 0)
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

--Boundary-00=_RI4bE+0v0J7qCxt
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_RI4bE+0v0J7qCxt--
