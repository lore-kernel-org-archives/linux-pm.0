From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:39:22 +0200
Message-ID: <20070413223922.GS28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176503122.5764.109.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2007-04-14 08:25:22, Benjamin Herrenschmidt wrote:
> =

> > Hmm, I missed that. :-(
> > =

> > I think we need to make things clear: Either we add the additional hook=
s to
> > pm_ops in which case they should be taken into account in the (u)swsusp=
 code
> > too, or we don't add them at all.
> > =

> > Well, there also is one more solution.  Namely, we can add the hooks to=
 pm_ops
> > and make (u)swsusp use something else instead of pm_ops, but that would=
 require
> > some more consideration.
> =

> Well, what would be nice would be if swsusp wasn't just such a gross
> contraption completely bypassing the rest of the suspend/resume
> framework...

Great, so:

* you claim that current code is hacked up

* I claim, that if I apply the patch, the result will be ugly hack.

Good; I think you agree that Johaness' patch certainly does not fix
the uglyness of current code.

=3D> we both agree that after applying the patch, we'll have hacked-up
code. So... can we do some cleanups before hacking on it more?

If sysdevs need ordering, lets add ordering. If platform devices need
ordering, lets do it. If acpi S4 should not be using pm_ops, we should
probably fix that. If swsusp should not be called from pm_ops, we can
probably change that (but we need to keep userland interface).

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
