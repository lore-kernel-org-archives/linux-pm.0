From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 09:59:21 +0100
Message-ID: <20060106085920.GI3339@elf.ucw.cz>
References: <20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106001252.GE3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33639362072543677=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============33639362072543677==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k06914DZ002867

On =C4=8Ct 05-01-06 17:37:30, Patrick Mochel wrote:
>=20
>=20
> On Fri, 6 Jan 2006, Pavel Machek wrote:
>=20
> > On =C3=84=C2=8Ct 05-01-06 16:04:07, Patrick Mochel wrote:
>=20
> > > A better point, and one that would actually be useful, would be to =
remove
> > > the file altogether. Let Dominik export a power file, with complete
> > > control over the values, for each pcmcia device. Then you never hav=
e to
> > > worry about breaking PCMCIA again.
> >
> > Fine with me.
>=20
> ACK, you beat me to it.
>=20
> And, appended is a patch to export PM controls for PCI devices. The fil=
e
> "pm_possible_states" exports the states a device supports, and "pm_stat=
e"
> exports the current state (and provides the interface for entering a
> state).
>=20
> Eventually, some drivers will want to fix up those values so that it ca=
n
> mask of states that it doesn't support, as well as offer possible devic=
e-
> specific states.
>=20
> What's interesting is that with this patch, I can see that two more
> devices on my system support D1 and D2 -- the cardbus controllers, whic=
h
> are actually bridges whose PM capabilities aren't exported via
lspci.

> +static ssize_t pm_possible_states_show(struct device * d,
> +				       struct device_attribute * a,
> +				       char * buffer)
> +{
> +	struct pci_dev * dev =3D to_pci_dev(d);
> +	char * s =3D buffer;
> +
> +	s +=3D sprintf(s, "d0");
> +	if (dev->poss_states[PCI_D1])
> +		s +=3D sprintf(s, " d1");
> +	if (dev->poss_states[PCI_D2])
> +		s +=3D sprintf(s, " d2");
> +	if (dev->poss_states[PCI_D3hot])
> +		s +=3D sprintf(s, " d3");

Could we use same states as rest of code, i.e. "D2" instead of "d2"
and "D3hot" instead of "d3"?

> +static ssize_t pm_state_show(struct device * d, struct device_attribut=
e * a,
> +			     char * buffer)

Please no space between "struct foo *" and "d".

> +	if (state =3D=3D dev->current_state)
> +		return 0;
> +
> +	if (dev->poss_states[state])
> +		ret =3D pci_set_power_state(dev, state);

So you just set the PCI power, without any coordination with driver?
How can this work?

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -106,6 +106,7 @@ struct pci_dev {
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
>=20
> +	u32		poss_states[4];

It is boolean... Can we have int instead of u32?

								Pavel

--=20
Thanks, Sharp!

--===============33639362072543677==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============33639362072543677==--
