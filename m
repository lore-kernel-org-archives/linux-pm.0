From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 08:38:37 -0800
Message-ID: <200503240838.37628.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<20050324095910.GD1354@elf.ucw.cz>
	<Pine.LNX.4.50.0503240746290.24692-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48725291647244973=="
In-Reply-To: <Pine.LNX.4.50.0503240746290.24692-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============48725291647244973==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 March 2005 7:48 am, Patrick Mochel wrote:
> 
> On Thu, 24 Mar 2005, Pavel Machek wrote:
> 
> > Seems to me that suspend-to-RAM and suspend-to-DISK make sense, and
> > cover 90% of what people want to do. Add "standby" for "fast
> > suspend-to-RAM" and you cover even ARM. I'd say that's good enuogh.
> 
> We can treat STR and Standby nearly identically, exceptions being what we
> do with the CPU, and what power states the devices enter. But, are there
> any others?

Quite possibly.  Also look at the Montavista DPM stuff, where the
operating points are a superset of those CPU states ...


> What about this "big sleep" and "deep sleep" stuff? What platform were
> those for? Is there documentation about them?

The terms apply at least to OMAP, and there's plenty of documentation
for those chips.  Look at the OMAP 5912 docs:

  http://focus.ti.com/omap/docs/omapgenpage.tsp?navigationId=12341&templateId=5663&path=templatedata/cm/omapproc/data/omap5912

You'll have to register to get those (vs an NDA for an almost-identical
version used inside cell phones -- yes, some Linux based ones too! -- which
is one-big-PDF instead of lots of little one-per-chapter ones) and then
the "Power Management" reference guide, SPRU753, talks about those details.

Other platforms could use the same names differently of course.  Capsule
summary, "deep" means there's only a 32KHz clock, while "big" means the
48 MHz one is available to peripherals that need it (UARTs, USB, MMC/SD,
camera, and so forth).

Other ARM SOCs have similar distinctions; you might look at the Atmel
AT91rm9200 for one that's a lot simpler (and where Linux support isn't
quite as mature).

- Dave



--===============48725291647244973==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48725291647244973==--
