Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572900;
	b=gq/bAaXh4cIC4s40Krhg3VxFdGDtniuzbVqdC8FQZxBYxxD/BxHV3cnL2MeqIWn8BDey
	 pGJ8fst9WGBo4QcrHjEm07BBp097DhsnMn6h2LhzjvM6Usn2sLDMlvePSnR8JIKou8BaW
	 IZEjlNE8itffW2K/V2L1GWEoJVG3gT1f2/rgTX8qlGCcY8uVNUMXX0ic4SkHBn97+Ck7T
	 Pph9pdFYxQtq2a0qMmWiLA9ltYafk/0PU2JAvHsB+MIDEBCqYb4gScR06hjD/fuoVaZBD
	 a9rJgD+V7G9qaFVuefPzSsfGjOwDwIjxgh8YTy1+kL6b9ggpyeSLZElMaT8xC65OQkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572900;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wv7L1JH7T0hMCKd3GIdBf1XHHTM8WmSSur8bgx//rus=;
	b=Yvp9qt65h6xLQBb8INQcH7kVy0B9FeMf3xuUwMlS262i60RSGcMrP7ryxOMvQMP+9x0m
	 ex0NdsvUUfUS0sA4EZj7I5dU0WXZ/RZfq6hkCAWoE6zjAMAr6GFAzIyWWWe9N/+MK06eb
	 n50tWDz6b/gdHMtXMi1LBqqEL+rjQInzmfwfQItERrl2lvftRpLNIf7dm4CE0NOirF4aY
	 TjEUKK3OvFJ9cEqZpIFHbbtlmbFdO+afcG9hfzv8+LqHajVg7F2ssDmDpHDJfGWCnTd8D
	 RywqteGtnpCa9ossjYmPWVoiE9uAfuP3S/HRU6qV2/LxhEcD2s/KXwds/p+Q5bPS+pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JV1NdJmc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6170606A323
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JV1NdJmc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ED71F000C5
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794572900;
	bh=wv7L1JH7T0hMCKd3GIdBf1XHHTM8WmSSur8bgx//rus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JV1NdJmcwEzSoiEcoOHtqhtCNUSl4iHQRW2HmhJl7ZPKuWMA8RCCadC9/nMfUsOgk
	 qpDEFWYlUxvxsHBC4VcL9jsj0R6ObeQszPKpOwBZI4XgWSWYap6kVsVfbrN8RO/WcC
	 onzMbbdgpV3T5GxQkfWo9Nmc+tuqo49PRfuqpczfT3OKjFO104niXKQ3LXS3tVTbFs
	 aF2ch7FO3jldEkbBZe/cDMOcClnnZZBjZrCKVGfrDaT05mH//43gaPy3nKChgjB+YS
	 ApBm0QHKtFBLEAQTLGc+sQF7HalL18gnf1IaeLgyBT0mHh5sXWfVLKCEyYeTh91fyW
	 9tc/2o161dRkQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso1431336e87.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:28:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHpVS9e/rJ/wLRd9PtMolWbxWRzADDCEvUS62vgDCNk5v9c8wz94wrgNS9SiojEmotDkRLpPQhu6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jaC3X99UUQFconH5Nxid2QOaIMxIfJ4pMgc19MuQ5TLWUcZl1
	+8CSXrvlFGXFGv9Zr/oYhXEeclOOEAlOV9R4JpHBQ0W8gdoCAcoYJxMTqbxi5ILLMnWT6NsvnrJ
	ahYnWdRaFtCcs6mskcjnvDRBqUFvoNK8=
X-Received: by 2002:a05:6512:401b:b0:5bf:c045:964a with SMTP id
 2adb3069b0e04-5c17077fef5mr890868e87.18.1794572898675; Fri, 13 Nov 2026
 04:28:18 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112131316.827708-1-christian.loehle@arm.com>
 <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com> <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
 <f8d23034-0d28-4726-829e-51cf687e5589@arm.com> <37efae02-1f49-45ff-9e51-5a6a921ed1d5@kernel.org>
 <4d9261e9-fc66-4197-b3ba-edcc98ffaaf7@arm.com> <2b72fea4-b2ba-4ae5-91e8-d5830f024b2f@arm.com>
In-Reply-To: <2b72fea4-b2ba-4ae5-91e8-d5830f024b2f@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 13:28:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g0b2iG21ExDhDjjaJN1Hwgmd53Ph690teqoRVexP1bTQ@mail.gmail.com>
X-Gm-Features: AclHuK8pVTkU2tm3MP9A3w8RL_sO0a4oBww8AReSy4DKhzJdfDPo2QO6RVBvff0
Message-ID: <CAJZ5v0g0b2iG21ExDhDjjaJN1Hwgmd53Ph690teqoRVexP1bTQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Scale EPP values to the register width
To: Christian Loehle <christian.loehle@arm.com>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjie9@hisilicon.com, zhangpengjie2@huawei.com, 
	Sumit Gupta <sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 1:22=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/26 17:19, Christian Loehle wrote:
> > On 11/12/26 17:11, Mario Limonciello wrote:
> >> On 11/12/26 08:05, Christian Loehle wrote:
> >>> On 11/12/26 14:01, Rafael J. Wysocki (Intel) wrote:
> >>>> On Thu, Nov 12, 2026 at 2:58=E2=80=AFPM Christian Loehle
> >>>> <christian.loehle@arm.com> wrote:
> >>>>>
> >>>>> On 11/12/26 13:13, Christian Loehle wrote:
> >>>>>> The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit field=
s.
> >>>>>> Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds=
 but
> >>>>>> stores zero, selecting maximum performance.
> >>>>>>
> >>>>>> Scale writes to supported narrow EPP registers and normalize reads=
 to
> >>>>>> 0-255. Cover both EPP setters and cppc_get_perf() so saved firmwar=
e values
> >>>>>> round-trip correctly.
> >>>>>>
> >>>>>> Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous se=
lection")
> >>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>>>> ---
> >>>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
> >>>>>>   drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++=
++++--
> >>>>>>   2 files changed, 47 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/=
Documentation/ABI/testing/sysfs-devices-system-cpu
> >>>>>> index d219fc27a0c9..c63b5cfd993c 100644
> >>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> >>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> >>>>>> @@ -322,6 +322,11 @@ Description:     Energy performance preferenc=
e
> >>>>>>                performance increase/decrease and the result of the=
 hardware's
> >>>>>>                energy efficiency and performance optimization poli=
cies.
> >>>>>>
> >>>>>> +             For supported EPP registers narrower than eight bits=
, values are
> >>>>>> +             scaled and rounded to the nearest hardware preferenc=
e.
> >>>>>> +             Reads use the same 0-255 scale and may differ from t=
he requested
> >>>>>> +             value due to the reduced precision.
> >>>>>> +
> >>>>>>                Writing to this file only has meaning when Autonomo=
us Selection is
> >>>>>>                enabled.
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >>>>>> index 11a9f9eb6b4a..10b52163eb56 100644
> >>>>>> --- a/drivers/acpi/cppc_acpi.c
> >>>>>> +++ b/drivers/acpi/cppc_acpi.c
> >>>>>> @@ -38,6 +38,7 @@
> >>>>>>   #include <linux/iopoll.h>
> >>>>>>   #include <linux/ktime.h>
> >>>>>>   #include <linux/list.h>
> >>>>>> +#include <linux/math64.h>
> >>>>>>   #include <linux/mutex.h>
> >>>>>>   #include <linux/rbtree.h>
> >>>>>>   #include <linux/rwsem.h>
> >>>>>> @@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *=
highest_perf)
> >>>>>>   }
> >>>>>>   EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> >>>>>>
> >>>>>> +/* Keep the EPP interface on an 8-bit scale, including firmware r=
eadback. */
> >>>>>> +static u64 cppc_scale_epp(const struct cpc_register_resource *reg=
,
> >>>>>> +                       u64 epp, bool to_reg)
> >>>>>> +{
> >>>>>> +     unsigned int width =3D reg->cpc_entry.reg.bit_width;
> >>>>>> +     u32 max;
> >>>>>> +
> >>>>>> +     if (reg->type !=3D ACPI_TYPE_BUFFER || width < 4 || width >=
=3D 8)
> >>>>>> +             return epp;
> >>>>>> +
> >>>>>> +     max =3D BIT(width) - 1;
> >>>>>> +     if (to_reg)
> >>>>>> +             return DIV_ROUND_CLOSEST_ULL(epp * max,
> >>>>>> +                                          CPPC_EPP_ENERGY_EFFICIE=
NCY_PREF);
> >>>>>> +
> >>>>>> +     return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENC=
Y_PREF,
> >>>>>> +                                  max);
> >>>>>> +}
> >>>>>> +
> >>>>>>   /**
> >>>>>>    * cppc_get_epp_perf - Get the epp register value.
> >>>>>>    * @cpunum: CPU from which to get epp preference value.
> >>>>>> @@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> >>>>>>    */
> >>>>>>   int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> >>>>>>   {
> >>>>>> -     return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
> >>>>>> +     struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> >>>>>> +     int ret;
> >>>>>> +
> >>>>>> +     ret =3D cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
> >>>>>> +     if (!ret)
> >>>>>> +             *epp_perf =3D cppc_scale_epp(&cpc_desc->cpc_regs[ENE=
RGY_PERF],
> >>>>>> +                                        *epp_perf, false);
> >>>>>> +
> >>>>>> +     return ret;
> >>>>>>   }
> >>>>>>   EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> >>>>>>
> >>>>>> @@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_p=
erf_ctrls *perf_ctrls, bool enable)
> >>>>>>        bool auto_sel_non_pcc;
> >>>>>>        bool epp_pcc;
> >>>>>>        bool epp_non_pcc;
> >>>>>> +     u64 epp;
> >>>>>>        int ret;
> >>>>>>
> >>>>>>        if (!cpc_desc) {
> >>>>>> @@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_p=
erf_ctrls *perf_ctrls, bool enable)
> >>>>>>
> >>>>>>        auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> >>>>>>        epp_set_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> >>>>>> +     epp =3D cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf,=
 true);
> >>>>>>        if (!enable && auto_sel_reg->type =3D=3D ACPI_TYPE_INTEGER =
&&
> >>>>>>            auto_sel_reg->cpc_entry.int_value =3D=3D 1)
> >>>>>>                return -EOPNOTSUPP;
> >>>>>> @@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_p=
erf_ctrls *perf_ctrls, bool enable)
> >>>>>>                        return ret;
> >>>>>>        }
> >>>>>>        if (epp_non_pcc) {
> >>>>>> -             ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls->ener=
gy_perf);
> >>>>>> +             ret =3D cpc_write(cpu, epp_set_reg, epp);
> >>>>>>                if (ret)
> >>>>>>                        return ret;
> >>>>>>        }
> >>>>>> @@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_p=
erf_ctrls *perf_ctrls, bool enable)
> >>>>>>                }
> >>>>>>
> >>>>>>                if (epp_pcc) {
> >>>>>> -                     ret =3D cpc_write(cpu, epp_set_reg, perf_ctr=
ls->energy_perf);
> >>>>>> +                     ret =3D cpc_write(cpu, epp_set_reg, epp);
> >>>>>>                        if (ret)
> >>>>>>                                goto out_unlock;
> >>>>>>                }
> >>>>>> @@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> >>>>>>    */
> >>>>>>   int cppc_set_epp(int cpu, u64 epp_val)
> >>>>>>   {
> >>>>>> +     struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> >>>>>> +
> >>>>>>        if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
> >>>>>>                return -EINVAL;
> >>>>>>
> >>>>>> +     if (!cpc_desc)
> >>>>>> +             return -ENODEV;
> >>>>>> +
> >>>>>> +     epp_val =3D cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
> >>>>>> +                              epp_val, true);
> >>>>>> +
> >>>>>>        return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> >>>>>>   }
> >>>>>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
> >>>>>> @@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_=
ctrls *perf_ctrls)
> >>>>>>                if (ret)
> >>>>>>                        goto out_err;
> >>>>>>        }
> >>>>>> -     perf_ctrls->energy_perf =3D energy_perf;
> >>>>>> +     perf_ctrls->energy_perf =3D cppc_scale_epp(energy_perf_reg, =
energy_perf, false);
> >>>>>>
> >>>>>>        if (CPC_SUPPORTED(auto_sel_reg)) {
> >>>>>>                ret =3D cpc_read(cpu, auto_sel_reg, &auto_sel);
> >>>>>
> >>>>> +CC Sumit's actual email, sorry about that.
> >>>>
> >>>> So I'm assuming that this one is for Sumit to pick up and send again
> >>>> along with a new version of
> >>>>
> >>>> https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@n=
vidia.com/
> >>>>
> >>>> Or please let me know if that is not the case.
> >>>
> >>> Yup, while it fixes an issue by itself technically, I don't think the=
re
> >>> are any affected platforms.
> >>> I'm hoping that Sumit this (and the limit-write-at-init) patch as a s=
eries
> >>> for all our convenience (and hopefully to get Sashiko to review them =
too).
> >>> (I guess I should've mentioned that in the notes.)
> >>>
> >>> And sorry about ACPI/CPPC having such high traffic lately, I'm expect=
ing once
> >>> we've got the issues ironed out and the new features supported it'll =
be a
> >>> lot more boring :)
> >>
> >> So the basic idea with this patch that the userspace interface is alwa=
ys 8 bit so higher level software will not need to know the lower level imp=
lementation detail at the expense of some granularity.
> >>
> >> Makes sense to me, but I'd like to know how realistic this hardware is=
 going to be.  If it's purely hypothetical hardware; how about proposing to=
 ASWG that this field must always be 8 bit?
> >
> > Good point, IMO it's hypothetical hardware that hopefully doesn't and w=
on't exist.
> > I'll try to raise this through that channel as well.
>
>
> Quick update on this, after proposing it, Souvik came back and made me aw=
are that
> we've already proposed this:
> https://github.com/tianocore/edk2/issues/10838
>
> I guess forget about $SUBJECT after all and I'll probe-fail <8bit and get=
 the amd-pstate
> handling correct.

So should I wait for an update of

https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.c=
om/

or is it applicable as-is?  In which case, care to give it a tag?
