From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
Date: Thu, 25 Oct 2018 22:13:49 +0200
Message-ID: <20181025201349.c4564dgc7743kosx@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <CAMz4kuJCS1_E+CUdANepYe+WpYSOwovZ9Rnu85zvTgmV9BE5+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugq6v2bge6kmq75q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJCS1_E+CUdANepYe+WpYSOwovZ9Rnu85zvTgmV9BE5+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org


--ugq6v2bge6kmq75q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Thu, Oct 25, 2018 at 10:01:55AM +0800, Baolin Wang wrote:
> Hi Sebastian,
>=20
> On 22 October 2018 at 15:43, Baolin Wang <baolin.wang@linaro.org> wrote:
> > The internal resistance of a battery is not a constant in its life cycl=
e,
> > this varies over the age of the battery or temperature and so on. But we
> > just want use one constant battery internal resistance to estimate the
> > battery capacity. Thus this patch introduces one property to present
> > the battery factory internal resistance for battery information.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Changes from v5:
> >  - None.
> >
> > Changes from v4:
> >  - None.
> >
> > Changes from v3:
> >  - Split binding into one separate patch.
> >  - Add LinusW reviewed tag.
> >
> > Changes from v2:
> >  - Rename the property.
> >  - Improve the commit message.
> >
> > Changes from v1:
> >  - New patch in v2.
> > ---
>=20
> I think this v6 patch set have addressed your comments on v5, so could
> you apply this patch set if there are no other comments? I hope this
> driver can be merged into 4.20 finally. Thanks.

Everything looks fine to me. I will merge this directly after the
4.20 merge window has been closed and linux-next is open again.
I'm not merging non-trivial, non-bugfix patches this lates during the
release process.

-- Sebastian

--ugq6v2bge6kmq75q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvSI/oACgkQ2O7X88g7
+poBrA/+KA++EX9zBEIHotTx/Qn4oktuABsscaPQY621URT5I2mNTL/TDclEc3o9
nFtw4EvEVrLWIfdPM3q2RST6JOWr1oh9/etdfT2wYBdF9Hl6Vn/L5ZVebUnyHNCf
LjsVwLKd6BjeGlIhEGc3NyLsCDYiH3yZlLrV95fmkDDyAjuKOMXjw00TG7AgH26Z
2BRNXZIc2stb4ZAJBYoHbVwpCiwHSYe6eUKI4/2Q0rgONalh1z8ZOWpzSTp32kLQ
wbQ7aBbM2pDhxJwCp0ln7yQeeT3x3ydWn5lXoUAhV9ddkG9vIIjuf/RWQ9tc/wjT
zCjgfAi4cPa6R3TQCnvky60fcE3MbCr81g8BCyh90jBCbqwtr1/R0Veoyy2QGpI7
SO/CVTurvroOyP6/F+grRNGEkQAIque6Kyw60tCGDmWPzFHsOCC7kOk91gC1s3b9
LAGY3QHu1h4Lwr6hUlewW4v+vuz32wa9vufzLoAj4+ckQvE9c7xrv9w4UbJYcTO8
ku9xD7JR/5d48rUmVp8h+jhkwTKJiL8Ckqtd8KaXQwFN2h/VCUBNYhyl2ctXlMpb
qJ3y09JvRR3mRty5ojr3ILuPsE8fTKghO/0aWDRNBpuedp2d8BUKdtJFpjjfg0sZ
KEEAciTlqelWk6Mzx03XHISQxNwvl0xvhXGWdEqBCws0n7SB60A=
=fu6Q
-----END PGP SIGNATURE-----

--ugq6v2bge6kmq75q--
