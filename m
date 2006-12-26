From: Pavel Machek <pavel@ucw.cz>
Subject: Re: USB power usage
Date: Tue, 26 Dec 2006 15:40:08 +0100
Message-ID: <20061226144008.GA2062@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0612252245310.29662-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0612252245310.29662-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>, kernel list <linux-kernel@vger.kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Couple of watts is not that bad, considering usb still eats 4W more
> > than it should.
> =

> The USB autosuspend mechanism has been present for a while in -mm and is
> included in 2.6.20-rc (although you have to turn on CONFIG_USB_SUSPEND,
> which is off by default -- it would be nice to change that).  Has anybody
> tried doing some real-world measurements to see if it actually makes a
> significant improvement in power usage?

I did measurements while in -mm, and yes it helped. And yes,
it works in 2.6.20-rc2, too:

root@amd:~# cat /proc/acpi/battery/BAT0/state ; sleep 20; cat
/proc/acpi/battery/BAT0/state ; sleep 20; cat
/proc/acpi/battery/BAT0/state ; sleep 20
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            14245 mW
remaining capacity:      50020 mWh
present voltage:         15793 mV

(turned off bluetooth hanging off USB here).

present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            11650 mW
remaining capacity:      49940 mWh
present voltage:         15830 mV
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            10935 mW
remaining capacity:      49870 mWh
present voltage:         15826 mV
root@amd:~#

As you can see, it saves ~3.5W, which is huge deal on machine that
eats 11W total.

(X60 owners, get 2.6.20, and _disable that bluetooth_ while not in use).
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
