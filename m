From: Pavel Machek <pavel@ucw.cz>
Subject: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sat, 26 Aug 2006 16:59:20 +0200
Message-ID: <20060826145920.GA1826@elf.ucw.cz>
References: <20060725124941.GD5034@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060725124941.GD5034@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-kernel@vger.kernel.org, david-b@pacbell.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > p.s. A followup message will include a userspace program which
> >      makes it easier to try the RTC wakeup mechanism.
> =

> For example, if your system actually supports RTC wakeup correctly:
> =

> =A0=A0=A0=A0=A0=A0=A0=A0rtcwake -t $(date -u -d 'tomorrow 6:30am' +'%s') =
-m mem
> =

> will set up the system to wake up tomorrow at 6:30am, then suspend-to-RAM=
 by
> writing "mem" to /sys/power/state. =A0
> =

> Or for testing kernels, unattended scripts like this may help:
> =

> =A0=A0=A0=A0=A0=A0=A0=A0while true
> =A0=A0=A0=A0=A0=A0=A0=A0do
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0echo "suspend-to-disk for=
 10 minutes starting $(date)"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rtcwake -s $((10 * 60)) -=
m disk
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sleep 500
> =A0=A0=A0=A0=A0=A0=A0=A0done
> =

> If there are many RTC utilities out there that aren't x86-specific, I did=
n't
> happen to find them.  Ergo this one.

Your new RTC driver seems to work for me (thinkpad x60), but no, I
can't get wakeup using RTC to work:

root@amd:~# echo HDEF > /proc/acpi/wakeup
root@amd:~# cat /proc/acpi/wakeup
Device  Sleep state     Status
 LID       3            * enabled
SLPB       3            * enabled
DURT       3             enabled
EXP0       4             enabled
EXP1       4             enabled
EXP2       4             enabled
EXP3       4             enabled
PCI1       4             enabled
USB0       3             enabled
USB1       3             enabled
USB2       3             enabled
USB7       3             enabled
HDEF       4             enabled
root@amd:~# sync
root@amd:~# sync; /tmp/rtcwake -s $((2 * 60)) -m disk
rtcwake: wakeup from "disk" using rtc0 at Sun Aug 27 16:54:49 2006
root@amd:~#

Any ideas? (I tried suspending to RAM, too; no change).

Is acpi-rtc code likely to be merged?
							Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
