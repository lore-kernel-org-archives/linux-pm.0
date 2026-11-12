Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492093;
	b=Uz1EgVkqcOJ+gcmoCcjnbpbi3NAywpKxRollQ/KniuQvsDSKe/HO2RBQpEn3lcplJfbb
	 mfVr8tn7Hgia0QYyf4nWBKBrJOCmscSpsJGuDOT9jb7+ozMUHQYjP9TlBI2ZkV7dtLL9j
	 DM7tvRiySJ69OK9NU7klqOwjNvuRZbTX/0h/Oj0yBSEl4Eb+Nl7fKzyf3Hv4lGhFfuuxO
	 /IxRg8blJWkg4/q+cX/6gGJMFpj1LW2XoG7wG/MyRGMSZ/EO9AlnaFcv9RqYkhO//xKcp
	 yFp9UQVXElYf++1CTZcJr1FC9NRp3PGWbQ+lIycNb0ys/a5crOn053TJFN+NAki3PKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492093;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=764lZTg/NhvIYaTpTie22VuhlBpY81awqhBAg4I321U=;
	b=fFI14qQ0Mii+4AIzLYchYKOMnkCG8twgg2EqyupO65oUQqVl5+6xu7mAu1/O8afLFw2F
	 xSvef+BM4MTu0L6MxqDTlSadaG2drAqSvhQIxMhK/YiAZ8iJwQOjZtY/jnSoZKsD+1C9z
	 YZfZ7toM7cQvOmYWQoXPT4RtluESEQtyXMASfFR9FpRLfoGaYY8FxenOT2ITRfLsW38MU
	 bhjFOvYz/8wu/Grpc4mTsaEaoz9qYquH9YUpbHPkz480UJ0qzQ+qpBcx7Qwla/2IqZHWr
	 2SuVNbmnI3KxTHqy9PMOURqy2Byqg8HqdgO/RdbdDF6k9uzyItBKBKfncNrVNfUUCYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4ijPizp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0B60A6F52
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4ijPizp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8DC1F00A08
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492092;
	bh=764lZTg/NhvIYaTpTie22VuhlBpY81awqhBAg4I321U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T4ijPizp1sLAMmzqVFYSeloRM6VokFN4yLEQEykYqw/LbaVHrr0OIjn7e3Ma06K3t
	 1M12WWinSAgOQFrY1SbpSQEYpMoB1i4Uw1pAmtQCYnNLJV/4bTWeHbrOYf143HhrJw
	 L6d0ye0NVep/s3tVYMEuO8UzlSe3xf+buQYss3nLIhBxLiBwOdE64DwFG+zOyHSmko
	 pSHcKiEzuL1y9w3n7L3tPUYgehhxUsSQaWMFHACFBy6mRKGw19F2Fv45jk0fzK4hO4
	 MOEccEo3sjI53dIvXYzxPblCqcAhzYDuWMzDQOQzJAfyRgO0oLPWKT2ZxZiQrKw37r
	 pDWUCe1Sozl5g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3adfe77d35aso34693541fa.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:01:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF37uFzVb2rthWTYI1DLSF+EbjbfiuMp8Ix5ief5pGdW9WeCHnvXQIiNE379P/N2rY1OsxgDW4jYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8IAyhJLgcnXAPmhyoVtWCAy5pHxmlBPWLUZQJefpetR1ujgni
	Z/CN9ufRb0Cg/c0cMfr1N3Bp4KIS3qNPuhSMqM6lbui2sR7lluWA5DOOswF9QiqIjwU5n2uHbWB
	NpBNTnVLroPuSL4Q9VHsmImguRPZtmdk=
X-Received: by 2002:a05:651c:31c6:b0:3ad:f267:a741 with SMTP id
 38308e7fff4ca-3ae125cd6a1mr12452531fa.1.1794492091241; Thu, 12 Nov 2026
 06:01:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112131316.827708-1-christian.loehle@arm.com> <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com>
In-Reply-To: <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 15:01:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
X-Gm-Features: AclHuK-dIn4zlzG7z1bwRaMnbDOUGK6LpjeQHSgY2JmmwqDleE1ed34FxyT4g9w
Message-ID: <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Scale EPP values to the register width
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, superm1@kernel.org, 
	zhangpengjie2@huawei.com, Sumit Gupta <sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:58=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/26 13:13, Christian Loehle wrote:
> > The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit fields.
> > Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds but
> > stores zero, selecting maximum performance.
> >
> > Scale writes to supported narrow EPP registers and normalize reads to
> > 0-255. Cover both EPP setters and cppc_get_perf() so saved firmware val=
ues
> > round-trip correctly.
> >
> > Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selecti=
on")
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
> >  drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++++++--
> >  2 files changed, 47 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Docum=
entation/ABI/testing/sysfs-devices-system-cpu
> > index d219fc27a0c9..c63b5cfd993c 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -322,6 +322,11 @@ Description:     Energy performance preference
> >               performance increase/decrease and the result of the hardw=
are's
> >               energy efficiency and performance optimization policies.
> >
> > +             For supported EPP registers narrower than eight bits, val=
ues are
> > +             scaled and rounded to the nearest hardware preference.
> > +             Reads use the same 0-255 scale and may differ from the re=
quested
> > +             value due to the reduced precision.
> > +
> >               Writing to this file only has meaning when Autonomous Sel=
ection is
> >               enabled.
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 11a9f9eb6b4a..10b52163eb56 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/ktime.h>
> >  #include <linux/list.h>
> > +#include <linux/math64.h>
> >  #include <linux/mutex.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/rwsem.h>
> > @@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *highe=
st_perf)
> >  }
> >  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> >
> > +/* Keep the EPP interface on an 8-bit scale, including firmware readba=
ck. */
> > +static u64 cppc_scale_epp(const struct cpc_register_resource *reg,
> > +                       u64 epp, bool to_reg)
> > +{
> > +     unsigned int width =3D reg->cpc_entry.reg.bit_width;
> > +     u32 max;
> > +
> > +     if (reg->type !=3D ACPI_TYPE_BUFFER || width < 4 || width >=3D 8)
> > +             return epp;
> > +
> > +     max =3D BIT(width) - 1;
> > +     if (to_reg)
> > +             return DIV_ROUND_CLOSEST_ULL(epp * max,
> > +                                          CPPC_EPP_ENERGY_EFFICIENCY_P=
REF);
> > +
> > +     return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENCY_PRE=
F,
> > +                                  max);
> > +}
> > +
> >  /**
> >   * cppc_get_epp_perf - Get the epp register value.
> >   * @cpunum: CPU from which to get epp preference value.
> > @@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> >   */
> >  int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> >  {
> > -     return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
> > +     struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> > +     int ret;
> > +
> > +     ret =3D cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
> > +     if (!ret)
> > +             *epp_perf =3D cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_P=
ERF],
> > +                                        *epp_perf, false);
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> >
> > @@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
> >       bool auto_sel_non_pcc;
> >       bool epp_pcc;
> >       bool epp_non_pcc;
> > +     u64 epp;
> >       int ret;
> >
> >       if (!cpc_desc) {
> > @@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
> >
> >       auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> >       epp_set_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> > +     epp =3D cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf, true=
);
> >       if (!enable && auto_sel_reg->type =3D=3D ACPI_TYPE_INTEGER &&
> >           auto_sel_reg->cpc_entry.int_value =3D=3D 1)
> >               return -EOPNOTSUPP;
> > @@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
> >                       return ret;
> >       }
> >       if (epp_non_pcc) {
> > -             ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls->energy_pe=
rf);
> > +             ret =3D cpc_write(cpu, epp_set_reg, epp);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
> >               }
> >
> >               if (epp_pcc) {
> > -                     ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls->e=
nergy_perf);
> > +                     ret =3D cpc_write(cpu, epp_set_reg, epp);
> >                       if (ret)
> >                               goto out_unlock;
> >               }
> > @@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> >   */
> >  int cppc_set_epp(int cpu, u64 epp_val)
> >  {
> > +     struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> > +
> >       if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
> >               return -EINVAL;
> >
> > +     if (!cpc_desc)
> > +             return -ENODEV;
> > +
> > +     epp_val =3D cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
> > +                              epp_val, true);
> > +
> >       return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> >  }
> >  EXPORT_SYMBOL_GPL(cppc_set_epp);
> > @@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
> >               if (ret)
> >                       goto out_err;
> >       }
> > -     perf_ctrls->energy_perf =3D energy_perf;
> > +     perf_ctrls->energy_perf =3D cppc_scale_epp(energy_perf_reg, energ=
y_perf, false);
> >
> >       if (CPC_SUPPORTED(auto_sel_reg)) {
> >               ret =3D cpc_read(cpu, auto_sel_reg, &auto_sel);
>
> +CC Sumit's actual email, sorry about that.

So I'm assuming that this one is for Sumit to pick up and send again
along with a new version of

https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.c=
om/

Or please let me know if that is not the case.
