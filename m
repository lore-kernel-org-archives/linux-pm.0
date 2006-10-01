From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Sun, 1 Oct 2006 19:37:16 +0200
Message-ID: <20061001173716.GB2253@elf.ucw.cz>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
	<20061001152228.GA24539@zakalwe.fi>
	<20061001171032.GE2254@elf.ucw.cz>
	<20061001173252.GB24539@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061001173252.GB24539@zakalwe.fi>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Heikki Orsila <shd@zakalwe.fi>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Some nitpicking about the patch follows..
> > > =

> > > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > > > +static long =

> > > > +get_vtg(const char *vdomain)
> > > > +{
> > > > +	long ret =3D 0;
> > > =

> > > Unnecessary initialisation.
> > =

> > No, sorry.
> =

> In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
> =

> 	ret =3D vtg_get_voltage(v);
> =

> is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
> =

> 	ret =3D vtg_get_voltage(&vhandle);
> =

> Then "return ret;" follows. I cannot see a path where =

> pre-initialisation of ret does anything useful. If someone removed the
> #else part, the compiler would bark.

Ahha, sorry, I did not look at this kind of context.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
