From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Wed, 14 Jun 2006 12:25:13 +0200
Message-ID: <20060614102513.GA28536@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131430380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606131430380.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Not a lot of space in the RTC, but it's the only piece of hardware that i=
s =

> (a) reachable at all times, regardless of any other setup and (b) doesn't =

> lose it state or have firmware reset the memory of at boot.
> =

> Side note: you really don't want to do this unless you have an external =

> time-source like NTP that resets the clock to the right value after the =

> boot is done ;)

Clever hack, I'd say. I used hardware debugger last time I was trying
to debug this, but I guess that's just not an option in mac mini case...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
