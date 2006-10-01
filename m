From: Heikki Orsila <shd@zakalwe.fi>
Subject: Re: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Sun, 1 Oct 2006 20:32:52 +0300
Message-ID: <20061001173252.GB24539@zakalwe.fi>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
	<20061001152228.GA24539@zakalwe.fi>
	<20061001171032.GE2254@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061001171032.GE2254@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 01, 2006 at 07:10:32PM +0200, Pavel Machek wrote:
> On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
> > Some nitpicking about the patch follows..
> > =

> > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> > > +static long =

> > > +get_vtg(const char *vdomain)
> > > +{
> > > +	long ret =3D 0;
> > =

> > Unnecessary initialisation.
> =

> No, sorry.

In get_vtg(), if VOLTAGE_FRAMEWORK is defined then

	ret =3D vtg_get_voltage(v);

is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:

	ret =3D vtg_get_voltage(&vhandle);

Then "return ret;" follows. I cannot see a path where =

pre-initialisation of ret does anything useful. If someone removed the
#else part, the compiler would bark.

> =

> > > +static long =

> > > +set_vtg(const char *vdomain, int val)
> > > +{
> > > +	long ret =3D 0;
> > =

> > here too.
> =

> Wrong again. automatic variables are not zero initialized.

My bad, this was a mistake. If VOLTAGE_FRAMEWORK is not defined, ret =

must be initialised. (the compiler would have noticed this one :-)

>> 'int i =3D 0;' happens in many functions.

for example, omap_pm_create_point() does this.

- Heikki
