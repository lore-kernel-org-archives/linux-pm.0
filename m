Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793740;
	b=SZB6mH61mxKWW1QoQy3T9YCnPHZLu7oBQf6rqFlB80vCgGAq6EfmUv78N4x+n8y8jLTK
	 DglNuQk5BJ00UCT1tGqpNFhxaVTF8GxvutuGZPVaRAalZwyTypqjv/0PIWu1sAaTN84UV
	 lTrwqYwnvs/jfm/Hvg5iSXAeHYx9icX9a7Xq3q/egs4v7SPkISxuXCOeMamV1zCvSvKSb
	 EMsfO9uz8xRxDpT+Nh5T5N4d3mU6AFdE4xBO4Ld+CKvWiBmodibuF/NqudNBrob3wibGa
	 m2MDqHUsq/Nssms7X6d0a0gsPGx6IcW/PEJZX9x4yE7oE4KoRmC3YxtIrnz9EFkPNZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/leW6zs7HC40lM5Yv1F7Yi0moI4pxhI/mUly1W4apXs=;
	b=uom0l9O3ys0Br4q58Dv1uzDoK7zJC54vIIH4dWk2eq7PYdA3kxE4JA98C9T57E+OaUUq
	 EgNwXC2mhUfj3wgx9oxOmfGZN+hMG8+Bn0QYwWRure1OEmdIBh/FmcZpzaOFMMR8fZ1CL
	 iDVkaHOfGgjEKAi7GwjUbwSnisc3Lud5E9WlY4aPdGbfI8pxH7rDAysd7NTOqI322qpte
	 AlPluaSIp1fmRxe9ZPGK6c118i+9OuwqrntPG/jCPidSjjDUigbyVISZxvhrREckP8LmB
	 U0BhfJeXxXrLyHkjwqLlCUYsQr1RdlKn6Ytk6Vsk5DZAXr0ZCt7NSW4V1dFnzVw8u1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AGl3FtRt;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F149606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F149606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AGl3FtRt
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49412eb1474so5441392f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795793739; x=1796398539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/leW6zs7HC40lM5Yv1F7Yi0moI4pxhI/mUly1W4apXs=;
        b=AGl3FtRt1uRBl/SOJISvoGyg5g3v9xIVGwzsSao9wJXHNOVolKBVqjZzRjtlyYc8Fr
         V3lXHnH9dQf6W7MfQz5OcTYGlKkXu7yZUJcGckbhFhmBV/IT1/YXZasfWYSW/qbp/Za9
         yV/xeKFPx/3pxuOoTn+b9zLCUZOHmmdi5zPsKneGKCXqmMmJm31Cz0LLZKzIbbSePdg+
         wO3yCdt2y1wWRdN3QohUlr+tj3iS4UHp9Z9pSdJGQ0O/p6uRv/QBUE/SWLBmprwUDnZZ
         Ei+NKeAUiEG7B91hdtNkWFlpMw0aOqK6DI+xL0FEJTejQsHqMJhukHlCnIF0sSllqoF2
         yIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793739; x=1796398539;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/leW6zs7HC40lM5Yv1F7Yi0moI4pxhI/mUly1W4apXs=;
        b=lZRXCV6AuevC80zigohvP6GMXzpp56Wb/dBUKAwE2Z+Eyk7G40YOgVXpgp3d8o5k/W
         4yCZu9bgcP9M1GOtLdGBgqXSsJYWWG1idYjzGIrVsWyuDQ2x8qXY0r+hTJoxEvi4jqQD
         Sm4143MlrGlYFxHz20BO71nV4loUzzTqmUYCc7Fon8VIOJ80NxSoZ0WYbn1DGprf6QZm
         QR6PBDb5O+3SW96XTaBnb65qyHokJO3Io43rVpCqMy46n/EMzu2FpfntVHZ2sx4ePRDh
         ch0hRuHyBGQpMry5URMc4Kj6QOW+k9lo+6lYcEWOVa/Jgr47twa4FtbJbupWPsN0K6Az
         Jljw==
X-Forwarded-Encrypted: i=1; AL+hErGBSEVTBeZnZg9zrORT/42ZIwTniZyLsF9kO10GSGy5bcdDa8rlPAWJIV4NEEossBKUIP4L1KWQJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9c7tvsYlUYFAiwylStivmyFEhA5J/HJNbYVuc6hzm44QkIljSd
	T7dQy1DC7FgN8FE8tvNgLOsz7UahSzOF6ekGEZjcUXD7vptCJoq8mKJzwvbnCRYYAaw=
X-Gm-Gg: AZFdTZcVGYjBTre6Faz5vJ0rSNnMcyfQF77I93ZXSyyCQAksI44mo5TIVrN+zBJFpYC
	VQvhnptyGhtOaeZ6QAm/rXceJfbHtbzLAy2jjG9nD8q7VnwOx8o63900gCAriArjgdhDvdHYfxd
	x09dp78TAdi2yIdBMP83A2x1PMZ8m6tRQqW2fL4yLsCTBxVD40oKkdg5LowqCrkfr3TlDCvUj99
	TT62ZPMZyJENaboKuFX3FD9mua2atur37aerk1dRHnYYSkovZJC1c/ascqzFUgSu1NmYQzQPVTp
	Ne30/xCwirzL6uRQQhNgr2eU3u3prf3+DT7oydTVC/fJLdKK4NXJoe/Ra5rp+sn9OitmYsEzl1K
	qtkTZzu7GuIbsii/qAcpg4ivO3n/Jivc0SQkV9eswO303G6biRIDi9KpgNNZ/Zs05XTtiwpJtPK
	C7zb+5o4LFr13u6sfmQH0FqUIU6wGz1gmtoNIqS1DUbcDHBJJpjCjW6+BayJi6SscmN/wVBW24I
	AvuUMHKNe19ib8y24uM+X3P6NrwXu9S9By8+tu/QG6JyyHJafgKThw1GveBLPg9cFtjljNokVhB
	EGaQVG/6jfNM8YcsrDkMjlgpMlXFpHWMEU98JQujYxT75REKykn/4dt11FDEm1SS574vGNELTU6
	3pWqBCI9jabx0a/NczPBXyYVNOEC25Q==
X-Received: by 2002:a05:6000:2997:10b0:4a8:12d3:c0b2 with SMTP id ffacd0b85a97d-4abb47b2244mr36965476f8f.23.1795793738453;
        Fri, 27 Nov 2026 07:35:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:c897:5d9b:d0a4:e684? ([2a01:e0a:106d:1080:c897:5d9b:d0a4:e684])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48927658f8f.33.2026.11.27.07.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 07:35:38 -0800 (PST)
Message-ID: <446fa440-1537-4b30-8429-4d72bb70029d@linaro.org>
Date: Fri, 27 Nov 2026 16:35:37 +0100
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
Subject: Re: [PATCH v5 00/12] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
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
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/26 16:27, Ronald Claveau via B4 Relay wrote:
> This series moves the Amlogic Meson HDMI TX PHY handling (covering GXBB,
> GXL, GXM, and G12A SoCs) out of the meson_dw_hdmi DRM driver and into a
> dedicated generic PHY driver.
> 
> Until now, meson_dw_hdmi directly manipulated the HHI system controller
> registers (HHI_HDMI_PHY_CNTL0..5) to configure analog parameters, toggle
> resets, and manage power states, as well as manually ungating HDMI
> clocks and power domains already described in the DT.
> 
> By extracting this logic into a standalone PHY driver under
> drivers/phy/amlogic/:
> - Hardware representation in the DT is cleaner, modeling the HDMI TX PHY
>    as a child node of the HHI syscon referenced via standard "phys"
>    properties.
> - The DRM bridge driver relies on the standard generic PHY API
>    (phy_init, phy_configure, phy_power_on/off, phy_exit) rather than
>    touching syscon registers directly.
> - Legacy DTs lacking the "phys" property remain supported via a
>    temporary fallback helper (meson_hdmi_phy_create_legacy) to preserve
>    backward compatibility to be removed on next phase of component
>    removal.
> 
> Overview of the series:
> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>    add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>    "hdmi-phy" child node under the HHI syscon.
> - Patch 4: Rename the Meson8 HDMI TX PHY driver to be more SoC generic.
> - Patch 5: Add GXBB, GXL, GXM and G12A SoCs to the Meson HDMI TX PHY
>    driver, implementing the HDMI PHY configuration ops, along with the
>    temporary legacy creation helper.
> - Patch 6: Document the optional "phys" and properties in the
>    amlogic,meson-dw-hdmi binding.
> - Patch 7: Make meson-ee-pwrc power up the domain memories when the
>    domain is already on at probe time, as this is a prerequisite for
>    dropping the explicit write from meson_dw_hdmi
> - Patches 8-9: Clean up manual HHI clock/power-domain writes in
>    meson_dw_hdmi (relying on runtime PM instead) and convert the driver
>    to use the generic PHY framework.
> - Patches 10-12: Add the "hdmi-phy" child node and wire up the "phys"
>    phandle for G12, GXBB, and GXL Device Trees.
> 
> Tested on:
> - Khadas VIM1 (GXL)
> - dtbs_check and dt_binding_check run cleanly with no new warnings.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> Changes in v5:
> - Add Patch 4: Rename Meson8 HDMI TX driver to prepare other SoCs
>                 integration. Martin's review.
> - Patch 5: Adapt the GXBB, GXL, GXM and G12A SoCs code to Patch 4.
> - Link to v4: https://patch.msgid.link/20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr
> 
> Changes in v4:
> - Patch 2: Change commit title. Sashiko and Neil review.
> - Patch 4: Change the phy min_rate to 15.9 MHz mathematical limit.
>             Thanks to Sashiko's review.
> - Patch 8: Drop introduced double free with phy_destroy.
>             Add missing device_link_remove()
>             Change the device_link order and use prepare/complete in the
>             VPU drv for drm_mode_config_helper. Sashiko's review.
> - Link to v3: https://patch.msgid.link/20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr
> 
> Changes in v3:
> - Patch 6: reuse meson_ee_pwrc_mem_power_up() in meson_ee_pwrc_on()
>    function.
> - Patch 8: revert the code to v1 and add a device link to solve
>    suspend/resume order in dpm_list.
> - Link to v2: https://patch.msgid.link/20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr
> 
> Changes in v2:
> - Patches 5,9-11: Remove unecessary "phy-names" for uniq phy.
>                    Thanks to Neil's feedback.
> - Add Patch 6: Power up the memories when the domain is already on.
>                 From Sashiko's feedback.
> - Patch 4: Add a 600MHz max_rate and a 25Mhz min_rate check and
>             exclude PHY_HDMI_MODE_FRL for phy_validate. Thx Sashiko.
> - Patch 8: Move phy_init in dw_hdmi_phy_init and phy_exit
>             in dw_hdmi_phy_disable. From Sashiko review.
> - Link to v1: https://patch.msgid.link/20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr
> 
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Kevin Hilman <khilman@baylibre.com>
> To: Jerome Brunet <jbrunet@baylibre.com>
> To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Ronald Claveau <linux-kernel-dev@aliel.fr>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Ulf Hansson <ulfh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> Ronald Claveau (12):
>        dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix compatible matching in conditionals
>        dt-bindings: phy: amlogic: document the Amlogic Meson HDMI TX PHY
>        dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Add hdmi-phy child node
>        phy: amlogic: rename Meson8 HDMI TX PHY driver to be SoC-generic
>        phy: amlogic: meson-hdmi-tx: Add GXBB, GXL, GXM and G12A support
>        dt-bindings: display: amlogic,meson-dw-hdmi: Add phys
>        pmdomain: amlogic: meson-ee-pwrc: power up memories for boot-enabled domains
>        drm/meson: dw-hdmi: Drop manual HHI clock and memory PD setup
>        drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY
>        arm64: dts: amlogic: Add HDMI TX PHY node for G12
>        arm64: dts: amlogic: Add HDMI TX PHY node for GXBB
>        arm64: dts: amlogic: Add HDMI TX PHY node for GXL
> 
>   .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   4 +
>   .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    |  33 ++
>   .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  43 ++-
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   6 +
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +
>   drivers/gpu/drm/meson/Kconfig                      |   2 +
>   drivers/gpu/drm/meson/meson_drv.c                  |  16 +-
>   drivers/gpu/drm/meson/meson_dw_hdmi.c              | 223 +++++-------
>   drivers/phy/amlogic/Kconfig                        |   9 +-
>   drivers/phy/amlogic/Makefile                       |   2 +-
>   drivers/phy/amlogic/phy-meson-hdmi-tx.c            | 391 +++++++++++++++++++++
>   drivers/phy/amlogic/phy-meson8-hdmi-tx.c           | 160 ---------
>   drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  19 +-
>   include/linux/phy/phy-meson-hdmi-tx.h              |  19 +
>   15 files changed, 627 insertions(+), 312 deletions(-)
> ---
> base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
> change-id: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09
> 
> Best regards,
> --
> Ronald Claveau <linux-kernel-dev@aliel.fr>

We need to get the bindings reviewed first, then PHY drivers can be merged.

Afterwards I'll merge the DRM patch on the next cycle, then finally the DT.

Neil

