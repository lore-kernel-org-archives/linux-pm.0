From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 09:00:14 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240858200.13683-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<20050324095910.GD1354@elf.ucw.cz>
	<Pine.LNX.4.50.0503240746290.24692-100000@monsoon.he.net>
	<200503240838.37628.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65005631776910988=="
In-Reply-To: <200503240838.37628.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============65005631776910988==
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Thu, 24 Mar 2005, David Brownell wrote:

> On Thursday 24 March 2005 7:48 am, Patrick Mochel wrote:

> > What about this "big sleep" and "deep sleep" stuff? What platform were
> > those for? Is there documentation about them?
>
> The terms apply at least to OMAP, and there's plenty of documentation
> for those chips.  Look at the OMAP 5912 docs:
>
>   http://focus.ti.com/omap/docs/omapgenpage.tsp?navigationId=12341&templateId=5663&path=templatedata/cm/omapproc/data/omap5912
>
> You'll have to register to get those (vs an NDA for an almost-identical
> version used inside cell phones -- yes, some Linux based ones too! -- which
> is one-big-PDF instead of lots of little one-per-chapter ones) and then
> the "Power Management" reference guide, SPRU753, talks about those details.

Thanks.

> Other platforms could use the same names differently of course.  Capsule
> summary, "deep" means there's only a 32KHz clock, while "big" means the
> 48 MHz one is available to peripherals that need it (UARTs, USB, MMC/SD,
> camera, and so forth).

It sounds like they refer to low-power states in which the system is still
operating, which are distinct from the STD/STR/Standby that we're used to
that are non-operational low-power states. Is that correct?


	Pat

--===============65005631776910988==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65005631776910988==--
