From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 21:58:18 +0200
Message-ID: <20060825195818.GB9568@elf.ucw.cz>
References: <EA12F909C0431D458B9D18A176BEE4A50745C3AF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50745C3AF@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > For notebooks, devices *are* islands. powerop tries to push
> > everything-depends-on-everything model that may be good for some SoC,
> > but sucks for notebooks. We need some middle ground.
> =

> USB being enabled and causing your laptop battery to dry up is a case
> where laptop device dependency has been shown.  There are likely many
> more cases.  I would expect BIOS/chip set developers are all too aware
> of these in their sub-domains.

No, it is because USB enabled prevents cpu from sleeping; it is
actually well known.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
