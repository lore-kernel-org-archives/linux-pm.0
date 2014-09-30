From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable
 on resume
Date: Tue, 30 Sep 2014 13:42:55 +0300
Message-ID: <542A892F.60305@ti.com>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>	<542A84F7.5020005@ti.com> <CAMuHMdV-PLgG6yC=e9=qJNKbyYbUcVS-QeOaAMtf53AUOvXBvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Bsqg7vhQOn1RW1MNIHEtkFdisgAXOgmtM"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV-PLgG6yC=e9=qJNKbyYbUcVS-QeOaAMtf53AUOvXBvA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--Bsqg7vhQOn1RW1MNIHEtkFdisgAXOgmtM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30/09/14 13:41, Geert Uytterhoeven wrote:
> Hi Tomi,
>=20
> On Tue, Sep 30, 2014 at 12:24 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> On 23/09/14 15:21, Geert Uytterhoeven wrote:
>>> When the PM domain containing the HDMI hardware block is powered down=
,
>>> the HDMI register values (incl. interrupt polarity settings) are lost=
=2E
>>> During resume, after powering up the PM domain, interrupts are
>>> re-enabled, and an interrupt storm happens due to incorrect interrupt=

>>> polarity settings:
>>>
>>>     irq 163: nobody cared (try booting with the "irqpoll" option)
>>>     ...
>>>     Disabling IRQ #163
>>>
>>> To fix this, re-initialize the interrupt polarity settings, and the
>>> htop1 register block (if present), during resume.
>>>
>>> As the .suspend_noirq() and .resume_noirq() callbacks are not called
>>> when using the generic PM domain, the normal .resume() callback is us=
ed,
>>> and the device interrupt needs to be disabled/enabled manually.
>>>
>>> This fixes resume from s2ram with power down of the A4MP PM domain on=

>>> r8a7740/Armadillo.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> Is there a specific reason why the .suspend_noirq() and .resume_noirq=
()
>>> callbacks are not called when using genpd, unlike .suspend(),
>>> .suspend_late(), .resume_early(), and .resume()?
>>> ---
>>>  drivers/video/fbdev/sh_mobile_hdmi.c | 44 ++++++++++++++++++++++++++=
++++++++--
>>>  1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> Should I queue this version for 3.18, or is there some modifications y=
ou
>> think needs to be done first?
>=20
> Given the lack of documentation, I cannot do more improvements.
>=20
> Please apply this version, so the interrupt storm on resume is fixed.

Ok, queued. Thanks!

 Tomi



--Bsqg7vhQOn1RW1MNIHEtkFdisgAXOgmtM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKokvAAoJEPo9qoy8lh71ELIP/3rbhPzqLGXTElwEW89xlKCA
a9OqYfLtRCiMPMNZ9mBR3r14CCj2/2XAUMlm1xZLK5EFiDGkfwPmOKI0+4EAi0Ta
otom/8RA+Ah/xslYfD2fLME/NaRDXwJjzSz8FPByOBPnPbO8cutuxQSKs7UUGF2b
gCqzjp3tJDkVkhMA4vn/qsNz8h6DmN8Qbwq8xN966Uuft6lCo1ApbWY8TSXmizIy
CZg2SHMHVlr2Znw5HYwlqut/6RgCtgt8IHL+rtUioe8lPEY86FpMjK8C2NuA5vFV
KuHnn/ZsXgK0YOTZR9xbhv6seZjjYiUFxEpuB9We8BW4uZV6iU4uXGtxekI+n6OM
vYnCVxohSDkLXz1+P0KIpX4ZWpXVdxg4ASqJ4cvnpeY2z+1rqcKWua8KnTJ/i2FB
gqy7RTYKqKTOzjZTYtecoSB2Jx8Wt64pigZNoZ7pcoUR0FDMfd0bxIfLbjAN6XqG
yXYAes2iv0FFNHejg3j86jftz8qFge2R4naucWMUNsxd4mKitsJOPlpwCvnle9Sn
FMdGpAyEJnvWz27ooYLVSgJ0zJ8zjShBIzoOnLVjRDhKWsZ5Od7JiLMV6hG4YeA4
FYlVbh53uD6hTqFes3C6mKh1x8yN3RGE0E5EYHaXwYwruVMmf6fny/FbrNoHcCoq
Gysy1nyJciFdsEp92l1b
=/rSO
-----END PGP SIGNATURE-----

--Bsqg7vhQOn1RW1MNIHEtkFdisgAXOgmtM--
