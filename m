Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A23CE49A
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233715; cv=none; b=qSv8x8bA8vjxQ/luJIXXdbMsNCB0rMiPy1VLQnv/YHrHjZAbK7sOmS9zFUU7vf+gavygOJBEXt6B5ajL/ZFWmxn+PkHbtB/TT0WXnotzJfSvjNaSdvTTkHuNWineYPFhxMIdFD2DNqyE5AIE9TFWfdrCNhHfb9WI7rpBfWGJiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233715; c=relaxed/simple;
	bh=aa2PFgD6i6VfPTSuB5Nzc6oa7i1InOLAX1+UAJ3qULU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eYVVxQowW2mNmW7ZPR5Z55iFf1T11VlCau+Mkzv+hyaHA4u9UA4XJ6iSUEklepV06sBz5iJ3zrhq+/WSK2s3HD8cKvXMyUwYDOqG4QN3IpZZDxGgdwGb/RVKgFXBrBiwpLHMiMrunf8dL+2vZmBCmUMVH1ZqC+JX9r+38/4oFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8XYYRJ1; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8XYYRJ1"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-827270d50d4so1873953b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233707; x=1775838507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJOmOz2L9YVEihHhZLWaE0nc/BZm+kqpkZgh3ChszGk=;
        b=Q8XYYRJ1/ukSDk4/1Lu1S9tDOgxqybcpwn11+PwifflPHjQIrCyYNwo24Onls6qP6w
         oI1INE7RBukDjZtExhh1MnTtxVG08EFGv3EgMq+7rBdBgufJuPS5LQbnNwnzNz+hnrua
         Co6AJl/AvYz0ofV68Qu8cCxlIzVXi075cUtoN0yQn05YfPeVJTFBKcY5Lc3Qw8S4Pa3T
         4nVDi1rE67j0j9T+wLglClo9ixOY1u4uqMIOMmW/+2pV4Re8CzOG+kNVqaVND5q3ExJi
         /wCUkoyDY+JjOas7HCHkZKAKyrIsZLIvUjsDYZmaHC5rpQfQEoQkKW0mIKn6MXrwIGfj
         1X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233707; x=1775838507;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJOmOz2L9YVEihHhZLWaE0nc/BZm+kqpkZgh3ChszGk=;
        b=anjJmyc4Jnb9NATSVI5CcijaEtcGfuziYqhkx4H5mLdLUT1xDy0mmCx5dCIO5U+5l6
         wEdcJ7epB9Y0tOmwU+YBDTK9vYusaeJASqbEmiuTloIY5heNE0OAYMCwYJYsOqWDfhhE
         VvRgSgd/ieUHEgHsZLUVOz+xrFYWlN/JL93gKn0g+rdmELLwcQU8O8JQRkdB8TlquzPl
         Zzo6EobMhZfFRm0NaqDWyAu4v4ruFUQ1fkYheLIhoA363ZlOEHqFd13d2BDWFaJmfqSK
         XQURhLvOzhJ87Dso1D+aNDk4L3ZVZsHEroPz8Y5o2UnLeRz86Ax/TgCpLndsw9NCjYC8
         /pzw==
X-Forwarded-Encrypted: i=1; AJvYcCXP5umnuQDVAtT103dvaJSnmbMkqCtLVMZvUzs+tO+h6O4JNU5zVjc21/NBsZzDvd5bgA9r2N4OXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9EJE7MEMvYTxo1nUTxgdaEqhSlZ1bDm+f6dSokssfgRm3DRrI
	WJarhELQ8230z0JB7TmQfZfNEJF3E9xJRO0E8ztwu7yNrUEIwt08OG6x
X-Gm-Gg: AeBDiet3BmU3/UUzFtegUaOFYAtQLWzuqlX84kFg8a2jFiB3+ILyiwgK35aCr3zRvKT
	BgG0Jrf3EznFm4L8WPAwRECvHa8b6H/aSjZqniy2Popap2/QbOoCFpN9onp7OBjUSQg1gImmOeP
	JGMw9Rai2cIsrsvFLeukUgZEhTCwd6V9jpYv8/WwmWUcZjIi10Dfyw1nzUI4pNz6MiGJOzF/r02
	afnLjN3zalEePKObcPc65YzzvaUJvyM+yM5wzmTruP2rAN1JhYfCnZ0vSU9NybpWIJUb2WVu/eq
	rmYE/rVxBG4hRGhh60VLrqyeGLL0DnMdEc6FLvYtz7s8MeZ6nzxnu6lpsE1w1oN8C/BMPegZo9f
	merJF8fUtEmKZiXQkREc00NTwjmUEnQSE4ybSG/X1QbTkMDTaKUDi/vIBhn2Yfg5AL8DBvdXivm
	CoH52Xl3KZVFYXUczNjseBEDl2lDmjJe3HLEFsTCHE
X-Received: by 2002:a05:6a00:3902:b0:824:a01f:6335 with SMTP id d2e1a72fcca58-82d0daa3ce1mr3501828b3a.22.1775233706143;
        Fri, 03 Apr 2026 09:28:26 -0700 (PDT)
Received: from [10.116.188.94] ([114.254.1.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm6592724b3a.38.2026.04.03.09.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 09:28:25 -0700 (PDT)
Message-ID: <7792fddc-0218-4889-97c8-42eebadbb343@gmail.com>
Date: Sat, 4 Apr 2026 00:28:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
To: Vincent Legoll <legoll@online.fr>, alex@ghiti.fr, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 dlan@gentoo.org, krzk+dt@kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, lukasz.luba@arm.com,
 p.zabel@pengutronix.de, palmer@dabbelt.com, pjw@kernel.org,
 rafael@kernel.org, robh@kernel.org, rui.zhang@intel.com,
 spacemit@lists.linux.dev
References: <36cca49c-0cb4-42b9-87ae-702df825a4a4@online.fr>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <36cca49c-0cb4-42b9-87ae-702df825a4a4@online.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 4/3/2026 8:57 PM, Vincent Legoll wrote:> Hello,
 >
 >
 > I applied this series on top of:
 >
 > - next-20260402
 >
 > -
 > 
https://patchwork.kernel.org/project/linux-riscv/patch/20260330-orangepi-sd-card-uhs-v5-9-bd853604322d@gmail.com/
 >
 > I need the the SD card series to boot from SD card.
 >
You're absolutely right! We do need the SD series patches.

I'm actually building the mainline kernel using meta-riscv, and it's 
default config
already includes those patches. I completely forgot about that.

Thanks.

 >
 > I'm also seeing the same "it works" state as Gong Shuai.
 >
 > So you can add another:
 >
 > Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
 >
 > Regards
 >
 > Thanks
 >
