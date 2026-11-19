Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079592;
	b=kZsO8vwmUjjdR0O4hXGQEA43kk93HPLnSAmCYJRc93GYVBjasvrtGjzgb2nf/Y2ohlOY
	 VIB42bTwjqen+iYyJpgwVHGs4ChKlFwTpetzO5ekmWzdlVOAvtdhZ6GhO77qrvEGknFFX
	 iB5Gbhm9G8ES5Ue5nEBUNm9e5N8iY3c0/3x41AmelehSK/KR15z2dyjltnRv4DemoNxoc
	 oJAUGZDlsnYEt1VypyVx1exI7wl8hdnkXZ4Az6sn5x4FDJyCcNzVWmpdpA7n7tezBDk5b
	 6KmEZxoMcVktmPH0HvHz6oG4QQST0EFWDy/tnTIRVEnk7Ur+As7l0xRpRw/bduf99qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
	b=kSP8vBdwWQW5t/UySzSwgA3JtmmksXIlik8nOu6KTTXMpbKDYWaHrxOqy1Tjg08IPs1z
	 /HOUkbz01n1zOKxiLLbEZbaR33HfsbLS6E7l7JHsy9eKiywGArRlbKQjiYimlGv+3xoi4
	 8SD5bX4MmSosB/jHbANHoOqX0jpuuxOhCCGr0fNWWrdcRpIwm6iWUOp5tef0wCHgMuc17
	 h5f0QAz85I37gmS8jDxXhkehoDuD1QfO1ofqX9AwzvcyZTm8yAmYpkM3d5qjHf//gsoSX
	 47pYA6MBFomn9yJyUzZMqNKavJssSeywHMEmm+AzHEIpD7+6rH8jDmJ4M8VPn1KpPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=cyYxEfas;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2C606A32C
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA2C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=cyYxEfas
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so260958766b.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795079589; x=1795684389; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
        b=cyYxEfasnJ1RB3+F9HQ3kC+3x1Suvkc2D89LpTI8+pw+eAAwycdhqJavNg6jfArG06
         7JOCKyjIFZw+nr/clzS/FlZF0tkW/tGCuolgw1y+hnhHah0vaD1owxv/OtpdlF+et24+
         5L6UDEJTNVsrLK4J+ku1kAWCSku6cLc/TckT9iAM6R+oPGnlb1CUiB3kUc5/c+MqFRyB
         stqsA0fzEfvyMaiEWLDvydtQsTclnOH9ybTAeNhVohSNOZyB0c9EwQfXP1kwiRFNT07A
         zWt7aKVRGzi7F2YU/x0W/Yt/TXqrDRWJJU0hid5GcWy+qSpR7k1tulgob5DMl37cK+Wq
         ZePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079589; x=1795684389;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
        b=1mRy4ChUu9ObIw7BVfSt8FichN45o5W0sRYXWHJL/oUTmoT0fA4YiXHpH3afpbHmJk
         gB6xgbNk3xbT+5Et3/dargg4S9LUGbPTUGpaHJp4wcg+bYK/F0IhAX3PP/5jOqILExGL
         65kZFonQ3dVQDBBYgy5tzPAWoPdGjbipeAla86q7tVZf4rQHou4CkX7uIWchD5oYgl4C
         CXGdAT6yDNfpE4AMndm9QN0ACrg2SbfumvFDjLcs2bTDZh8GATV6SUnvz0STwNku+ji2
         vpaqPEEELGRG9K6khHqX7Y4uWV9chJWdYLLpELDChJcJKaJrumOqBu2E1i59iFyG1KHv
         Cqng==
X-Forwarded-Encrypted: i=1; AL+hErHiYRalWcH/seIa/HCB7l8c0K+L9yJpSmHjYGTnp0YVKSQ6y6ymSfZY7E+iY5CcQZX9VODAGD6YrQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5gIKo2u6VEcq82QsjA7WednZwln4M/ZSYft0L2w7BroEm6OQz
	qMqU69WT+1sGz5fayJyWjV+wQt2kwDEmraT05gFroQI5XWSxyfz9P2qYfE2rIqsKTZE=
X-Gm-Gg: AYBFou0GXzoZ2KTHrEiXa3qPL87DEW/W51gmLgYVbEyh7SadMZ/uZU15Cr0G+dbNBby
	tJyiOUcQr1CNkakadjWwCnvLNRyKEMyZ1tSbyNfeMZiy/8CYspCRKPw8OU2/uoADvoM/dZNnMG8
	p3DpP+SU2d7ExHvnGVoGkk7zmKCN4LSVZxLQa8vjw/glcnaA0JP8IOtS6qsPdmjLXy2M3Kvp33D
	TUdI8VMWAnJnXEWe+4oBd6IEsWJ2aA2bcISCZAaUHAjc3k3OOvQSDz9DyXowG+cv2kQutBm8D7R
	72PLx1t6pCQmQqOnpKB4uy4x/3s1sqJcg1nP8d64hJIVZewd2Oa7JlGh4UwtZxcOqOWza2KyJRQ
	E3jDjHDfizjTInGChLgMBejq5ct2s8tj5Un6u4FIedwzhEyl84feFZuCCKxo6wSy62sID+E+9T8
	vew4v7c+QUUqi9XRMdzeq8saUXGG/NjOK97hHRQkMbZ0Vc8y7jB8d1MP8+2ug9PIZJvspYh6psu
	gisJIbr2QuekHFdlMuL02/Ai8PG5b/am+cZEOVNlzCLCg767vyePipQ0Hp60MMqWurVwGaAHg/s
	xxKLH+z10SHt1SJqsonxq3oU1AGi94uOO8X3WinKfykY7qJ65O/AHzg2dQTUo8O6nXCcF78UCg=
	=
X-Received: by 2002:a17:907:7295:b0:c31:8cfe:9a25 with SMTP id a640c23a62f3a-c510e19d00dmr455876466b.9.1795079589464;
        Thu, 19 Nov 2026 01:13:09 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512341e0adsm87945966b.36.2026.11.19.01.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 01:13:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 10:13:08 +0100
Message-Id: <DMZ2LUM6AWXG.4IUB01OTC2NF@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Rob Herring" <robh@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Laxman Dewangan" <ldewangan@nvidia.com>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Jens Reidel"
 <adrian@mainlining.org>, "Casey Connolly" <casey.connolly@linaro.org>, "Val
 Packett" <val@packett.cool>, "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
 <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>
 <20261118164229.GA2892053-robh@kernel.org>
In-Reply-To: <20261118164229.GA2892053-robh@kernel.org>

On Wed Nov 18, 2026 at 5:42 PM CET, Rob Herring wrote:
> On Tue, Nov 17, 2026 at 09:23:12AM +0100, Luca Weiss wrote:
>> Document the property to allow using this sensor with io-channels.
>>=20
>> This means that the output of generic-adc-thermal can be used as an
>> input into a different node.
>>=20
>> As a specific example, generic-adc-thermal takes in an ADC io-channel in
>> Volt, outputs temperature in degC, which can then be consumed by a fuel
>> gauge driver to provide the battery temperature readings to user space.
>
> But this is already a thermal-sensor provider, why wouldn't the fuel=20
> gauge use that provider?=20

thermal-sensors =3D <&my_generic_adc_thermal>; could work, yes, but IIO is
way more flexible and can support the required use case very well.

From what I can see no device binding (or Linux) uses thermal-sensors
apart from thermal zones, so actually doing this for another device
feels like re-inventing the wheel when IIO already exists.

Please also see the cover letter from the RFC[0] under "1. Do not
implement IIO device in generic-adc-thermal"

[0] https://lore.kernel.org/linux-arm-msm/20251010-bat-temp-adc-v1-0-d51ec8=
95dac6@fairphone.com/

Regards
Luca

> Seems like this is letting current Linux driver design dictate the=20
> binding.
>
> Rob


