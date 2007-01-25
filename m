From: Len Brown <lenb@kernel.org>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_3/6=5D_=5B-mm=5D=3A_ACPI=3A_du?=
	=?iso-8859-1?q?plicate_ACPI_sleep_=22alarm=22_attribute_in=09sysfs?=
Date: Wed, 24 Jan 2007 23:21:09 -0500
Message-ID: <200701242321.09850.lenb@kernel.org>
References: <1168083318.5619.37.camel@localhost.localdomain>
	<20070107111859.GB4792@ucw.cz>
	<200701071944.59470.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701071944.59470.david-b@pacbell.net>
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
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday 07 January 2007 22:44, David Brownell wrote:
> On Sunday 07 January 2007 3:19 am, Pavel Machek wrote:
> > =

> > > Create /sys/power/alarm.
> > > The way it works is exactly the same as /proc/acpi/alarm.
> > > I.e. "#echo yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports existing =
absolute time.
> > > And "#echo +yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports a duratio=
n.
> > =

> > NAK. /proc/acpi/alarm is a mess, and this just moves it to /sysfs.
> > 'One value per file', please.
> =

> Sort of like the appended patch, instead ... which doesn't need to know a
> thing about ACPI.  This is what I suggested in response to an earlier pat=
ch
> from Paul Sokolovsky.
> =

> - Dave
> =

> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	CUT HERE
> This adds a new "wakealarm" sysfs attribute to RTC class devices which
> support alarm operations and are wakeup-capable:
> =

>  - It reads as either empty, or the scheduled alarm time as seconds
>    since the POSIX epoch.  (That time may already have passed, since
>    nothing currently enforces one-shot alarm semantics...)
> =

>  - It can be written with an alarm time in the future, again seconds
>    since the POSIX epoch, which enables the alarm.
> =

>  - It can be written with an alarm time not in the future (such as 0,
>    the start of the POSIX epoch) to disable the alarm.
> =

> Usage examples, after "cd /sys/class/rtc/rtcN":
> =

>     alarm after 45 minutes:
> 	# echo $(( $(cat since_epoch) + 45 * 60 )) > wakealarm
>     alarm next tuesday evening (using GNU date):
> 	# date -d '10pm tuesday' "+%s" > wakealarm
>     disable alarm:
>     	# echo 0 > wakealarm
> =

> This resembles the /proc/acpi/alarm file in that nothing happens when
> the alarm triggers ... except possibly waking the system from sleep.
> It's also like that in a nasty way:  not much can be done to prevent
> one task from clobbering another task's alarm settings.
> =

> It differs from that file in that there's no in-kernel date parser.
> =

> Note that a few RTCs ignore rtc_wkalrm.enabled when setting alarms, or
> aren't set up correctly, so they won't yet behave with this attribute.
> =

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

How do I ask to wake up "as soon as possible"?

This is what a box that is testing suspend-resume would want to do.

thanks,
-Len
