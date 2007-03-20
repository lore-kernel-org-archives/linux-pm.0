From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 10:43:52 +0100
Message-ID: <20070320094352.GF3922@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174383407.3770.3.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Cliff Brake <cbrake@accelent.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>, Patrick Mochel <mochelp@infinity.powertie.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Is the pm_disk_mode still bitmask? If yes, say so.
> > =

> > ...no, it does not appear so.
> =

> No, I should have explained. Since the prepare/enter/finish callbacks
> aren't told what the chosen pm_disk_mode is, there is no point in
> allowing multiple since they can't differentiate. Changing that is
> something that could be done, but doesn't seem necessary since ACPI is
> the only user.

I guess we'll have more such users in future.

> > Please don't do this. We want to keep the "use platform if available"
> > behaviour. [Changing platform->shutdown is really _big_ change,
> > independend from any cleanups, and it needs to go separate at the very
> > least. It will break some machines.]
> =

> As far as I can tell "use platform if available" means "use platform
> when ACPI pm_ops are present" since that's the only pm_ops that has
> platform. And notice that I change the default when pm_ops are
> registered.

i did not look _that_ closely. As long as platform is still default on
acpi systems, we are okay.

> However, using PM_DISK_PLATFORM by default w/o pm_ops support is *wrong*
> as I explained previously since it leads to user-interface
> inconsistencies, the user can switch *away* from platform but *not back*
> to platform.

No argument about that.



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
