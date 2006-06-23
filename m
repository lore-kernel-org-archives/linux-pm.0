From: David Brownell <david-b@pacbell.net>
Subject: wakeup events [WAS: Re*N Fix console handling]
Date: Fri, 23 Jun 2006 11:18:39 -0700
Message-ID: <200606231118.40314.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ACDnEgPNID3EBP/"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_ACDnEgPNID3EBP/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > > 	- suspend()
> > 
> > Presumably remote wakeup (WOL, whatever) gets enabled as part of the 
> > suspend().
> 
> That's what I'd expect, yes. Clearly _managing_ that whole thing is a 
> totally separate issue, but right now we don't even do that within the 
> actual device infrastructure, but on a device-by-device basis (ie ethtool 
> for networking and perhaps the RTC tools for timed wakeups?).

We already have per-device wakeup flags, manageable from userspace, which
in some cases need to be augmented by class-specific tools.

  - Network links need something like ethtool so that different
    classes of wakeup events can be managed ... different controllers
    support different events, and one network uses different events
    than another.

  - Likewise for RTC ... see the attached userspace code, which gives
    a direct "when to wake up" hook.  Not all of the RTC drivers report
    themselves as wakeup-capable yet though.  Heck, the x86 RTC driver
    doesn't even use the new framework!  (And I suspect that ACPI
    probably wants to manage RTC wakeup on x86, too... I've never seen
    /proc/acpi/wakeup listing an RTC, but I know those RTCs can indeed
    trigger system wakeup.)

The "rtcwake" thing is only needed to package a "go to sleep until 4am"
model for users, it only uses generic kernel mechanisms.  That is, the
RTC usage is typical of most drivers (including USART, USB host, USB
peripheral, removable CF/MMC/... media):  all the driver needs to know
is whether a given device can and should be a wakeup event source, so
that suspend() will leave a few extra things active.


> In fact, exactly because different devices have so fundamentally different 
> notions of what a wakup event is, I think that's the only really workable 
> option: have a device-specific setup phase long before, and have 
> "suspend()" just then implement whatever that was.
> 
> In other words, I don't see how we could even _have_ some "generic 
> wake-event setup" at this level.
> 
> But I haven't thought about it that much.

I think the current not-yet-widely-supported per-device wakeup flags
are about as generic as it can get.  Hardly anything needs the variety
of wakeup event sources that network links can provide.

But again, not many drivers have a clue yet about how to enable the wakeup
events.  And on x86 they can't really get one until the /proc/acpi/wakeup
stuff integrates with the driver model ... that's supposed to suffice for
things like PS2 keyboards and mice.

- Dave


--Boundary-00=_ACDnEgPNID3EBP/
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
 * This is unlike the x86 "nvram-wakeup", since it doesn't wake from any
 * kind of "soft off".  It wakes from a "real" Linux suspend state, which
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
		 * only "on", "standby" and "mem".  "on" is mostly
		 * useful for testing the RTC alarm mechanism,
		 * without putting the whole system to sleep.
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

--Boundary-00=_ACDnEgPNID3EBP/
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_ACDnEgPNID3EBP/--
