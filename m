Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795557969;
	b=gekSqLp/HfaxtB5WXq3yb4QwFJD+VMNSoD/TWgcTElrPm/w0LnLYvglAcmueVdrdhfgl
	 YMI8pjZCUPHoEGZsvMlbYFfeFPfS3jIRuRMgG1XNANmpmhby9WA7UqfyAZOSvzHDGWw2b
	 GjbnpQeuFktkIM8xynnq3NNuK7PC4dAGD/EvACROm3jhcyv7QIg0Uda98Goq29XpFzSM5
	 hVRc/iMx/L6mb6q0RGKOz9oONZ0DSLrJUqNbOsDgON4MrnEG1YLeCm7zbHNul3OBdl4ce
	 5ygMiJTPH1XlVi2Bzzrug0MmlA92bPqQWWYANRVurblu6DKcByss3pNYCqXIM9t0cOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
	b=l+5Xth0S9NiV+nnk5Q7qWfduTPtNvBYpL7SEIBxxXpBz9gYFcj/T9lvoBW4k3iAjZWcd
	 qeU2sQXjydtGD7WVgaJA/8ZTrX7QQfvI0PnCMbf6C4lnMYjfFiE+iPYudzouxE5NW0/ae
	 iWhV1zltgZMttw4ybnN9spPG70GmACcH7dmTNb0DxGyLYTaBFvAL6i0IkHhFHrNxM+ja8
	 HKoVvIbpqp/dVzOQMYVJDf1WpMBeBQBy7Zgznt0KoyJmOdPBx7dtOakxHmQgtGvjtL3c7
	 VZhfM3hOpSDaTd+VP6Kr5oIS8vyDj5ysuTYWN0Zcu4geHGCBf65nAMtX1vNLIyUDVUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=d27cduBR;
	arc=fail smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AA606A31E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 22:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=d27cduBR
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b360828905so46761787b3.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 14:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795557968; cv=none;
        d=google.com; s=arc-20260327;
        b=Meglu4dxYIf06zJV/NfgQ5SKI2WB5h2A75XueyZPlAcauj6sg0Nct8zDVYe6rL1FNu
         bqWAJseEf51839f91IJjeWH3kNbmq0k+G+nnpIHaI16ZwRDbRu3WafzB1Q+UyfuzBtTT
         EsUBQ3lo9Vg+EkmrPERmKqjtQpw8e+UuB+ytMU2fRWlt1o8Jbwb2huGU6DFQ0yk4joHV
         Bv0+NwT/yb/otKoptir+3OZQWGHanUCzCnWqpR5sMVIuvgj7An4No1awgqsdVBC2b+Jf
         DPPxeK7lHu7mDr0ZFJXdSfTpOC36KkS0ULyI9Rzpq+XhIHDv2efnYy2FHUxRapqE9yv7
         CI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
        fh=0tbdO78JpsxBe+Plg+R2nMOghTwGeQFJpmu0IDSmlIA=;
        b=FS+UfnP0n1hCFRYgdgRI/Gkg8KNcyKs/4nJsS483dd5zK2WugUP4HIeYikeS+16bue
         K0i+pLW1VG6jF3V+EdCKLeyDOsWIAKqAz5z5zRHmLEC8X7XbthmwcwrKkvTaZ5+z4Wec
         gfDACoMYA9+XuRrLFK8roWMZLv1njKGmtvbT5/8pK46R/IHwLK40qsfRRBL+2Xx6ssZe
         56ndhm59qwPyxatecWovsvZtZWZn06N52LsdcZPqgg5mCJZJ7qVyCCEc/3buekoKDQhL
         x7GSqy+YikIetnuvNxj9qyVj7vYV64vkVEd7AOQux/Y4ZHaX1L5PPJPuQiA2K0O2igQi
         1ZjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795557968; x=1796162768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
        b=d27cduBRSCI4Fx7E8JEwH4YkEnonereNTCPDQf1MqytROJcGGGMvHL3Zr80JbXggHB
         E0wcnOWFhVTUKUD0qU4PYjj1VflQoE5ZSxKEd+KccQRNVtKdw9S27TVP7NcGTKSV7/KC
         2oqwPsUkDnZNq1Adzg5tpDhVrgwbH5B3i08sVQv7zGMCmfaxhcJiAAg8b726Rpsr5klY
         lGfmGJlIEYS/AL74iTCcBG4GzGy14qSYjXFjr17lVGwMVGoX61/OvSCSODiZDouWm5XR
         fGn7on9CLOGvLFpcz363wjCsxy9b9KK6GE9dxwc6kQlypkH/RvLMRh0ly0GRsC4yElhb
         ZMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557968; x=1796162768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
        b=BgcCqBxktPx3TrPwEG5UVEn4ZJmfRblM/M6inPj3npJQgdP1KmB5Ft8iPhdGCC5DxQ
         PWfxEf/9evrtCNt1At0LCLbC5mqnYfzHTE50+Hi+RpySLtX1OoTSayFOLx1AfJNcm1UU
         4xlVUpLc+2EVxEdfvHZlGI9BCUqSqDRR/JOw3SsRDbvnXyzmbBfjm/7FXnvFpmbVt2PU
         aViyWO3kL1Tw8ZoeRLrs1fIZYxRg6AA5hEHrwommQz8nPMhyWDcoatzay7cvVm/+FAwZ
         PtZATTf8/AcQvCWj8wWbPVcKm6iWJ3Pn11NNLRuhhuVEuQ0rYjD52MA3EbdzVnETE26O
         bODg==
X-Forwarded-Encrypted: i=1; AL+hErEhydOt0DnrX1YDwrBsycymsz+BCXFecjXzSPjStB7x6RKbVr6VkTl+f9CxZc6/zo235AvQReCMHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hqgomSSi144C1qULoHzdhHpjcJdewQusMP2P9TZudvi6+h6/M
	Sb3aRkxeHAL6C+V7zD5yG7OnDlG81L3xtCXdUDkIpn6UHRN/veDF50K4teT4OoZlRSdGM/FljDA
	FV9CABI3941JGrnpoIIlltirQYeE9blw=
X-Gm-Gg: AZFdTZcU2xvrsyE+sq370XDLgFzD6lScJvJI6YAC1VNUeXYhyuyzw6Gsu7V88+X66Nl
	+tF2a+b2ZRoiZud/ur9ulh60/lZmrCaAb4nNoCq14Pbc1sgcO6CPNWVEdwEDr/uTUoF52rmUzWg
	7qpJMO/5zevC5gFOTHc8kYreFRCQiIo3xMlUC35beRZ6k/Bg2COXku3/ZFNa6e56sJboGOQhOwh
	ou3wOTiJYhLXiC8gBISRUcs9eVW4H/+XkvVSEOEgdTSLHAUetf3UJcWmPgL6R4GCt0vNcjY2fKZ
	2Fw6TMvlrCmGK3rSO2hrfDjsuAy2RF+RWtHMjzIVRmV1uK+LPFcxoX8ToSuALXv70XQiqYkhK5S
	y/dHDvnW693tFq8oOOQNz/OmYY9ABjd9CINovXnhzEe17dGtLRLiXcF0xubKm894acI7HlA==
X-Received: by 2002:a05:690c:4806:b0:8b3:33cf:1ff8 with SMTP id
 00721157ae682-8b52047e1abmr62214977b3.51.1795557968035; Tue, 24 Nov 2026
 14:06:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 24 Nov 2026 23:05:57 +0100
X-Gm-Features: Aa3M54obAOudEtwcvYkDuGnJHvL3A4XdBNW-oHonc9K3rZo32rUzvFY7EEi7VPQ
Message-ID: <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ulf Hansson <ulfh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ronald, Hi Neil,

first of all: thanks Ronald for picking this up!
I like the overall approach. Before I dive deep into this series I
will finish the code-review of Valerio's AUDIN series.

Two quick notes below.

On Mon, Nov 23, 2026 at 8:38=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
[...]
> Overview of the series:
> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>   add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>   "hdmi-phy" child node under the HHI syscon.
It's been a long time, but I think we've been asked by the devicetree
maintainers to have reg properties for the nodes within &hhi
But I can't find the message at the moment.

> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>   PHY configuration ops, along with the temporary legacy creation
>   helper.
At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
There seem to be minor differences:
- two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
HDMI_FIFO_ENABLE=3DBIT(2) and  HDMI_FIFO_WR_ENALBE=3DBIT(3)
- newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5

Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
won't need the backwards compatibility code. So if you need to tweak
the driver: feel free, there's not much you can break!


Best regards,
Martin
