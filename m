Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793640;
	b=tUP4cuYU/pFijnemc155Z9BkMUgZoZFicXw+hYkXWOxYcJ6c2gMiSXEh5yiN9vs4fOX0
	 6n9D6r5iJPAWi2huCSm1B4P9alkyNExKcIl8sRiBXc0H6ocsb5VaC353FKG1oWdxdh90/
	 ce5gwGliRb2TTBR8Mid9Cqo6TuuRqfY6yzUeQUXiQIwXC8fBSyfvF94K8HvfhNnEZT5rg
	 2ZijSwxmbdaFs4LdXfG5LvkedteAdcDzNSJ8HVfVECNJxsxFVPOJHL6j/FfyiFQrgdyjx
	 bH1ZsIifzRZk1LFJiEZtdigmfInIxYXhjUEXW4AEcKHSkM9rB/L3yNM3xshuJ525Tew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qTJK+XH+ZOTU8gAK0q7vkyGI0JnK1yiEcA7kRxssOjw=;
	b=jPWiUWCiekEb8beW39kIlRqhMn0fR3FFrowY6nNDrOMsFBH/d9eNcM8nuairdL4uE889
	 lfCv+D7ntkqxShiTn5EtNLHBSntwHgx7WfVhMUCYyvbX2JTn1GgIC8LymvP14ZrvlkBoM
	 RfbokvhCmajLnOwaQGGRGqxxBygxs0FZx+T/eu4oqSvf4wnRPDbrjC0SYshVPUfbNVJpa
	 TOxu11Q2t7hZF+gaJx6O9p6QOvmaK2mVutY0s6qH64DCHSJyDAaA26bnRWcB2cj845ndc
	 S5mYkGJrMcKbkM7aCtHIDq4MbuZq7wEirZoGB7kmrzOxDGxsVrHfwGjWK3ENalF0dCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H4TTngsT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822B606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 15:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D822B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H4TTngsT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so79583775e9.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 07:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795793638; x=1796398438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTJK+XH+ZOTU8gAK0q7vkyGI0JnK1yiEcA7kRxssOjw=;
        b=H4TTngsToTxGs5cuVKrbMVRTgRfqMhEmNCbHvoBbx7MQMIvoP5IoMHe0VmPgonwqXW
         jFHTFTbC3/2V7VSLpcZfHb/8XTh1+Z944oClLDDnTDbv5f1+Ol21NtBYB2lioyw54Om2
         e2xCts9pwI+TH9RUtuDXlHbQYAMArUWKd7mmgDvrDx/rf5nUriCtUBJS9AnPWVXaQmR/
         RL/P0kUv3fYhSOoldRJz14SwYfoMqwvMoiL8/bKjk1IkWTuZLv2ww7nechKKFP35IYuJ
         +Ci0uwJdSWUe16KPQ9NCv/l45qTxldzwIWTLIoI8+BnqGKWgj1knl/2oLiHE6ZlQYBSy
         Lz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793638; x=1796398438;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTJK+XH+ZOTU8gAK0q7vkyGI0JnK1yiEcA7kRxssOjw=;
        b=DULQNe8yUgm1GJOZWU5HmdeUIxSg63AzFCeA1D2izBz8xQ4mf2DAvmeN/ZzSfZjjw4
         OH61G6ybOwAT8WmwDDFSkT3sN7Jz9LpFIJPyGyt3Z9/Ngc0XM28fgBAkX0z1+cep9yEA
         yTld5tsUJC1Sxe4tzcIMH5/SlO4Fbdyp+bNZzJEyiR0C1ZD0bIdQMnXCDktQt1+LEFyc
         SEQqZYnCYtx00SeXdi/hJz2RQtX3OdDnUT11NOpZAYxIOcI2JWqNDcI138n2uDW8qQGM
         FEBbt+qXopMvHm9R2I0+iFDbRx3WwZQUGX4EJKMqglJGQzh7cg5V9MXGX1jea+ZpZuZf
         qd6A==
X-Forwarded-Encrypted: i=1; AL+hErHt8sSF2Lcz6TTQ5JoWan3IEiel3ubPzEyLK+IORWhEHYCp46Dyefi+CtKDFYrSyGmNp+CRq6CdSQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dd49WFv+0Xg07IkA98kegnLI5wkpzhkE2sJfe2cjHoR4p6qg7
	jx0EQ/VjN6/rTm96vlFOpoExumLXCXQmRht+6MeE8h3KkT3kH50xEC2HKF/MLB+rAEQ=
X-Gm-Gg: AZFdTZfmlKKznjRr3cyt9YaUlbIrwVlt9V++xyi1SprP6Ga0BnOmVbfA+2Wa8bB5DQX
	pZ5MqsDSFpc6A07bzLcYD/rzeuIjEYVaPKBdBmqdv7LxXS43yZpMhQlYiV5dMyzVRJZ1J9uxSgt
	4mnAQIyuaQbif6zV2j2Yig4zS8tgMDl89HJJt/a4kQsclnRdSR54QZghYTLCyWhQjzLtn0QrqCv
	4OKfkPzQLZgWEh4p60cvHP3cXTcWyJgsl6RyP1NrdLb3GOIRgQ0uT/7TRtiJ+pApNGHR9TwroRq
	j9Ijs8J/99Cfx2kd/H9DgSEy+0FSGLnAP/dtEtzrOYYkqRiQ5nIygigoIc95iGAKlYzfbHCO6Xn
	K7eme9tS0Nzr4sYUbVo+kgBaFd2dr/x1UEXfWvF7F9MC8ELO07QAiEpxT/p3ML7TujWkpNiVDDU
	iiPFi4vTbMTx0KS/KZ9RcgJV2RTmfsOrAsDeoC3JxTB3z2m3TFOrbVoJw1dg+I7tAlIngT+zGbB
	ybckqpEf3QVoXnRwGo6MUxLD3gFEpb2Oi1t/h8Yl0rdEuteUFQKHxAEGQhn2IoAtchVjUzfjbiB
	vnTPeKQR4/cGFJHXqZYVmle84FSUiiRhen8qA917DVLakruPTd+eZVjZlKtp3ZzMLLci8oUD62w
	wuHFgCUIDb09x7QYba2mLWAGMmLBWyw==
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4bb88938d2dmr469383675e9.32.1795793637832;
        Fri, 27 Nov 2026 07:33:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:c897:5d9b:d0a4:e684? ([2a01:e0a:106d:1080:c897:5d9b:d0a4:e684])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm46147475f8f.6.2026.11.27.07.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 07:33:57 -0800 (PST)
Message-ID: <aecd4578-7131-4c23-9bec-a2573c0e25e0@linaro.org>
Date: Fri, 27 Nov 2026 16:33:56 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 04/12] phy: amlogic: rename Meson8 HDMI TX PHY driver
 to be SoC-generic
To: linux-kernel-dev@aliel.fr, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
 <20261127-meson-drm-create-hdmitx-phy-v5-4-88c43eb95468@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-4-88c43eb95468@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/26 16:27, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> The HDMI TX PHY driver is currently named after the Meson8 family
> (Meson8, Meson8b and Meson8m2), but the same IP block is found, with
> SoC-specific register programming, on the newer GXBB, GXL, GXM and
> G12A SoCs.
> 
> In preparation for adding support for these SoCs, make the driver
> generic:
> 
>   - rename phy-meson8-hdmi-tx.c to phy-meson-hdmi-tx.c
>   - rename the Kconfig symbol PHY_MESON8_HDMI_TX to PHY_MESON_HDMI_TX
>     and update the Makefile accordingly
>   - drop the "(ARCH_MESON && ARM)" dependency in favour of
>     "ARCH_MESON", since the driver is no longer ARM32-only, and
>     select GENERIC_PHY
>   - rename the phy_meson8_hdmi_tx_* symbols to meson_hdmi_phy_*
>   - update the platform driver name, the Kconfig help text and the
>     module description
>   - drop the unused <linux/property.h> include
> 
> No functional change intended: the only supported compatible remains
> "amlogic,meson8-hdmi-tx-phy".
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/phy/amlogic/Kconfig                        |  9 ++--
>   drivers/phy/amlogic/Makefile                       |  2 +-
>   .../{phy-meson8-hdmi-tx.c => phy-meson-hdmi-tx.c}  | 54 +++++++++++-----------
>   3 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index ce7ba3eb2a8e..294996869e83 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -2,14 +2,15 @@
>   #
>   # Phy drivers for Amlogic platforms
>   #
> -config PHY_MESON8_HDMI_TX
> -	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
> -	depends on (ARCH_MESON && ARM) || COMPILE_TEST
> +config PHY_MESON_HDMI_TX
> +	tristate "Meson HDMI TX PHY driver"
> +	depends on ARCH_MESON || COMPILE_TEST
>   	depends on OF
> +	select GENERIC_PHY
>   	select MFD_SYSCON
>   	help
>   	  Enable this to support the HDMI TX PHYs found in Meson8,
> -	  Meson8b and Meson8m2 SoCs.
> +	  Meson8b, Meson8m2, GXBB, GXL, GXM and G12A SoCs.
>   	  If unsure, say N.
>   
>   config PHY_MESON8B_USB2
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 91e3b9790c03..2611ec8a056d 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_PHY_MESON8_HDMI_TX)		+= phy-meson8-hdmi-tx.o
> +obj-$(CONFIG_PHY_MESON_HDMI_TX)			+= phy-meson-hdmi-tx.o
>   obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
>   obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>   obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
> diff --git a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
> similarity index 68%
> rename from drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> rename to drivers/phy/amlogic/phy-meson-hdmi-tx.c
> index f6b5df74a58f..e4e606ab4eef 100644
> --- a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> +++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
> + * Amlogic Meson HDMI TX PHY driver
> + * (Meson8/8b/8m2)
>    *
>    * Copyright (C) 2021 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>    */
> @@ -13,7 +14,6 @@
>   #include <linux/of.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> -#include <linux/property.h>
>   #include <linux/regmap.h>
>   
>   /*
> @@ -32,30 +32,30 @@
>   
>   #define HHI_HDMI_PHY_CNTL2				0x3a8
>   
> -struct phy_meson8_hdmi_tx_priv {
> +struct meson_hdmi_phy {
>   	struct regmap		*hhi;
>   	struct clk		*tmds_clk;
>   };
>   
> -static int phy_meson8_hdmi_tx_init(struct phy *phy)
> +static int meson_hdmi_phy_init(struct phy *phy)
>   {
> -	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
>   
>   	return clk_prepare_enable(priv->tmds_clk);
>   }
>   
> -static int phy_meson8_hdmi_tx_exit(struct phy *phy)
> +static int meson_hdmi_phy_exit(struct phy *phy)
>   {
> -	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
>   
>   	clk_disable_unprepare(priv->tmds_clk);
>   
>   	return 0;
>   }
>   
> -static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
> +static int meson_hdmi_phy_power_on(struct phy *phy)
>   {
> -	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
>   	unsigned int i;
>   	u16 hdmi_ctl0;
>   
> @@ -85,9 +85,9 @@ static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
>   	return 0;
>   }
>   
> -static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
> +static int meson_hdmi_phy_power_off(struct phy *phy)
>   {
> -	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
>   
>   	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0,
>   		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x0841) |
> @@ -96,18 +96,18 @@ static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
>   	return 0;
>   }
>   
> -static const struct phy_ops phy_meson8_hdmi_tx_ops = {
> -	.init		= phy_meson8_hdmi_tx_init,
> -	.exit		= phy_meson8_hdmi_tx_exit,
> -	.power_on	= phy_meson8_hdmi_tx_power_on,
> -	.power_off	= phy_meson8_hdmi_tx_power_off,
> +static const struct phy_ops meson_hdmi_phy_ops = {
> +	.init		= meson_hdmi_phy_init,
> +	.exit		= meson_hdmi_phy_exit,
> +	.power_on	= meson_hdmi_phy_power_on,
> +	.power_off	= meson_hdmi_phy_power_off,
>   	.owner		= THIS_MODULE,
>   };
>   
> -static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
> +static int meson_hdmi_phy_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	struct phy_meson8_hdmi_tx_priv *priv;
> +	struct meson_hdmi_phy *priv;
>   	struct phy_provider *phy_provider;
>   	struct resource *res;
>   	struct phy *phy;
> @@ -128,7 +128,7 @@ static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->tmds_clk))
>   		return PTR_ERR(priv->tmds_clk);
>   
> -	phy = devm_phy_create(&pdev->dev, np, &phy_meson8_hdmi_tx_ops);
> +	phy = devm_phy_create(&pdev->dev, np, &meson_hdmi_phy_ops);
>   	if (IS_ERR(phy))
>   		return PTR_ERR(phy);
>   
> @@ -140,21 +140,21 @@ static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
>   	return PTR_ERR_OR_ZERO(phy_provider);
>   }
>   
> -static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
> +static const struct of_device_id meson_hdmi_phy_of_match[] = {
>   	{ .compatible = "amlogic,meson8-hdmi-tx-phy" },
>   	{ /* sentinel */ }
>   };
> -MODULE_DEVICE_TABLE(of, phy_meson8_hdmi_tx_of_match);
> +MODULE_DEVICE_TABLE(of, meson_hdmi_phy_of_match);
>   
> -static struct platform_driver phy_meson8_hdmi_tx_driver = {
> -	.probe	= phy_meson8_hdmi_tx_probe,
> +static struct platform_driver meson_hdmi_phy_driver = {
> +	.probe	= meson_hdmi_phy_probe,
>   	.driver	= {
> -		.name		= "phy-meson8-hdmi-tx",
> -		.of_match_table	= phy_meson8_hdmi_tx_of_match,
> +		.name		= "meson-hdmi-tx-phy",
> +		.of_match_table	= meson_hdmi_phy_of_match,
>   	},
>   };
> -module_platform_driver(phy_meson8_hdmi_tx_driver);
> +module_platform_driver(meson_hdmi_phy_driver);
>   
>   MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> -MODULE_DESCRIPTION("Meson8, Meson8b and Meson8m2 HDMI TX PHY driver");
> +MODULE_DESCRIPTION("Amlogic Meson HDMI TX PHY driver");
>   MODULE_LICENSE("GPL v2");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

LGTM

Thanks,
Neil
