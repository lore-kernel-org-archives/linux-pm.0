From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 09:53:18 +0100
Message-ID: <20060106085318.GH3339@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106011041.GA23899@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060106011041.GA23899@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 06-01-06 02:10:41, Dominik Brodowski wrote:
> On Thu, Jan 05, 2006 at 04:04:07PM -0800, Patrick Mochel wrote:
> > A better point, and one that would actually be useful, would be to re=
move
> > the file altogether. Let Dominik export a power file, with complete
> > control over the values, for each pcmcia device. Then you never have =
to
> > worry about breaking PCMCIA again.
>=20
> Then I'll try to push this into 2.6.16 later on; also I still need to f=
ix
> up userspace accordingly...
>=20
> BTW, ACK on the removal of power/state from me... PCMCIA shouldn't hold=
 this
> removal up.

Thanks.

> 	Dominik
>=20
>=20
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index 0252582..a4f3258 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -920,6 +920,37 @@ pcmcia_device_stringattr(prod_id2, prod_
>  pcmcia_device_stringattr(prod_id3, prod_id[2]);
>  pcmcia_device_stringattr(prod_id4, prod_id[3]);
> =20
> +
> +static ssize_t pcmcia_show_suspend(struct device *dev, struct device_a=
ttribute *attr, char *buf)
> +{
> +	struct pcmcia_device *p_dev =3D to_pcmcia_dev(dev);
> +
> +	if (p_dev->dev.power.power_state.event !=3D PM_EVENT_ON)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}

Could we get something like 'on' / 'off', or something else less
ambiquous than 0/1?

> +static ssize_t pcmcia_store_suspend(struct device *dev, struct device_=
attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct pcmcia_device *p_dev =3D to_pcmcia_dev(dev);
> +	int ret =3D 0;
> +
> +        if (!count)
> +                return -EINVAL;
> +
> +	if (p_dev->dev.power.power_state.event =3D=3D PM_EVENT_ON)
> +		ret =3D dpm_runtime_suspend(dev, PMSG_SUSPEND);
> +	else
> +		dpm_runtime_resume(dev);

So *any* write into this file just toggles suspend status? That seems
remarkably ugly. The other hunk has same issue.

> +	return ret ? ret : count;
> +
> +	return count;

Not reachable.
								Pavel
--=20
Thanks, Sharp!
