From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Tue, 29 Mar 2005 01:33:58 -0500
Message-ID: <200503290133.59002.dtor_core@ameritech.net>
References: <1111951499.3503.87.camel@localhost.localdomain>
	<20050329050345.GB7937@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============054201649557331422=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329050345.GB7937-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
Cc: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============054201649557331422==
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j2T6Y3s4018935

On Tuesday 29 March 2005 00:03, Greg KH wrote:
> On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> > One of the original design goals of sysfs was to provide a standardiz=
ed
> > location to keep driver configuration attributes. =C2=A0Although sysf=
s
> > handles this very well for bus devices and class devices, there isn't
> > currently a method to export attributes for device drivers and their
> > specific bound device instances to userspace.
>=20
> Hm, what's device_create_file(), device_remove_file(), and DEVICE_ATTR(=
)
> for? =C2=A0A number of drivers use these functions today to add their o=
wn
> driver specific attributes to a device they control.
>=20
> Then, userspace can just do a simple:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ls /sys/bus/pci/drivers=
/my_foo_driver/
> to see all devices on the PCI bus that are controlled by that driver.
> Then it can go into those directories and cat out the specific
> information if needed.

It probably would be nice if all driver-specific device attributes would =
be
grouped under /sys/devices/.../<blah_device>/drvattr/* so their names wou=
ld
not clash with names of driver core attributes.

Unfortunately that would mean we are breaking userspace again...

--=20
Dmitry


--===============054201649557331422==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============054201649557331422==--
