Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FF2F532C
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775664; cv=none; b=INxxQUT5AjNUftxnWkyJLXyO/o3bmgx1jTmrUe7vFAd0UQLq/HQ6RTZfJWTT/lQi42SGYtTZgpUNkBOfVxkRuRMc389QPFC/q4zG+JyKYeWBvaM3AT4LJFrYaMGPScVlVnL2rNL2lc0Ugb4i4hZQFoDNxarwhMTs95Ka5w4A39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775664; c=relaxed/simple;
	bh=Gc0gOaoHzXbYc7NYkFtpNl/sc2DX8b0S6Hs8q7uqAEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Oi+ZDVhpc8Dw5KtIyM+ZrDVwksVEfbWDjBNIuxgA0RqqwCVzFjOYYzJPnTXqmh7XE8xNgm3fsg4kgTSra/g73DDs7NgjtsY7zoJaZE3LnPvRhihCC+CJBWyEU/fsNNT41WtbCkUZ+XkFTTqekR4eR4q6jjsALuJm9JLudrnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeiSgbc/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeiSgbc/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-896f5af3d8aso19600726d6.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 18:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770775662; x=1771380462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhFxUnx/Epygu+crt0JPvhltwHI+RIY/8wqwIdbg8HI=;
        b=BeiSgbc/wePWY9jFk5nqvhLRAlOiA5gVg/ZfdLSAbk87H8iCjc8LzEdqqIKP+jXurD
         TOQvs8P55H1+k8S2LKSFtGGsk8wR5ZFOsi8yu7ixHqnPf0nMyK/+gyOmLb1CPnvJ4RQ3
         /2B+W0SOiCsrwwHLFVRhQz3XgAN3j1QOp5J1ldz02MyEAgI/6fChWpxfI8kIaPXLfE0P
         w71xtq8oRjxC+tWm1yP8/uRzaUXcsjExWD9exPdLSigK4hVmZBJjy0jvVEnnGYJ2wAU3
         aYKMZHi+iaVsHU8GekUwCiV2NQXXO+aeu6z8z+M5f7D3umHz7ptI5pwDTLtlXXuWH7s3
         i5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775662; x=1771380462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhFxUnx/Epygu+crt0JPvhltwHI+RIY/8wqwIdbg8HI=;
        b=O3ETCDDrYUaKg1s5YMKQO9Hd1qmHvMwEk/4GN6lQnDX+O1o/oaBbKCW/g2HbnIeF4H
         +MwKDo3o4H7sa2sINiicwY55lnVNSwkqzeVLcqWJ5L0uTPHpTgm/DcXGbpavWLIbrPTL
         gplPoTQi7aczHooqdj1l45dSOVJOWo49OPAgK63m9I8LIRGDe+0qLviOJDshLMDXEEkQ
         sdEPFhanaR7ilq5b22SvzWah9KiCT+WqvZLPzVPYBMBDMzdZX8GVHoztmTSYkewzQS8x
         pf0T8uw6P0hBjYbsOXWYT3KLLo03/YKBteWPuh7/xZ09mmnjST8m1grEI54mA2lfafz8
         buCA==
X-Forwarded-Encrypted: i=1; AJvYcCUs3npOL1CUW4hB8UcsAhrZrvA7t8XH+scw9Xk6bv/HQ67J5Ywew9kFAY2pXJ4kzxkwOl2OU9VBog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzalK0YXXT0F2TpmZlwWkrpSLQXM3Y6pkGtZJMGqljlBF3GqkaQ
	hQV9o5wlkKSrIfiv4KtXczjKMNuI016KlyqMHAu9HenFpGQm3i+hB5qNY7fFYA==
X-Gm-Gg: AZuq6aJTKDnmm6KvG/diU80m4OG7EuIIG3//Aihr25/medK7lDwlS81kWzUOECeDHUt
	9eGuFhwyedvPPwmYTfHojH8+6DUSVtX68HTart8tzys3pjssyvqxmgosz1epC4nC0JYTD7zfFmd
	+QduD3L7k4i+mPCXlpF4cjXh8iwPZuCtCfuOcJlrnjdF1ECHVLR+DrtXTXnGreDl2lw8N0Rpi7O
	rv2wc1WbBa9vgY9npH75AEEcQy38kzq4BX7AnD9Zl3XEZeCatBflSXZJLmiTeBiMvfYTLbJuxZf
	Q2uSD6mPJufNR4nFrv3XPIZTr8Ea0k3qDmcUegA6Q9kd3Nw7FERijY0mqGGxmKikJF/z798gvoO
	uETIzmWGg6q7IXy/FNQjJK773ZxpclCyYdXNlARC/6awoOMl/5GuJHX/YJ2ePy36TqXqiENzbXJ
	/zRTbgigTRInqIq7gE9W+mFMf5cA==
X-Received: by 2002:a05:6214:d8f:b0:895:9df:cea5 with SMTP id 6a1803df08f44-8953c80675dmr256086986d6.27.1770769732356;
        Tue, 10 Feb 2026 16:28:52 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc823a4sm2007496d6.8.2026.02.10.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 16:28:51 -0800 (PST)
Date: Tue, 10 Feb 2026 19:29:19 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm660: add thermal monitor
Message-ID: <aYvNX718diaXDsBy@rdacayan>
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-4-mailingradian@gmail.com>
 <e72ede03-94cb-45c3-95e7-63dff0ca3888@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72ede03-94cb-45c3-95e7-63dff0ca3888@oss.qualcomm.com>

On Tue, Feb 10, 2026 at 10:59:20AM +0100, Konrad Dybcio wrote:
> On 2/10/26 3:18 AM, Richard Acayan wrote:
(snip)
> > +		pm660_adc_tm: adc-tm@3400 {
> > +			compatible = "qcom,spmi-adc-tm-hc";
> > +			reg = <0x3400>;
> > +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> > +			#thermal-sensor-cells = <1>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			status = "disabled";
> 
> Can we enable it by default?

No, the thermal monitor fails to probe if it doesn't have any channels:

	[   17.728926] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: error -EINVAL: get dt data failed
	[   17.728945] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: probe with driver qcom-spmi-adc-tm5 failed with error -22

Triggered by https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/thermal/qcom/qcom-spmi-adc-tm5.c?h=next-20260209#n945
