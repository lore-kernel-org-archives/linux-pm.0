Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690ED357D1C
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568512; cv=pass; b=q0pSudXRcIMcW/VAj6/ujGF6fQ/mLfwJ4WJ+JE+UibNHFglNb1fKSNqo+8jaaJZstEJddjC3vSY8IRpkcp3Rtph5s0WnrcU5gFfjAgAt/5EuK+4IG65vs84HuTQB/vnkodSQ/jAdZJnmDmiXOgv5JSu8a4xcNRxBTC4pwbl8Big=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568512; c=relaxed/simple;
	bh=LfcVaG8MSoLybwq7I+cGS/0geSQDT90LoxEK6iJoQms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFNc7jAkin/vV2M6nLaQN512eAcdi8PiMWouoM64QYek/wFGUNdWGz1HG/LMlAqhr6sENSyzW8JTmE2aaYsfFxLCRXBCoWY8fajHnJYcKs5Z6Sqj8tbY4tNlsi4rep/HdKO69RSUnUA8yo6AeLRFYYh6wxkNInZZxAw87sVIQ34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLjXtwIT; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLjXtwIT"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bcd3c190f71so380475766b.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 23:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568502; cv=none;
        d=google.com; s=arc-20240605;
        b=lJktuQ3/4d3+kONqXlqSLqm8vFODTgwH1oZ2d7mq5Fflzp1gTpoPmlRig97PvcgMru
         fpcktuQYharBNBWHHHsvXaT0y9oMnB8w4b+FHC6SAY+3N2Xp8n07nvvtiCZeku8uD6EJ
         prXxcqDIo3XPxWjU8gIi6C+7qKPEYuKLVDHvaIZdt4tWXPcmxvNGVycNSzLKhDUzPQjN
         jYceL0CypwvCkUGTflC3Wg4FzmvyQBjUDBXYvfT8DdnNYwsGQrIDQG9bFPNVZZkVWIHE
         niaOYXrJtGN76owujKBJ0fYD/UQT6yWMbNNLK1DWHgU6OJiew05E9pa44KVblHGfGnoe
         3BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        fh=LDw8B5VbXwuKigIZ+kghwVv8GEQZjVxzuHbn4RzB/eo=;
        b=SEBuy32K0KKp6fLLU0ZrgHbBIPyPNcm5EYmtaZrXH8nYxSgFXU6Q3LJvnsJYL2Yknp
         haCcSnVJs4b73rwETxnHzMYWQSDgGTIBugXvM0ZdjcO0ttyg7ihD6R66UniZA77j98xp
         JcT9Ho1Pct7c01Cs0lEEChcpj77/ne94rUfrf4qtqM4csTunqij/z15KcPqXwcvDhoqm
         sBxWArTo/PAWuEeAHtquDIkR7oh8SotqvpsuQBTWYuYHDLNi6wv0fG/6XT3UMxtNiM91
         2DiScsoXEp/8nkBfOCOki13GodPdKvFX0MdNRzinu7F2qfMTN3AKiNAGCi6NvuEnwEN5
         vSbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568502; x=1779173302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        b=iLjXtwIT6b7SSIH0nK2u0LKJaeuHqdrTkDrh+Eg1uqTroYRxJIqBDEY8nA3nHFnVfb
         sjYcvc84dcUaMKVebF/nekYCZL4+yo+4wJD3I/ahGzaterqThvytQ3a1dbMuV8BwlFLz
         NUMnfaZcJZuuqhNaWKaDgcmEd6aqgUlQYXIHOuYoZlHTi+B1HBE/5P4rUy3crQvRdidh
         PFi6N0U7G5f/BxgGVajjSnU07dbmKFPIHInHEc/iJipbWV5iEp9F8g4cFqjRb11nkHoH
         0id/m6rTcJTUXie2WkuDUd6Z0J0e8DP1ibNxfBS+RdT8YKiOGUrEGW9WGuLEqeMcwZ8F
         Yt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568502; x=1779173302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        b=eh1F7qY9zumXfE6JlqGPFoVhl0eLaI9YMt9N7+ta4wTw7oX1i5aa2DpVMsA+njtTLN
         AHmmrV1aM8jEOWyJIGWP9xvHRnz0JK9abp5dM62J08m71adCKhM03jpzclz5pTb7rGzD
         KTOWv35i9Mf+x3yDfht0xv07lAQZuIfNJ34tMFqa11mke54ztePQj2YiNj6o6Ho9DCYj
         poElgZSRafKdEZ0o9xp3XquS3nn8rxkiPe0mtGJ91BBYCOfLRBOERfB6yJ68lniZivPo
         LuguShDJPFauRuNvj+N857Hfuad0g/dSNL5a/3vcVm1M63LCaPrGFp5iloqh0wKDLDaB
         AJ8g==
X-Forwarded-Encrypted: i=1; AFNElJ/zVRHezH9N+6neoHjN0N6D88af8eQqaI5tabJ4ln6DWqxIsSNwBmeFZLdg/XJ6gycvpiQ2zHdF8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeeeveL0jqjIsP4ODEE+2ANWFHST5yBJfsQv8DNTEed12gKBr
	BQwKt+0y95BIo4GP2SzRrlobmaDHHb22iEFNyXo5+0AOGcZWO9FE2fa2QQF5OCde/+TUWrYP3/R
	EIsOkYej22ZmunDKdAqwoGGESaaO2Hf0=
X-Gm-Gg: Acq92OElnI3Ru4tkhkRLBqVYdHQtP9kNBBDftrl50ph7d8qyE/lapu6oXJNgMLwdLDa
	AejQeb/8xRbgn6jRqMQi4pvlgKAWlpVang9RKZ4JrAqVccoE3cgw1FEvU5rwuhaOLqsASH5Y9jO
	5D9wrNfbW5d0gmKfWa11YfvXqi/PuHG4pe5f0713sDYSgqqATdCHy5vmqp9TbBGSd54tYThqbj+
	afgv45EEDgwR6huHRvwHY/zdy+6RIsMjMo8MlZJVCP2C9NaKtAIhZCHvObZm9GodQnL4cCH6SSv
	n8fzUMu4hVFwCEO8SaWIgEvEkOTvWsQXbVxLJ3g7UWXOKQxBJn3K3PdXj8IZS8NFrWD6eiJ34oe
	aTdJZaNY=
X-Received: by 2002:a17:907:809:b0:bca:48de:5cce with SMTP id
 a640c23a62f3a-bcc1499a53cmr609442966b.36.1778568501606; Mon, 11 May 2026
 23:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-6-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-6-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 09:47:44 +0300
X-Gm-Features: AVHnY4LmZe6op_7Q9Zb_x2R3mJ89A3uDVU-76OXP9otXVwwfDX_cH9Q0T5k4R6I
Message-ID: <CAHp75VcR2pzdT-JbNXE_nOM-XC--4y8D81tk+7rvjA71ugTkzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] nvmem: add mt6323 PMIC EFUSE driver
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> thermal sensor calibration values.

...

> +#include <linux/err.h>

> +#include <linux/errno.h>

Doesn't seem to be used as err.h implies asm/errno.h that provides
basic error codes.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +static int mt6323_efuse_read(void *context, unsigned int offset, void *v=
al,
> +                            size_t bytes)
> +{
> +       struct regmap *map =3D context;
> +       u32 tmp;
> +       u16 *buf =3D val;
> +       int ret;
> +
> +       /*
> +        * Manual regmap_read with loop is needed, because PWRAP is not
> +        * a continuous MMIO space, but rather FSM which doesn't implemen=
t
> +        * necessary read callback for the regmap_read_raw and regmap_rea=
d_bulk
> +        * functions.
> +        */
> +       for (size_t i =3D 0; i < bytes; i +=3D sizeof(*buf)) {
> +               ret =3D regmap_read(map, MT6323_EFUSE_DOUT_BASE + offset =
+ i, &tmp);
> +               if (ret)
> +                       return ret;

> +               *buf++ =3D (u16)tmp;

Why explicit casting?

> +       }
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko
