Received: from mail-ed2-f19.google.com (mail-ed2-f19.google.com [74.125.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2500EECB
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868911; cv=pass; b=sTYbsgxFkdfi/bk0KAzgThf9HDlaI6a8Rws+MKG9wAW5kJ7SvbpzSCdYM3fa119DKZpbb41ok3di2p8IIQ/7oudSMx07rrjKZkFxq5QieexQh+djbKsfXWYUGXbmePdtQJBrPabt257EZx7SECxcYE/zHuQf7HzwMI43uTXovbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868911; c=relaxed/simple;
	bh=x3vQNuQDJzVM8ktLCyC7Bj5o8jPukV29wkue2Gp6P8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG/Fv5pymEJMg+OjP/oiBPLA3HTPPPCy6hGrdxFSI8yEVqZ2uo777cBN11WJgZ9zX/5d7GP67RDPKQ5aVi4vESpLQ2I5w5mJZnlD9fi920idH/yo1atVj6Faqy8nK3ff2u1vaSiXxm78s+nyVebx9yRK+q/xxvIXkOVZgAfAWBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLMzLIOR; arc=pass smtp.client-ip=74.125.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLMzLIOR"
Received: by mail-ed2-f19.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so3063526a12.0
        for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 18:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789868908; cv=none;
        d=google.com; s=arc-20260327;
        b=hM36b8W9dy601R9RzOaN+mEJvp9jztW3LGFa7RFLckZc4/yprpKWY+N48Ow3dnEHRc
         ckhhtHfC+3MlZEKSGu7QgF1ZmuhMWpOMRi4HHeotzAxO9AYlN6+OBvRDzcno8GPWDeaD
         djUkWXN0WoSxwdYOqGi4ExLoYuB7eHCuD5PrhC8zwCBtW/SuhwzhQPBgrA/p+GHzr6rm
         CdwuPvY0rPvqG6UFWBT9zBZUVzMrHFj+pNg+EinJkSabC/ZSFaHdOpfXCSBtybJT/5AQ
         UMWDn5EioDKHnzxHyswXC+ySWqhkura0jpXXK4EBVFW8z2F+YS4UC6LjmcI4DS+WenrL
         8ljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gtZ34DxLz0d+WsG/fI4ru7SyHYhXKJbtjJu5a7enHP8=;
        fh=k+eii9f7U5FP5Qs3ZPTxuyKZbEhofFyKcNBObck0BLQ=;
        b=O7V/o2mxfDIUWlG/J31g8o6eCyKmkYPuFzZYmiybmmsqpsld5MoIrM7V+nNjKhuoay
         IY0l4eYuOriaM6MB5LPwdNmNmlH+B9jb6DER+U7yTP5Jw4b9GcwglQsAcd5zJchzI9m4
         nH4EB/cgNg+JTegKkniUzNUme1fnJT8ivbFagyhlCqrhBdhcLhAZ96W4woIyUxqwfrQt
         i3Gi42SmTgx15IVcnbntYhSlIWYEt4X3RK2Zy7i674JxnioZ5Xra4/T8HW+CanTl/avb
         czYGJVyERk7ZazdrBDoiPowx1GAj7OL1zP30ETRK0MahgUeKiTBSOoMl41EUS4Uz1wBG
         hZAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789868908; x=1790473708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gtZ34DxLz0d+WsG/fI4ru7SyHYhXKJbtjJu5a7enHP8=;
        b=jLMzLIOR2GTmS5GUQyWx7BEewqCUKv1kKR2DbA/X9VxusEOu2NYMtWwYafyQ21Mo3q
         jcf7zslMo0de9wLW0wdSzDZTIKbD2hUgFLA0BC9CFEu8VAJ8JB8d8RUJs/xdDnPhpqF8
         ZEbzw6xNvuU2qCrvHSKgEQPzSmuu7GP+qx+GP0A0t826VhSkyaK0MZ8zwrFMRiFb5n8Q
         NNCt69+jL9AE5WBYRXd0CEJktWhJbEkDBV5ORULCQu/l5PuP9bfc2bXbpdPIEEJcn180
         9s/MCA+3aX1DJBCPiegvf37WQf4JRQ+yxYFllbgi7QBoCO6iqK+PJgHociUjWr+fCaoM
         BPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789868908; x=1790473708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtZ34DxLz0d+WsG/fI4ru7SyHYhXKJbtjJu5a7enHP8=;
        b=rI3GdCxASgrsHrXn9AMA7t6enpNnlxdfsrZhwRlVdWggcxTmUOUJxj1pPBp3pKMT2k
         bqa0PiAI03TulkYexC6LdINfrrCw9z+8P2PqOhB+IA1kWAsVNQd35uxsayx7+tyGZo8V
         Z/tO2bTKuxyilFgpriADxYRfEbn673197YHbtP4j9LdGu7mUjQl++Auzq1+62mWlUSeQ
         ZLGp3Fmi662FhJr/PCAB4NxlncKXR5nIZh9b345JdmIFYbY8rhHURkOSCXORx4SliTRD
         QPkNz4DqfSEG0LSV0BGguKMEgprMyPTH9sbV680JwBD29/5/qZgkC3aa0OS0T7lWMa8F
         dgrw==
X-Forwarded-Encrypted: i=1; AKwUvBzC6yu2jt6hEKQIJa6JxDATA5zUp40xgIedm3DxgbDv8zgVhYjCQjJz63/nhUr4QyONVaiSe5zVAg==@vger.kernel.org
X-Gm-Message-State: AFuF++mCrxMp8qC7IRISaNHAKkzHpnlgdPDKfyX4vJ+jFLz6ZVYQMiqR
	Ahl2rM+B9se/RGzu1kwzDT6442VQudlqli6dizdrxYAxC31Z0z2zcRpYvg79PVTrR9JAl8qYevs
	2V4/5jApVvTnV5XrfyZDHm/1gziAifp8=
X-Gm-Gg: AYBFou0uR1I2agsNEOeSqZC3iSB7gHWEmQp/dQ+AcbI4dLzGR9OmVXGg1HO1+26sIx0
	egsbOCEap71gkrUMX7g/qNHvUUFcnRvZTNrduRPCKxecchoVOTCEaCXnITqK9G4UVRa/2B/8Gy+
	emuoYEZoyT5ms2LtYR/MyHl2Z4YjW5XQdwEus81XfdGvi799wocltoDAsxV0zCJmIRaIGFDLSSQ
	o3BR2Of/jnc6oMuGh0TJY+qTuohSHosqNuWek4k8NKP8nlXay49PiCldxqtAO3cL60HF6H8dZDM
	VwxnUXGUPKCDfUPwLlnI/qv7Ni32GuF2x7p6ZsedJNx2KZJfAGWxl9ig
X-Received: by 2002:a05:6402:249a:b0:6aa:734a:a08f with SMTP id
 4fb4d7f45d1cf-6aa734aa2b2mr1937361a12.38.1789868907580; Sat, 19 Sep 2026
 18:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789546118.git.zhoubinbin@loongson.cn> <6985dce54bb5b87bb232c714d236b7cb82eeb58c.1789546118.git.zhoubinbin@loongson.cn>
 <94eef31a-59e0-4a7b-8032-49ff8ae3d141@oss.qualcomm.com>
In-Reply-To: <94eef31a-59e0-4a7b-8032-49ff8ae3d141@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sun, 20 Sep 2026 09:48:15 +0800
X-Gm-Features: AcwNN1UVi50zzMsbiaTQ3enPNoBUYtT4_5z-3uQeazCpVNm5HUPCA35z9r3qdN8
Message-ID: <CAMpQs4KJ4DsTO-xEO5cH1p0Ye1qSBAe47s5dbGO4kpX+ZzLKWQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] thermal/drivers/loongson2: Add support for Loongson-2K0300
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

Thanks for your reply.

On Sat, Sep 19, 2026 at 1:02=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Binbin,
>
>
> On 9/17/26 13:15, Binbin Zhou wrote:
> > The Loongson-2K0300 thermal sensor uses a 10-bit ADC and requires
>
> The commit message says this is a 10-bit ADC, while the code uses bits
> [10:0]. The 2K0300 user manual also describes Thsens_val[10:0], i.e. an
> 11-bit value. Should this say 11-bit instead?
>
> > per-chip calibration. The calibration offset is stored in the CHIP ID
> > registers, which are accessed via syscon. The driver reads this offset
> > and applies it when converting the raw ADC value to millicelsius.
> >
> > To handle old fuse versions that cannot be calibrated correctly, the
> > driver includes a fallback formula and a validity check. Once invalid
> > data is detected, the driver falls back to the old formula for future
> > reads and warns the user.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/thermal/loongson2_thermal.c | 94 ++++++++++++++++++++++++++++=
-
> >   1 file changed, 92 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index fb4793a9bc55..8930a8a75da7 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -2,9 +2,11 @@
> >   /*
> >    * Author: zhanghongchen <zhanghongchen@loongson.cn>
> >    *         Yinbo Zhu <zhuyinbo@loongson.cn>
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> >    * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> >    */
> >
> > +#include <linux/bitfield.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/io.h>
> >   #include <linux/minmax.h>
> > @@ -13,6 +15,9 @@
> >   #include <linux/property.h>
> >   #include <linux/thermal.h>
> >   #include <linux/units.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/syscore_ops.h>
>
> Is it enabled ?

Yes, it's redundant; it must have been left over from my previous testing.
>
> >
> >   #include "thermal_hwmon.h"
> >
> > @@ -22,18 +27,34 @@
> >   #define LOONGSON2_THSENS_CTRL_LOW_REG       0x8
> >   #define LOONGSON2_THSENS_STATUS_REG 0x10
> >   #define LOONGSON2_THSENS_OUT_REG    0x14
> > +#define LOONGSON2_THSENS_CFG_REG     0x18
> >
> >   #define LOONGSON2_THSENS_INT_LO             BIT(0)
> >   #define LOONGSON2_THSENS_INT_HIGH   BIT(1)
> >   #define LOONGSON2_THSENS_INT_EN             (LOONGSON2_THSENS_INT_LO =
| \
> >                                        LOONGSON2_THSENS_INT_HIGH)
> > -#define LOONGSON2_THSENS_OUT_MASK    0xFF
> > +#define LOONGSON2_THSENS_OUT_8B_MASK 0xFF
> > +#define LOONGSON2_THSENS_OUT_11B_MASK        GENMASK(10, 0)
> > +
> > +#define LS2K0300_CHIP_ID0            0x10
> > +#define LS2K0300_CHIP_ID1            0x14
> > +#define LS2K0300_EXTERN_ID           BIT(4)
> > +#define LS2K0300_ID0_VAL_MASK                GENMASK(31, 20)
> > +#define LS2K0300_ID1_VAL_MASK                GENMASK(15, 0)
> > +
> > +#define LS2K0300_COMP_VAL_MASK               GENMASK(14, 0)
> > +#define LS2K0300_COMP_SIGN_BIT               BIT(15)
> > +
> > +#define LS2K0300_LOWEST_VALID_TEMP   (-55000)
> > +#define LS2K0300_HIGHEST_VALID_TEMP  (125000)
> >
> >   /*
> >    * This flag is used to indicate the temperature reading
> >    * method of the Loongson-2K2000
> >    */
> >   #define LS2K2000_THSENS_OUT_FLAG    BIT(0)
> > +#define LS2K0300_CHIP_ID_FLAG                BIT(1)
> > +#define LS2K0300_OLD_FUSE_FLAG               BIT(2)
> >
> >   struct loongson2_thermal_chip_data {
> >       unsigned int thermal_sensor_sel;
> > @@ -42,8 +63,11 @@ struct loongson2_thermal_chip_data {
> >   };
> >
> >   struct loongson2_thermal_data {
> > +     struct device *dev;
> >       void __iomem *ctrl_reg;
> >       void __iomem *temp_reg;
> > +     struct regmap *regmap_cfg;
> > +     u32 flags;
> >       const struct loongson2_thermal_chip_data *chip_data;
> >   };
> >
> > @@ -71,13 +95,54 @@ static int loongson2_thermal_set(struct loongson2_t=
hermal_data *data,
> >       return 0;
> >   }
> >
> > +static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, i=
nt *temp)
> > +{
> > +     struct loongson2_thermal_data *tdata =3D thermal_zone_device_priv=
(tz);
> > +     int calib_data, calib_offset, temp_mc, raw_adc;
> > +     u32 chip_id0 =3D 0, chip_id1 =3D 0;
> > +
> > +     writel(0xff03, tdata->ctrl_reg + LOONGSON2_THSENS_CFG_REG);
>
> Please no litterals or magic values in the code. Add a define with a
> self-explanatory names and a comment if it makes sense (there are other
> places in the code to be checked).

ok. I will do it.
>
> > +     raw_adc =3D FIELD_GET(LOONGSON2_THSENS_OUT_11B_MASK,
> > +                         readl(tdata->ctrl_reg + LOONGSON2_THSENS_OUT_=
REG));
>
> Why is it done at every read and not at probe time ?

`raw_adc` represents the initial temperature value, which, of course,
needs to be read each time.
>
> > +
> > +     if (tdata->flags & LS2K0300_OLD_FUSE_FLAG) {
> > +             *temp =3D raw_adc * 569 - 394700;
>
>                                 no litterals ...
>
> and don't repeat the formula, write a function for it
>
> > +             return 0;
> > +     }
> > +
> > +     regmap_read(tdata->regmap_cfg, LS2K0300_CHIP_ID0, &chip_id0);
> > +     regmap_read(tdata->regmap_cfg, LS2K0300_CHIP_ID1, &chip_id1);
>
> The return values of regmap_read() are ignored here. If accessing the
> CHIP ID registers fails, the driver will silently use zero or partially
> initialized calibration data and may report a plausible but incorrect
> temperature. Could you propagate the error instead?

Okay, and as for this static calibration data, I'll try to move it to
`probe()` (to be read only once) to avoid repeated polling in the hot
path.

Like:

static int loongson2_2k0300_read_calib(struct loongson2_thermal_data *data)
{
       u32 chip_id0, chip_id1;
       int calib_data, calib_offset;
       int ret;

       ret =3D regmap_read(data->regmap_cfg, LS2K0300_CHIP_ID0, &chip_id0);
       if (ret)
               return ret;

       ret =3D regmap_read(data->regmap_cfg, LS2K0300_CHIP_ID1, &chip_id1);
       if (ret)
               return ret;

       if (chip_id0 & LS2K0300_EXTERN_ID) {
               calib_data =3D FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id1);
               calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_dat=
a);
               if (calib_data & LS2K0300_COMP_SIGN_BIT)
                       calib_offset =3D -calib_offset;
       } else {
               calib_data =3D FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id0);
               calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_dat=
a);
       }

       data->calib_offset =3D calib_offset;
       return 0;
}

static void loongson2_2k0300_detect_old_fuse(struct
loongson2_thermal_data *data)
{
       int raw_adc, temp_mc;

       writel(0xff03, data->ctrl_reg + LOONGSON2_THSENS_CFG_REG);
       raw_adc =3D FIELD_GET(LOONGSON2_THSENS_OUT_11B_MASK,
                           readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG)=
);

       temp_mc =3D (raw_adc + data->calib_offset) * 570 - 394700;

       if (temp_mc < LS2K0300_LOWEST_VALID_TEMP ||
           temp_mc > LS2K0300_HIGHEST_VALID_TEMP)
               data->flags |=3D LS2K0300_OLD_FUSE_FLAG;
}

> > +     if (chip_id0 & LS2K0300_EXTERN_ID) {
> > +             calib_data =3D FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id1)=
;
> > +             calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_=
data);
> > +             if (calib_data & LS2K0300_COMP_SIGN_BIT)
> > +                     calib_offset =3D -calib_offset;
> > +     } else {
> > +             calib_data =3D FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id0)=
;
> > +             calib_offset =3D FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_=
data);
> > +     }
> > +
> > +     temp_mc =3D (raw_adc + calib_offset) * 570 - 394700;
>
>                                 no litterals + formula ...
>
> > +
> > +     /* For old fuse which can not read right thermal data */
> > +     if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_HI=
GHEST_VALID_TEMP) {
> > +             dev_warn_once(tdata->dev, "It's an old fuse, thermal %d i=
s not right\n", temp_mc);
>
> Improve the message please

I will remove this prompt and move this section to
`loongson2_2k0300_detect_old_fuse()` (as shown above), calling it
directly from `probe()`.
>
> > +             tdata->flags |=3D LS2K0300_OLD_FUSE_FLAG;
> > +             temp_mc =3D raw_adc * 569 - 394700;
> > +     }
> > +     *temp =3D temp_mc;
> > +
> > +     return 0;
> > +}
> > +
> >   static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, =
int *temp)
> >   {
> >       int val;
> >       struct loongson2_thermal_data *data =3D thermal_zone_device_priv(=
tz);
> >
> >       val =3D readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
> > -     *temp =3D ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
> > +     *temp =3D ((val & LOONGSON2_THSENS_OUT_8B_MASK) - HECTO) * KILO;
> >
> >       return 0;
> >   }
> > @@ -112,6 +177,11 @@ static int loongson2_thermal_set_trips(struct ther=
mal_zone_device *tz, int low,
> >       return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
> >   }
> >
> > +static const struct thermal_zone_device_ops loongson2_2k0300_of_therma=
l_ops =3D {
> > +     .get_temp =3D loongson2_2k0300_get_temp,
> > +     .set_trips =3D loongson2_thermal_set_trips,
> > +};
> > +
> >   static const struct thermal_zone_device_ops loongson2_2k1000_of_therm=
al_ops =3D {
> >       .get_temp =3D loongson2_2k1000_get_temp,
> >       .set_trips =3D loongson2_thermal_set_trips,
>
> Can you confirm the set_trips function is the same for 2k1000 and 2k0300 =
?

ok. I will check it.
>
> > @@ -134,6 +204,8 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
> >               return -ENOMEM;
> >
> >       data->chip_data =3D device_get_match_data(dev);
> > +     data->flags =3D data->chip_data->flags;
> > +     data->dev =3D dev;
> >
> >       data->ctrl_reg =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(data->ctrl_reg))
> > @@ -146,6 +218,14 @@ static int loongson2_thermal_probe(struct platform=
_device *pdev)
> >                       return PTR_ERR(data->temp_reg);
> >       }
> >
> > +     /* The chip id register is needed for Loongson-2K0300 */
> > +     if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
> > +             data->regmap_cfg =3D
> > +                     syscon_regmap_lookup_by_phandle(dev->of_node, "lo=
ongson,chipid");
> > +             if (IS_ERR(data->regmap_cfg))
> > +                     return PTR_ERR(data->regmap_cfg);
> > +     }
> > +
> >       irq =3D platform_get_irq(pdev, 0);
> >       if (irq < 0)
> >               return irq;
> > @@ -178,6 +258,12 @@ static int loongson2_thermal_probe(struct platform=
_device *pdev)
> >       return 0;
> >   }
> >
> > +static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k=
0300_data =3D {
> > +     .thermal_sensor_sel =3D 0,
> > +     .flags =3D LS2K0300_CHIP_ID_FLAG,
> > +     .thermal_ops =3D &loongson2_2k0300_of_thermal_ops,
> > +};
> > +
> >   static const struct loongson2_thermal_chip_data loongson2_thermal_ls2=
k1000_data =3D {
> >       .thermal_sensor_sel =3D 0,
> >       .flags =3D 0,
> > @@ -191,6 +277,10 @@ static const struct loongson2_thermal_chip_data lo=
ongson2_thermal_ls2k2000_data
> >   };
> >
> >   static const struct of_device_id of_loongson2_thermal_match[] =3D {
> > +     {
> > +             .compatible =3D "loongson,ls2k0300-thermal",
> > +             .data =3D &loongson2_thermal_ls2k0300_data,
> > +     },
> >       {
> >               .compatible =3D "loongson,ls2k1000-thermal",
> >               .data =3D &loongson2_thermal_ls2k1000_data,
>

--=20
Thanks.
Binbin
