From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2/2] clk_must_disable() implementation on AT91
Date: Fri, 23 Mar 2007 13:21:58 +0100
Message-ID: <20070323122158.GE9667@elf.ucw.cz>
References: <200703221108.21861.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221108.21861.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> This supports the new clk_must_disable() interface for AT91 systems:
> =

>  - Implement the call, replacing at91_suspend_entering_slow_clock()
>    and eliminating various "that's not exported" build warnings;
> =

>  - Use it in three drivers: USB Host, USB Peripheral, and RS232 serial.
> =

> Briefly, those are three of the drivers that need to act differently when
> going into deeper sleep states (suspend-to-RAM, vs standby), since among
> other things they can't act as wakeup event sources without using the
> clocks which are disabled in those deeper sleep states.
> =

> (The at91_ethernet driver would be another such driver, but it doesn't
> currently implement wake-on-LAN even in the "standby" mode.)
> =

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

FWIW, it looks okay to me. But you probably need to cc akpm if you
want it merged...

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
