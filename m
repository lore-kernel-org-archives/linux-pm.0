From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Tue, 27 Mar 2007 14:05:43 +0200
Message-ID: <20070327120543.GF5161@elf.ucw.cz>
References: <200703221905.l2MJ5VEU017196@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221905.l2MJ5VEU017196@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | > And latency may be ignorable in a laptop environment, but it absolute=
ly
> | > isn't in embedded devices, which users expect to operate immediately,=
 as
> | > though they were gear-driven rather than computer-driven.
> | =

> | What latency are you talking about? Powering up piece of hw takes one
> | milisecond or something. If your /dev/dsp takes 3 seconds to power up,
> | you probably need userspace policy daemon. But that is not the case,
> | hw takes few miliseconds to wake up.
> =

> Sure, but *some* devices take substantially longer to power up or
> down.  If you insist that the driver should make the power down
> decision, then you lump high-latency and low-latency devices together,
> even though high-latency devices might be better served by separating
> the semantics.

High-latency devices indeed may be served better by separating the
semantics. Fortunately the high-latency (we are talking >50msec here,
right?) are rare enough... Like "none" in most embedded
systems... Actually only common high-latency device is harddrive
(spinup/spindown), and that's already handled specially with userspace
hooks.

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
