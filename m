Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287D7E792
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556003; cv=none; b=DBgX07fMYRzUV2g/1IRud/4quYLs5SKx0MPhzp83h2XsYrcvx/xVCBLEz22uVni2/jSJEH8WH2ILjj98wli2nGZzMdTmkdutKVHnfvdLWddw5pxsfA0mNJaQNDjpxRyfM64k9uVFFXvMN2uNA4Uk9NdQiB1ijbeK0o5cqgrNx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556003; c=relaxed/simple;
	bh=aXL4UHrf+0humdIEef+4JRKRa9+MfpcNujWBdBmDGOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZxy0EL905exGlNZ1/3o36elJHScmYSxPeDBao+QW8On/bwCCwHsmDDa7RmPabdGQoaDPdHDA7mzUOvx4Bx3vfZbCbm836qehAu9FqNf/ok3ffZ4OaO1aGTRSK0GwYYikdEV3XMu4dwBshpji/27u3Uf/G+Mo7Mjif87eFWoJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUFpmHPm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUFpmHPm"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso468699366b.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787556001; x=1788160801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiRReprdkoXJr2ffVSHCZYH7aGcmAMsjru8xnumcQsE=;
        b=CUFpmHPm1dpajm8kHJo/EBAKIRfUvFM8CCblNrP7igR3Bf8DjmaR1GXSQJwvGGexqM
         qkrwtSZnEB77wsfsRUASTLWuasfR7/3sN5ZGMTTNIdvs3p36/cJKb3FpuYlIgbwKuTHi
         E8QX4ghP/fMaLC4oRBeNXUclwjPfydI7y51tRwdps0wyA6rlKj3zruXeYQXWWrDrSEhw
         tbnowEjAVVGLWjTVx/6GE4zmj87DwtqhUOTkBdZYb7Qc7jb5+gKgl1X6PxnBMi3Kk+st
         x0IyJKR3Ehvm8kY+iHZ0Yj5gPTiRO0Wsr3jBIrb1jlxEiRM7skIaHEhfoVac+2BAQrkH
         Us0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787556001; x=1788160801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiRReprdkoXJr2ffVSHCZYH7aGcmAMsjru8xnumcQsE=;
        b=dpCdUN0uvg1kbaZkbhFyeLNwpG2RlpkQvdhK671rH8j3va5l3d1zK+wmhE/R5JiEDj
         UVqNCwsdUhM4pwfKthvNGDBOnfzEkTmUosGDJkW6dTKXk9D0jCGcDW6wQTRQB/32ri2U
         P0qYoYEF4dafhSU+Xf5+EdYbW61weLf6j7xmnut+8LdEoVDeN4glVaJQ1nxFrwExeSNh
         M11/fKdYjVYYK5BKxEy2L6434TJ9/JK0go+4VsWVETBddrmikR3R1MOz3WcUMxfm3PnB
         UqAz9TWymbLqHZdQzKeJWVTZPnI88qF0DbeHTKGLLG8Xsmbuec6Nl+U+FIG+XoOY/CwX
         yx8A==
X-Forwarded-Encrypted: i=1; AHgh+RrYXz0kJX5tCwOYmY2hv3fFD/dqmDLbQr7wdZ3G5K6WyizX5/zimwN2a7wCAkqSv8zHCBLgtqy2Mg==@vger.kernel.org
X-Gm-Message-State: AFuF++mmGYnT7yjrHOmtGMkibW3LuORdxtU4e389eB7zxw2jqgUIwFGy
	SJbnlCEoCaXhiPlvC8QaWy4Lp+b+m1N0lyl3gb2CB67cN+9kx8vvm3Bm
X-Gm-Gg: AR+sD114KewtMuqI1HmGs3OLmRZB7t2CcOkJuVHsp/aU8eKvLwzSba5ybf2j9X4Q0iX
	alpVbSEEQkpViLU4HqrDFFIBVyOGAvTsFuca1B9g7AKZGfwIH5geedRw5L6QidOIfGhel3iTmwP
	jkVLon0UHIPJ0xdhTYO5v0A9q4V5Uu1BPWDlgH7mrUWaiPOu6tGmjs+sqZteAnDjCSrJ+dyOWvb
	aVUdj+8yvViYMimHgxt/6zm3bIYw6vsoSEWnCMhfwwbTY0PnBPLeNATJoE56kqs2vzgm+nJuTcv
	d3T4d9GQJTlR+jCFBXKBT3xnj5dBAnGiTWCllvPasxXpRbomkFGmKY4hTG8CI+nKKbMFwko3vaw
	olJRlqRGCah+g3y2iDfRZVQCU8F1rsh91qkeHRMiDuVakDwwnFIG5+0XRFz10k0QP/1AL8D4pXc
	GsvDCLJ1d9Am9DszNbZP9ayMw33O5WttxjBz487eReP2lvLMlyeyFA0bWTCghLtdcVqlJaWOqf4
	cFqEqLXSgTh3Qzewto1bGxk5ZecsOos1otUb2yQjIKbiCe2xwoMmZ1Qbqy8YTkPoBsaxL/TMJgN
	Sfx0UvBjej1h+LoJ5UcndvBy+3rU0nkfPGw=
X-Received: by 2002:a17:907:7b93:b0:c20:5213:56f1 with SMTP id a640c23a62f3a-c246a60348emr2628478966b.13.1787556000424;
        Mon, 24 Aug 2026 00:20:00 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm1137673466b.49.2026.08.24.00.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:19:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:19:58 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Francesco Dolcini <francesco@dolcini.it>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8qm-ss-conn: Add USB HSIC related
 nodes
Message-ID: <qyrzrmrvymwhoziwf3we4fxwb4nfyhb3s7hiuqauzoco52auns@7rihmyhkti2v>
References: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
 <20260821-add-apalis-imx8-usbhsic-v1-1-fb93d73ead44@toradex.com>
 <aohtVk57YIWkj05I@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohtVk57YIWkj05I@SMW015318>

On Fri, Aug 21, 2026 at 10:23:02AM -0500, Frank Li wrote:
> On Fri, Aug 21, 2026 at 04:58:57PM +0200, Franz Schnyder wrote:
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> >
> > Add the required nodes to support the iMX8QM/QP USB HSIC host controller.
> >
> > Keep the HSIC host node in the QM/QP specific dtsi to not conflict with
> > the address used by usbotg2 on the iMX8DXL variant.
> >
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > ---
> 
> I already post similar patch at
> 
> https://lore.kernel.org/imx/20260720212401.C2BD31F000E9@smtp.kernel.org/
> 
> Frank

Hi Frank,

I somehow missed that imx/dt64-intend branch.
Do you want a V2 with only the changes for Apalis?
Or will you just drop this imx8qm-ss-conn patch from the series?

Franz
