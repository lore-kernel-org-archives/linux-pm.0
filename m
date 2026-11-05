Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793871768;
	b=RpmKoRMgtxKY78bjiVrcFbCswkX9tOFxzDjm2QYUYWxQRe0+e8CTVrEZc4t7YyryDU3j
	 eqYSRQDYrU+CXonb5TdJjFpoj2Ae0MGHePSfbNTE52tQtYWdZn28ZQVIApqzuCqvG+2FS
	 gnXvVIAwSfVYWgauNTcMhjJvqVEWCH294gxS42aU3V1C1mOjcS7BZMPEOhr56EWkmNv8U
	 UWQSVDns+jBb8ScSBp/Qle7aFJOIEyvLYx61JBI/L0NQBPiTyD3+ZIKkCLid+l45OJjrm
	 YGtAeGRn5/BMY06sKyfJNAEjRxCPDHFhNe8npRapMXuHwydreUxg4Ul3dIc/qjoDLuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
	b=Y26f3oh8YGwegGRANFduSRUAwCNsr0L149mBlErTugYjfSDeoSkwNw0BQ3q7hBLiXdhU
	 vk8J4sby81e0PVSOST7D1Q2nz4H1p62T5DeIWa8ySLteuq9fCuDiPopWMgpzC3mpqMhEI
	 I76CfC72eKR1PmMwGlFpp140AfuoEqCxF63riURjJ9G041LMu6mL5s6LtZjCQPffGR16L
	 /t+xJh2RfS/o4k7lx4OtLPwYbUn3Q0VLt+NAppFVdGghDmcbsEgOxwli/C+l6+HoG5LlT
	 riN6kG+PEWirW1PNq9GvhoAWNJvdfwaZYaOG29uEjnbHPRNTC37YQ5+E5rZCL+JbYUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBCZOVag;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C617606A329
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 09:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C617606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBCZOVag
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so1887315a12.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 01:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793871766; cv=none;
        d=google.com; s=arc-20260327;
        b=FD/oqLj8CVydEhjYojYvtwD8IZY7ZRt3a98HY4oZ2aQ7toX51SHdKAIyRMLCt87hJW
         r/k12WEJNMfp58dMJmWdJDpdAJKiUVmBrtcca/TE75pVifXSkn5sChpPrFZf9sQZAblf
         zkyZxciwFPnBCfRsBzlrLSUcUjCLARFHjinlysDUrKOCIA9hN1pLrCb7tXZuy8/ytOPH
         AhxDiBChaB+zl8YVnfJBNCKGHMlOme+ofAQ9fbx0bUkFUMltk3fMgr8dJUS4UBDhb6Gm
         kzdWuJHvMwnN9FpnEUH6d4YPgb8d7dNcHB9Tgoe1kn7RSzUdG9tec8pbQlAQKa8JNVfS
         tsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        fh=WAXBrU325FBFwx1fduPopb0vmCX1WhWsjN2cy2FdCmk=;
        b=SbAIhJmBi3/AEqCGWoiGlTp/+rrYuFjqPkYqHsk3YxahSX0Vtpis9elLY4DWTdsAZY
         9IuQwALL94YRNUM8SKCesSXA01fULipdfhL1ynYI7elqKqr1tvZehfct3voSXTxkIBC3
         d3lWjey68RAWKOCuX8qCnc1MIWXxoszPCsU5cnIUjJI5khYDqXDz72t/EYEsbOArlB8Y
         v8h8qO82NxTrXqmD/R8rGqL8cY3N9MIKLgWSrjbil4g1c4oEIbJSSMqkPZa6R46dqxey
         g62NDktWLV8FZnj3hC3+UaLRVelaJAmDEP0/RAtLMazTPLWgBIJynYpCDstAVT+aeTE+
         JxZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793871766; x=1794476566; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        b=lBCZOVagTQVLd9KXSuiTDMdDSUssX6sHOvFz6jllJYqirrCE9hPUTo49xM4gJtulHD
         mbB90BoJR+kAHY5NgspfzKWw2JtqDRvz3eqaznwFv3AmMzGIX8fp8vhmJSQ0mwgwjguK
         pT2aWtLj5fBJ9jcZbx+nC1NK4eQOvNHWxie867CTF/vf5DFavxvesOEdTQSHjvJofvqW
         wGHKGvjhrHgi62Vy+rz7cAxQP1+FsgnMIG5U7uhcDf9ppFWsbDTtAU5ysfnZYVzCix4q
         cw5IbWu3uYh8SbdQ59hSYfZqX6k7oxzo6nXPyNkUXO15cChw3EeKoUbntDa2K+ueweim
         kH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871766; x=1794476566;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KVyqZjLxhSDOn37BJsTtiq5i2CumiInDbFkl3r3JTg=;
        b=Vd4XTDp2vDP5lhcn4QK+F/fUMfbIdvFs9vE/szjhZ8XW/gn2kaX+AKyop7agxzCx/5
         5dq+nMX0WvmzDAnjQK9MOrDCbFQkQGs+XBessvxn1GHQnZwzHdsW2nj4aGuuHfpp8nE2
         DFQV5xwa8AyMFyVZNqXURrhFxO2LIizYG5fHeUnj5noPCAinlLwS5Av9cgUNVctrZDAH
         cwpluaw2q3kTjQufuPo8frEjA1qw2cfg9VD5BI2LTipVuI2gKO0WWVJHqlG65JSbQgB9
         LIfrmGwlzhv9KtF0xzs5ij7BBphDgFBPNxnCiq5VKXgl761hPmaCI8Obogylr10rVmZd
         MA8Q==
X-Forwarded-Encrypted: i=1; AKwUvByD2TrC6pqRc/ymgMCjGp8WvdSFFD3i9PwoPU9/rcKpPAeEzpm4otXhIJyLKHg7wbRWFbOxJr2JpA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OZKZfrcCnXfWvmKk+320uo2vAbVRWFYUKr4vaXNNZAXUOi7SX
	SOnJBpoXpektucaAWolYitd5ixL53qH/UaUEqIstCOpVf8t6iT39vSoyOsYV1qGKVV9ETkfpZpS
	GipYnT1tKRBw9jSDj3NPTU4v5VGfWGcA=
X-Gm-Gg: AYBFou1wLiMibYL2vZbFJMu51Vk4NOrbgos/w5FZw2DXmH5sfYd1Ud0njmYTud6Q2RV
	G4ZBTrZepGUKgwym61/My/kGlHKOra93B9U9XJSqBGm/YVcCM6r7kbOgdmFOGbc39xZ7WZvZ4sh
	x/84lMOPDLPjcwMv/IyxzTjyPHyOtPtA/6B63154swW8NAmTQkkFBOXanbEdg54eyO9GTliQBA4
	6PNW5EdtPLHlAODIDfStIBmCRfkTzPhuAMm4CYd7gBFEscfqfD5MIppDwZA4EbWmE5HfKXWMuHg
	JBzRTN6jr0s2v3yK+aOrbaBJ4f6fUNzCn+xltos6tskli6yzFrwr4AWvo2iJU8TN9lQ3iU0CGRT
	EuFwWovxlicGEGP5E1KrQ3AaQQ/3XZz+3p+Q=
X-Received: by 2002:aa7:c2c9:0:b0:6aa:a33a:2762 with SMTP id
 4fb4d7f45d1cf-6b4d3377817mr10254827a12.2.1793871766289; Thu, 05 Nov 2026
 01:42:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021105109.199886-1-l.scorcia@gmail.com> <20261021105109.199886-5-l.scorcia@gmail.com>
 <179310028255.2808517.13933580516140278450@kernel.org>
In-Reply-To: <179310028255.2808517.13933580516140278450@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 5 Nov 2026 10:42:35 +0100
X-Gm-Features: AclHuK8keS0URREeVHi2bDcMrIMTrg9GDE11ruNkJWdKZdjkdmjRgehGKxzojT4
Message-ID: <CAORyz2Lv9fBrKZOQ7kFBE+u-nJ-dFpRm_3G0JTS=bHtEL6n_GQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] mfd: mt6397: Use MFD_CELL_* to describe sub-devices
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     MFD_CELL_OF("mt6323-pwrc", mt6323_pwrc_resources, NULL, 0, 0,
>
> Nit: This is non-blocking, but if you have to respin, please use the
> 100-char limit to keep these on single lines where possible. Same for
> all the others below.

Ack. I will rebase this patch over current 7.4-rc1, adjust the line
width and send it independently of the addition of mt6392.
Thank you
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
