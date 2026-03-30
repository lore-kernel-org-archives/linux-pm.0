Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527C37F75E
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855098; cv=none; b=gZTUlV8sZqWSfa4hkD8o8/EEdB1bAAWpn32CF6S7756j8RXbJI18IXSsjQLT4YI7MqMW9g/HmD2sVJA4HDyRvypdPcPQVhcaYemf02V+/OQv5IBxnczFVNnK8me3EV2Z9PV5UnROJAPI7a+16Ovm83SiCYy29CDv1wTP/MDSpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855098; c=relaxed/simple;
	bh=h6fkI4F2Z20kN9B9QXjQ+evk+vdNQDvCzuT6cAe75bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR2iLsBnYyAj0TX5TMMeWfvix1+jWkWj0pSzNmda8ZK51KdB5Osy8lx2+uurwsKfz9ojY2oq5hXOcCyJY/Vb24nvcHvInSnJEmUJ3Ng/kdSJObj3bH4d3Fm/cO9ICCuNTNoC/nyIFVena/hVXqMMq1GjmzVcee4BHvCg9ZPJ7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=On6M4PiQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On6M4PiQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d95017a68so796893a91.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774855096; x=1775459896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9l0DICorx9e3YtEUL9sxg4iXIgZ/t1UyQoc1s5iSxOA=;
        b=On6M4PiQM6QpMzjkwpLgAejpsldjUoS8yKXme+974qvOLfaxXdOnTxlxnH18MV9t73
         3vZmoXxZDjSKqOE1ebkfqtGC5HvVE1vQNXWCd4DX+pSmqluy+kSxT8mxW8Y7Bf/nu0Wt
         7CCLJ2kZxpCG20dcq2gVllbeYcF6W7M5hvdg/Py4hwv3nyKHkTz9t62BUywbhRVcshXL
         WyPj7MDPygY+8SXLP4lhZEvbVhsFpVQJWQHsYOfC0w9bm5kCqgpGEI+i+2MDEK5jioeV
         nKWimecXMhopHog5NZ460bRqbNLKKjCqBdHVxhKCATayFQwcBVS49b/rFzz2zgahYB5F
         24pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774855096; x=1775459896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9l0DICorx9e3YtEUL9sxg4iXIgZ/t1UyQoc1s5iSxOA=;
        b=mseSx/wFieqgrYRGgs0dDgGKk3vWo8+4sfd+144xD4XO3ZphlK2d+py/wIETK23QLT
         /IqQz6llnKZ/Zltf2xQrwBFnk2HcNU5qKTlIEHd2pqhF/ibnQ8EggEYo5T5szCGsszam
         LlovqgNLiFsWDPBJCB4kXunheFAYePWKMrC8fWBAxE9dOmPgWiBsfZXKe3ol3QANGMsP
         tbe76VK5VNa17iB2cmmmqcloaZvQFy/Q6amq8gwdFisLJBprfA6b8n17W1/VIZsdGtZu
         UuMvFwnzxskFNm7tRXB/HtFeO+L4gwDNpOqo4uskmRM6wCRsgKV4CVFdA2rRKoesyrE8
         E/zg==
X-Forwarded-Encrypted: i=1; AJvYcCW1U7dxCA+vmP1gJbAVGj9RlrsRYyPylkhuQiV/sygaWKquPyAGnZMWMmEzwc1vqTTDfYmzR4v2SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymwrR12Zblhp6KcKiDW0uuDbudvaRoxKjwP/Mw2wZ2nggprvOD
	BvzVfluzpKHQIl1jm6tKZ804M3Gkcu32vRMT5b320Pn6VIzu9u6WN6XhpIpvKRWw7eI=
X-Gm-Gg: ATEYQzyD1PHs4Fvznjei7OqaVF9jJ7/jb1N2RCHknllDXbTueGMk6rQT4qTBbUuAMWV
	3VGVrbDIQwolWr4z8BelFybdBGDDcGPtgG1ftYzgCRpdIILrhiTwDshqwCp5deDs9lW+n+Rno8+
	3ghxoQGlS55+/HrsFCYQFUq+agfERhuW/bHx7Hspe9NbshirNwzUOw8UCN2KALrokw1/TJKc9so
	fWUunHdrQtHVwJovxNe7tw+sAEPVFcIQC9SbCNZ0kWszA1rUj75I2zNwGnSlk+idsT/54L5UL4b
	AruO9iAx1UzoSmo3jjLbyatPTdUL07YkL/w+wH+cFnSJlY+cKy0S5F00gPJnHpk3sY7EfkMojo5
	4HtnMK5R+lmKabRGjYrI6Z8UpXfdHGGPJM0im/BRudrU1GtvL452Sj5vzDOzCxyVqQn1FamB1oO
	0lHz0mRaDDFq+fanYLiPCANz9F
X-Received: by 2002:a17:90a:d403:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-35da3b43086mr3290718a91.6.1774855096016;
        Mon, 30 Mar 2026 00:18:16 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916baab6sm5415873a12.2.2026.03.30.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:18:15 -0700 (PDT)
Date: Mon, 30 Mar 2026 12:48:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH v3 0/2] dt-bindings: thermal: st,thermal-spear1340:
 convert to dtschema
Message-ID: <sepwwys3izddmyokbkwdgqxzta2oceu54u62dj5mif4c2am7ku@vn4ewcicx2vf>
References: <20260329123449.309814-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329123449.309814-1-krishnagopi487@gmail.com>

On 29-03-26, 18:04, Gopi Krishna Menon wrote:
> This patch series converts SPEAr Thermal Sensor bindings to DT schema
> and removes the thermal_flags property from spear13xx.dtsi.
> 
> Changes since v2:
> - Reword the commit message and subject to correct explanation in patch 2
> - No changes in patch 1
> Changes since v1:
> - Changed unevaluatedProperties to additionalProperties in the binding
> - Reword the commit message and subject in the second patch
> 
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
> Gopi Krishna Menon (2):
>   dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
>   ARM: dts: st: spear: remove undocumented thermal_flags property
> 
>  .../bindings/thermal/spear-thermal.txt        | 14 --------
>  .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
>  arch/arm/boot/dts/st/spear13xx.dtsi           |  1 -
>  3 files changed, 36 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
