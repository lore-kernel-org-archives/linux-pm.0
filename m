Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499885;
	b=3Hz9zHeTXvoaIB1g74j8so1FVdanTQMPuBLBanpu+3SFgngXJtdiynsY07Y/YgX2dBSA
	 xPBjqTkUZtnYsCUWIGOtoRxZN7ft01Pxn3ynKs7LEP5YCSFtdj/ChO1ny9SuYM3I+nQP2
	 IyE7hUTKPdjZqXeYFnKfzf7wp9VWXnYnidZ/CJOJCAuoHuIPO931oYF9sN7yph6K3IcAs
	 7VLNNo9Js1TslIWy0RmNqsX5ZhoN577yTKpwpM3N1vFEmxG6A/AH0RqnbPGU7WFnbwfjj
	 wyX52OKGCEgDptf53hGYAPlnfcuH5nxMW9lLch3dbg1kYxztgOGPGhQfeNB3uTymziA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
	b=GSmrrqfjQa2WjW/YsThU7HlI2LwQmqnjgaXT8dm8fjB/Tk66suSn+Tu+PoJN9Cv2djkI
	 J/HqroUbieblcoHiz1E7edNKyOkWH+FAVHy3JppOgVH5iXNeHkg6Cu0B4GpKdWkjuQbUv
	 Z9gNklYk6y22oq3cKkqCahZ2E+WmHKuMwcmplN6q1vMQXaHLXegHKnDb8+6OHAmG7HLj2
	 f8jVbpgcGCqQo1qApzkRiiFIEBgyrHT3gMQU1aUJpjcBO0DB0ByEBTTLr8fMLLw2l3Bby
	 LlX92WreVhafP/IU6//HhhxAd59zbuqy+lFcOaj2p3fjLm3qIzKpv58lhg/7/2NmsDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmwbXUqD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1E606A321
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmwbXUqD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so5995854eec.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792499884; cv=none;
        d=google.com; s=arc-20260327;
        b=C3Gj6Hcs2aW1ly57FjTqTfrNx6xnoKUOPMFK5GimuBodMZlO7GWHS2lqy6vJieSs4y
         7dC3GrjU9A2udTWW1hhyCNF2ImJKMGiycsNlAbcDIt5tnHOJ0NyMSRWrQxHNvBA9AC1S
         Eh3n/NinRa8A1JChZRxx7hI9zbn3gBzmeg950P58rKAGob8KNqfPiVItQ1vl4GMk0PED
         Gv761wmFMB9KECNCNMPySTy7kTqj67OxA5zvz5zorJlz7ae8/4NAiC25ZxfnMybhrAm1
         jIUnplb0cuLef1AS3qNT6cz6IYaW8nQmRM/htV6EBqiC2HiheRiBE6mhRYr7s/YQKrfR
         N5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        fh=UnVvkey9PAq83qA+pKyJ6bI+ITg8xq4Acx8RuKIF02o=;
        b=glnHDE7dDd4Sf3VdIlXT1fIP0gPe3dn8ad+n+dOyjYZ1zfPFTtZwMujhvq7NdV1Wta
         ePruOusmgj8/84dJcm5YIMcgu1vNCYGBiQ/kmpXtLTiu0PwGcadKsCk8rc1vtKBju5LZ
         iDIIQ1c1ANo+dqvHDYGTO3AAxdsLuNeDaE+VFy6Qk8D7LQgFqty/ehSXciYj6vgsS21t
         mfklx94tXscPG1EnJRFyErjFbwlHhALmOqye7D5A7xzkam5Zvh/yo0lNxC8xGzsVV1x5
         a5g+uFTWI+AA0Z6uG9VyQlCOMboWtWEybTMh4ITnwPDfKEdN/BSslCtUmMzeXJnJ11Cu
         T1Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499884; x=1793104684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        b=jmwbXUqDvmKk+mts4P8S4Qs0OykPCvL+ZlHj6qhWGIspF7//gQi87Ih8CsHjx/61yv
         wGlS2HpVAHZ3Lu2ZAPezB2Da+qfjRMgwpyxguCAQwdLYXpBwUdJpC53SL8i1C3AluBoz
         PqzIWp7iFtQ3nWEao5a48mvkJxBlgXCvnVIAufBOZw5diHqP7Uv+RTsrse9gVOp2u64n
         nYOWDbEr9XRZ0rVc7jU4+prj4inZNvasO8f+AIGIc9AouBH/JWrRm+lojVGH3yZn6mxl
         TAusewpHXJcE6mPh1y6HGwM6WdkqGXkCVqe0uVPsAZzpnXchYt+hz8SjLjcXT3/ExGSX
         1D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499884; x=1793104684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        b=dVaDG1bCENTmGAMlrjCz2GaTzTlMy6xPnuCvSuAONezbt15ne96iy9OnWF7vzJJshE
         L5rfut/SGrOegtSZr0JCDQc6V7A+4+L6UKo4E8a/wD58JvDtS6jgk8kfOM2Lpov31DeC
         a2ILViteL8GVMuIvfYiQpGVpvjcibckoIJ96WAKt7U9kWoj/J5CI6WhEDbmFcJk1PxuC
         yX0Lix8SVy+6IWB10I5rEcfwqzZBrWokd5Zt5xX5t/7gwB3GBW17uD9aOLUUHv8T1Ily
         mdie0KQIxDC1KkQJr2CAt/+E5hmN8d2AYKUONUe2prnATDxZ3aV6ZCZ3sl9j7RL/1vPO
         IMWA==
X-Forwarded-Encrypted: i=1; AKwUvBw4m1/P+7LFv3unKECcAf2/9DTQa+hwQ8VaLHPUwJZVDQbFcvoYij9B7r+a4VGPGns/9W9onmPTcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJDX9nWlUIZzarx/Pr2xCRqkwg3PNyhqaxdZNc7GHi7Z0C4JwWp
	M6H58BnhPc/Uxo+GPfCe2PH4wD69dgUy/6mWQpmK7s8O5evX4gQrZDRoBfd5ivFg7r/nehIuMiL
	gW7fXXE4bJpqFcaOn6/SZiqriM88/gha6BA==
X-Gm-Gg: AYBFou2bQspZLaEp6mFXmfWoVV2YJicQU+bMoypAu8p9aHGJKPKEU4iadGGDg7hhids
	cgBV1qPllrOeRBsIKoqjiLpecpoNwkgNR375LGB0LJZJdFfrGgoZokH27W4G+FFPD5KBLYyl4Li
	mrIQQM4LSIn1GuCqWf5r/iDNg++/qOfG3QiJuJCdV4ktouyurSRwu4ktAalIgPLTlDq2Fl4Glda
	ecrFL/mzIfMuR5ZRqoD0ZXr6Z2yOooOeoS0s6KXhpGGbpknpNaa05Sv9T9XpaS+gFaSNzcOSbqp
	Cc3cIu3XMD2/NnhvNTnx2gH2B2Np1LAuHm8jZlvOwqSv+gQW2ixW5PcOHV7I3QaOmQwxdGhr+qw
	Vg/2qCYh4DXWiF3hJI8MFMe4=
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id
 5a478bee46e88-361a341c8e6mr20929064eec.37.1792499883433; Tue, 20 Oct 2026
 05:38:03 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-4-clamor95@gmail.com>
In-Reply-To: <20261019100406.103687-4-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Oct 2026 15:37:50 +0300
X-Gm-Features: AclHuK-m87BDNsd06OZo9qyUn54gIAUFrBH_nvo3N4yUY0ynQqrl04tZBGoSFNc
Message-ID: <CAPVz0n2qqMzhbMt+dTaGv1gmrp1xmxJP8ZdQV1EcSpKkneFALA@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Florian Krischer <florian.krischer@fkr.dev>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:0=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add input driver for ASUS Transformer dock keyboard and touchpad.
>
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/serio/Kconfig                   |  15 +
>  drivers/input/serio/Makefile                  |   1 +
>  drivers/input/serio/asus-transformer-ec-kbc.c | 264 ++++++++++++++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
>

Hello Dmitry!

Would you mind to add your ACK/Review to input patches so this
patchset could be finally picked.

Thank you!

Best regards,
Svyatoslav R.
