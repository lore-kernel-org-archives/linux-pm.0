From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCHv2 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Fri, 28 Nov 2014 11:18:24 +0100
Message-ID: <20141128111824.533c4641@jawa>
References: <1417097577-3548-1-git-send-email-edubezval@gmail.com>
 <CAKohponu_PRrqsuMdCJDznhiO_-=iCaYPhCCad8F4WS3rNxo5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7202054068646201035=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohponu_PRrqsuMdCJDznhiO_-=iCaYPhCCad8F4WS3rNxo5A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

--===============7202054068646201035==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/2y2TlDVtawGQDt5HAADLGWz"; protocol="application/pgp-signature"

--Sig_/2y2TlDVtawGQDt5HAADLGWz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2014 13:35:49 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 27 November 2014 at 19:42, Eduardo Valentin <edubezval@gmail.com>
> wrote:
> > (I'm sorry VireshK, I am still using my normal practice) :-)
>=20
> That's fine :)
>=20
> > diff --git a/drivers/thermal/cpu_cooling.c
> > b/drivers/thermal/cpu_cooling.c index 1ab0018..bed3fa2 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -440,6 +440,11 @@ __cpufreq_cooling_register(struct device_node
> > *np, int ret =3D 0, i;
> >         struct cpufreq_policy policy;
> >
> > +       if (!cpufreq_frequency_get_table(0)) {
> > +               pr_err("cpu_cooling: cpufreq layer not ready!
> > Deferring.\n");
>=20
> Throwing an error here doesn't look to be the right thing. Ultimately
> we will register the cooling dev when probed again after some time.
>=20
> So, a pr_debug() suits more here.
>=20
> Also, this breaks existing exynos thermal drivers as they don't handle
> -EPROBE_DEFER well right now.

Unfortunately Viresh is correct here. Current (before rework) Exynos
TMU driver expects that cpu_cooling device will succeed.

>=20
> I reached here, because one of my patches had something similar to
> what you wrote. Just for this file though, haven't updated any other
> drivers though.
>=20
> Will be sending you my small patchset by end of day today, please see
> if they make any sense at all..

Best regards,
=C5=81ukasz Majewski

--Sig_/2y2TlDVtawGQDt5HAADLGWz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlR4S/EACgkQf9/hG2YwgjEx1gCfRbftm8wzjq7xJwyC/PFISSNC
dloAoMnOf3s6RAA95fkGjSsfp1md5fns
=hgj5
-----END PGP SIGNATURE-----

--Sig_/2y2TlDVtawGQDt5HAADLGWz--


--===============7202054068646201035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7202054068646201035==--
