From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep
	"alarm" attribute in	sysfs
Date: Sat, 6 Jan 2007 14:42:22 -0800
Message-ID: <200701061442.22340.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1168083318.5619.37.camel@localhost.localdomain>
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
To: linux-pm@lists.osdl.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:
> =

> Create /sys/power/alarm.

Urg.  This doesn't work with the RTC framework, which accepts the reality
that some systems have multiple RTCs ... /sys/class/rtc/rtcN/alarm is a
much more appropriate location for that RTC's alarm.

(How to handle RTCs with multiple alarms is a different issue; I'm just
assuming for now that one of them wil be designated primary.)


> The way it works is exactly the same as /proc/acpi/alarm.
> I.e. "#echo yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports existing abso=
lute time.
> And "#echo +yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports a duration.

There was a proposal a while back to have /sys/class/rtc/rtcN/alarm
files -- for alarm-capable RTCs, they don't all have alarms -- have
only the absolute seconds.  "date" can do the math for you; e.g.

	# cd /sys/class/rtc/rtcN
	# date -d '5pm tuesday' "+%s" > alarm
	# date -d '5 hours 24 minutes 11 seconds' "+%s" > alarm
	# date -d '4pm 8 january 2007'  "+%s" > alarm

It's usually felt to be a Good Thing if the kernel doesn't have to be
in the business of parsing and validating complex input ...

(And "cat" of the alarm attribute would return either seconds since
the POSIX epoch, if the alarm's active, else the null string.)

- Dave
