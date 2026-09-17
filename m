Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618234EF13D
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663922; cv=pass; b=TnCXVbLYLB5FC2JNwdXTCJB1xQRXa239InUMN0s71Llpc/0CxAz52Lldunlh96xubs3rFU0UfEFAv8E9qIWt+Ws/1ZrkdTF3tSuD14LReeZlaSmjeUjN0DOFBctC7Mz6Vm0X7BdFJJZJucKt+SYgL8Z8RE8u1SsrFjiijpiHiEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663922; c=relaxed/simple;
	bh=hEHMAKUllCDwfWN1D2DXADtsf72BtNJRtUxT6u8f6tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXcW8snae5ryHN35gZdcumXpET4GO8KSqG2+LZYU8fQ3XHMyAmR/amtwRMOwLJlKT6BmFil4rZvzrJfGF0KgOJs6JiCKHIrCF02woznTvxrigZdlCMQ852H324xokx3IQ0NSWCiPX0sByChe84a9XYk7UAZUoeGgTbw0CbdMo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umdir/c6; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umdir/c6"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso1771592a12.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663918; cv=none;
        d=google.com; s=arc-20260327;
        b=UgRHtSs6/3l7a7W8Fyd5NOwXNXu8kSKTT1qI3Y+8bhsMfeBxhuP+2TN5c9rhCeeTGB
         JGrEoDJqZ2eo0SiJMUd1uQWm23HLn1cBrmRiEd+SBALu/ODolvW3ka3G8fgGgobtLe1O
         ftdvjUhl9sJ/wyXHNrAkkt9X6uCVAEOoVeZVzL+dlDmBD62V05J0Z6GkIA1O6ukUmOpp
         zXW43OYOByu1tggHtT/Wy6iBbESzKDl8GQJZk1Y2ot/Od2mw5tqZMMYTd0pQ6SKYUfFh
         bIUk/MinaGCbKTAnCE2KCaoizZV8bNZ57UAbYFoHsi5IisrvrzJicAHwiAR/uy1uLWj2
         09HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        fh=lycnVm8OUvlyCHZpWePNQc3cZM5TXRD4bCTifdbhF94=;
        b=rhtbBn2Q9sk7S1aGfmG1F/GKPmRncYauVNa+7IhdG0/vnsIO+VQfJX5k3927yqRuFn
         +fBOoVPSUbi4ojKlrktHfF/C9lFjsjAxg0uRTCqVKBoHWqDZYgWDQveVPjupFEIKfOwW
         REQ8lOgxom1j85WS3h1hzA8+mI/WwMRLDo3dxsKWEDXxAcEMStIVd7ychfGIgczIkayO
         +gHm7LccBwrH35lCgnRufpB2NLylqLd/enOZIn9KdsiC9kvtGIRhKWKaV7I/CJKxOVSN
         yt8yMksWngB3zMD0Dbdxlp+RKHTAA7JYt7yymrBOHKtwNJD6uMOGv07tZuW80eMMBWUC
         rZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789663918; x=1790268718; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        b=Umdir/c6HrNFBOOQJduM6SqCOAdwSy6ZyL+u63FbbjqPSkqXRet/5s+yDMp4YNjYN3
         Ita+VQyRcFzmRG9DQvzdjIErpzAlOQM3yfnWdmoT+BI0uhEAmm7CNQ9zBBHIE4PTBJsT
         u4O29zn1XHk7lfqMIu/0IJrlYch/5fZv5NcCYTQPSHGed7rsq3bxmci86KIG4CKRPazG
         26n1ETA8jIThSMYV/LUhzaPBsjUpNVu5R2qhDe/PX2P05Y0mkxSf6WmsJfcI50NxbVuT
         zhHAtNqzxvTxNG7xhPfFeuQyvKu3USpvLpjVAoPyXm6bF5jAtEYIiIfgReVDGHskLX5T
         ecuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663918; x=1790268718;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        b=bixv0DlRd54iJKTUHtiQLxJGbzjOzVALP+kF5PlpgmA9U2RrwZdYfU+Hj+Yai8Xrdr
         xzyw7Pe8PU6C0X1hmq3Z5NPXan+wMi2QQVfAmH8WbdG3HpZ0+FZI33Ip24p5Ueq3f77v
         bWPCSOgLYPlndBZqfbPJ7P596qlFxHPkz4gYUkW43Bst9B+vtTSPgCh4qff+lNeKkAL2
         QJIInRqJKRKDoCQ6tHFykl9Zd3RzQ7zDUkbW9d9+wITwYGqKHUJ26ZgikPD5vOX9Xr9U
         316GNv6iRPiUQAYodb28kY4Ds4MKzjxloOGVcGBQIWnR6h21rObDhTuhAzruOh0heP4r
         xFPg==
X-Forwarded-Encrypted: i=1; AKwUvBy6/fzva9kb8eFOGjntMXhWKNqkfLfHurTvSdvY+ovI0mNfllmlnijUzEDsoz+bA/7apN0OYo21LA==@vger.kernel.org
X-Gm-Message-State: AFuF++luE09sNpG7uCJCICMqT3+JB2+BMod6a9f0MGz97WO1Metn8psq
	nlA4z6IAuIdN0Mj74HG1LdXylkioKXCfuiQ/HpXSG83kbwZCx1pfYQGqGQNA4zwHry5jQkv9jCU
	3eicTE70HeaBk1rRxl03pOeGclHuXf7Y=
X-Gm-Gg: AYBFou1dH0wSUs1vtBCkMzVLyCMmGXvXWv4sG3QEy9t5F4XjKFx1xOc5+dOVjQkxsT3
	OVu6LAlyeB86UzvjS5V/sfITB5SD+VvBgsUe9IMiyIN7jMtYq/H6tIQRHY1YTbo30zyECKQKZZq
	LumpjU4UXLP86ampUIh7qA24am8cMyYaYEFj/z6fI1/FAkDWbawrJSocjxZzq5MJJDohup4wVRi
	5fxyV3k78UfljxAaLGByprjGOWidMTLxJODrJMf4Mr0dnMmyPiancVzp1m8kywFJfu9pfpFLzDo
	ac+zs8+nFeFZIxkG2nBabnOUs4upi527h54mwVQ23Cr6619DIO0HQYE=
X-Received: by 2002:a05:6402:3789:b0:6a9:98de:6d8d with SMTP id
 4fb4d7f45d1cf-6aa2245fd0fmr5568315a12.45.1789663918221; Thu, 17 Sep 2026
 09:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902193351.185771-1-l.scorcia@gmail.com> <20260917143459.GA2348773@google.com>
In-Reply-To: <20260917143459.GA2348773@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 17 Sep 2026 18:51:47 +0200
X-Gm-Features: AcwNN1UCLyUlHms-nbsVMpe5KcLakQ0vi0ozu7P9tcFuOM-WKvxcQ6ubbojqdxA
Message-ID: <CAORyz2+rT-oNJtWc5BRDrpUjBPVbO6A=qrX_K+J7fAR5Ebm_3Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Julien Massot <julien.massot@collabora.com>, 
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Still waiting on Acks by the looks of things?

Unfortunately yes. Patch 4/9 [1] was suggested by you in [2] and it's
independent from the rest of the series; it could be merged without
introducing functional changes, but I don't know if you can provide
the Ack for it or if a specific maintainer has to provide that.

[1] https://lore.kernel.org/linux-mediatek/20260902193351.185771-5-l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260520150014.GF2767592@google.com/

Thank you
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
