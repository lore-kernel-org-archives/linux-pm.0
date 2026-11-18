Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962819;
	b=HPbTLyp4EnFm0gx0dUJ1NhCgagfyOCPjpuka9bYe8OWfcgJxWMBFDnZLrXPdzccOEoq4
	 2HFqkGiBt17DC5PqN6nkEzuIK9tcWB8ut+HTnJNCJZzmFE/Kmxhg3ZpFD3lKBqadzLQ7o
	 8tB4T6KADufjGVuIGBCmotOXQvVtj6s1vM+hsO/3gY4rZZrOzlvA92HdEad/tTfnL5Pf3
	 BptuEijZjtCnXr9NKt7dgmWqBS9pOIE9RSb7eCtMn0o8/4gC4My89/66fVeEL2zQ0x9Vr
	 ngFGcAyA6tgBqUhqbQCuzgH0p44PLfjQC7+MhhftqffaTTI8Vruu28VWQFU19p2ePQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yRsbLllD1ga6dKK48ADUW32xm5TyK5xa4odFMr7mVjM=;
	b=3NnC9bR64VmbDWW3Ltzaw1R+q3Wqjo4Jr6rQhzVaRb3zkxL+XOaGEm6bBw0qaNNbfk4F
	 9JrHxbyMRoSvaBEw0ePCh9XOITGZ6Sagjd+gj3MT9X0eJalxryn90ABdLe90a6U4QwK15
	 agFUsmqoaT7PR0R1Bm+hfqtptZ2VnIAtuLcUaWCAJ9EgTI1Fdbj109FlNS2ewJPid9Oq1
	 3Elhj4heFPVCp/jFnAhRlAVS8VPz4P52RN7qoF2SKZQJXv2QykrO30Q772XoVoAAWCsSE
	 nm06YomhpnEpss26TzC2U1VH44RaBHdw2OpkehlN4fHMOMKsRx6ZCdF6PQbf8C2AavA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JW67F3Tt;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3C606A32C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 00:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF3C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JW67F3Tt
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b244fb7fffso527084c88.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794962818; x=1795567618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRsbLllD1ga6dKK48ADUW32xm5TyK5xa4odFMr7mVjM=;
        b=JW67F3TtYeElTtJVSj5teFMGo+XuLq9otC4iX7E8GBDpg0mGi9yucnrKia7Bi/14Tp
         eSIexKMeK8huhwnBFjk8SG6lsvizMqARIOUWtfYHO9NfflpHvSFk8hq/d9thsm6mWHXP
         7jN/v3sFWnpGGud6a1VP2Aa5S+Nn/kEpx49EYpnsXx/czo+T7rnrcPqfV3eVyCtHH4XG
         EYe3Exr5OcAEFS6iMXQKHSh5E1EMr71bWawtXC+rS91fjBzu0SUUVyzPMIWF7SZB/YvH
         gXwtxwuSy4H0oiXlSWCJHPE8Q1jF/SkvxLj6i4CVDVzh0mEA/fj9Dx1lD0tTZbUmDygY
         +KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962818; x=1795567618;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRsbLllD1ga6dKK48ADUW32xm5TyK5xa4odFMr7mVjM=;
        b=TtMcQ+AGszPgX7gMKKC5c8SufOBGKQO7/peoI5cpDUbwHkDGxQPX3qH2gHt5taJ2pF
         MP4NJ9y6m7Gp5nmltIW01iXsRUCoE3KqHGE/Xh18PN2JT3HIkyUU5aeLHKBuiSlsNUfm
         fg6zSaf+fD42a3EiSN3au0msUhpvUrxA36awnSGGgk6jPciisidRDUYFS4NSm11HoKmY
         chZ/+FJso2IE2hX8QiNHHqbgtD9SkyqDq849aCUute2rekMAY6al/mmygZ8suKMIa/aq
         6oxuzTyX5IjBHTSgot0ur6VLEBPscQD+nRj55ymVI1cdsJ20m8N4TFa1gx2lLK9oo2CW
         NL0A==
X-Forwarded-Encrypted: i=1; AL+hErFu2B92RzZiV0Y3ofXcu9FR9a4n90eTa1hFAv+4puH7FwmJKiNRw+xxTLkodpzfjzba54FeTLmVsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pjH+Y9qPQnvchFgE556d4jThbOgzRTvANl2FmOfMLWCi9HpFe
	BU9BP/lBx71BtiKH7KgaPll9SyFR+oO5l0RKk1neQXJS1iLnx0OQaPO+
X-Gm-Gg: AYBFou25Fm3F9qAoLcRmTiWL6RExhjkGz7XdNxOmlDgvyNy7XMXjN25Zzq4JaAItGjQ
	aVOMTSbfFEm78tc+UqUYEfjsrjgIv0qWmc532GCJ1VYKID4sZKeB7rkygbepvZ2GrXD3oXX2DVa
	tj/bDIDCTY3ljGnZFleKSvM43bPQg5git3eSLH1epF01D7JoElPsSql4beP7YtwVcMOmDrNDy7/
	ReiLnpmX5wkvvzgAb/CLajJ6OsLUK1mg5hnDPjZAsIs3VzLi3TaDTdW1B3MCaqFfmz4G0EdZEg2
	5V42Xc0f+VRIFumivZyTS2rAPAeLvmrMNJFHVSW/ETaDxe3C0bS3l7D4IN5Cs+m6tJImmPW0L18
	zRkz2sX9Nm+ctLiwYNJ8WB6VDYrAZ6CTfOrdOryh5Nf43Uqg0ShbyuWlyEyP7cB4vwbSq9l3036
	WHW9/EtdFnZ5B0H31SvDQ0d7o7vejTBvonKsU6ZwJJ7TalCtrwid/YYlJWPB9/A8J63SoGvJ5lZ
	RaR10AElGzDtw88fLkdYovltTbZqQt5rGkrLL7y21X9mOa/FUSnZOsRNtSIdgFJ4+gq3O5B1pVn
	EaygVRIBNVw3PVYS8wpCuzThJq+en5aKRHnICCNF8bl0WbM8HSh3IM70uA9mxnjCe4WMIL+i8DL
	O
X-Received: by 2002:a05:701a:cc93:10b0:1a8:ff0b:a4e1 with SMTP id a92af1059eb24-1b543cd7146mr1086049c88.18.1794962817804;
        Tue, 17 Nov 2026 16:46:57 -0800 (PST)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447dc5e9sm2505940c88.11.2026.11.17.16.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 16:46:57 -0800 (PST)
Message-ID: <aa081f74-a15d-4ef6-86f6-cd81455a57c0@gmail.com>
Date: Wed, 18 Nov 2026 08:46:52 +0800
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
Subject: Re: [PATCH 3/4] thermal/drivers/ma35d1: Add Nuvoton MA35D1 thermal
 sensor driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, p.zabel@pengutronix.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117060501.2611071-1-zychennvt@gmail.com>
 <20261117060501.2611071-4-zychennvt@gmail.com> <avxhlPnmjDhZlUmt@monoceros>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <avxhlPnmjDhZlUmt@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Uwe Kleine-König 於 2026/11/17 下午 10:16 寫道:
> On Tue, Nov 17, 2026 at 02:05:00PM +0800, Zi-Yu Chen wrote:
>> +#include <linux/auxiliary_bus.h>
>> [...]
>> +#include <linux/mod_devicetable.h>
> 
> <linux/auxiliary_bus.h> already provides auxiliary_device_id, so please
> drop <linux/mod_devicetable.h>.
> 
> Best regards
> Uwe

Thanks, I'll drop it.


Regards,
Zi-Yu Chen
