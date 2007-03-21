From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 00:31:43 +0100
Message-ID: <20070321233143.GO6057@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<Pine.LNX.4.60.0703212325560.7211@poirot.grange>
	<20070321225730.GL6057@elf.ucw.cz>
	<200703211625.23253.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703211625.23253.david-b@pacbell.net>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > (And trust me, we can flame them if not).
> > =

> > (Anyway, my definition would be "mem" =3D=3D RAM is powered, everything
> > else is down, except for devices needed for wakeup; "standby" =3D=3D
> > something is powered that can be powered down, we'll fix that in next v=
ersion).
> =

> That implies that standby is less desirable, and wouldn't be used much.
> =

> That's a false implication.  Among other things, it may be more important
> to have various wakeup event sources at moderate power, than to go
> without them at lower power.  Simple math:  N hours at 75% power savings,
> which lets the system become fully operational at any time; versus those
> same hours at 0% power savings (full power), because STR (90% savings)
> doesn't support some essential wakeup events.

I guess we are violently agreeing. See my "except for devices needed
for wakeup". I should not have added the "next version" note, as
"standby" is useful, too.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
