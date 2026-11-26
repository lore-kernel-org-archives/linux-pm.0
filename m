Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704241;
	b=nU38lKh3UbxTeypJZHM0RmGa5agG63FRxOKD4lgkFLTR9npCO9qg3+44/GeT+/L05qW6
	 2c12i6Lda0KXqlU1axEXUksIqLuAcdQUWZq4ezBM9Q7+yTnasQxzxv9XKhhqwJcLKQfBN
	 CsXY0azldPTzRNZ+6zpSTgb6X7jtE1CUR6Y340fioXLyeyDgPso/LA5HLO67WvAp7UR7m
	 tPK3IvUFAibz3bpfed9J7fJo7k02CTepEOAmtC5h9j3FTQ6dtN3z9sQzzgefy4YpHX4HY
	 jTMMQtm9jy/0NetUo9f/mhoqxwT/o8JunSG2rKvJmxO5PxHxHv3iJ4pxuDpxvUjEaTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4YMdf8dZZ3XD9ty/AOcOBfYoGbewgxxeb9WLsPQ2aAU=;
	b=T5jogl7xg1dUaF+Er5Oep3+XkMg6T4OufIeTdnwME8crVZt+hv8vhZq09Gj9EwPDUz23
	 vuzN+Lpg+PN6I8zgSQI7G9bWK/kI7+UeyG4P+VdkLqPVYTxnV6kZttxWS52h95Ew/uzsp
	 ir5Z/j2hSRZHULXLzNOntmNvhzQ/Io2WpmS5+5xA22aoMkpGwdkM2UWjCSQlhUCbVnZnc
	 gu5j3NTbdxgqbn6HTWKmbfbZnP37M7Gb5+35MkEGAuqOpWCQWYzazSX1QU45WWGEOvE92
	 Cne7d/UP496Dktx+OrlU+8vl7Y9tt9z39WCC7DVcIKWULv0Cz8gzosmJwmplfUwLT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eigWEAO+;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5B606A31C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 14:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F5B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eigWEAO+
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so6376749f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795704239; x=1796309039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YMdf8dZZ3XD9ty/AOcOBfYoGbewgxxeb9WLsPQ2aAU=;
        b=eigWEAO+U3ezl897PKREzwJkRm8DbmgMgKfc/6Ll3Jdz5mNILNZFy3fRXAjKtt2JcC
         Kv2KeGZ6K6/pJz5IXKQDzvmGEkv02rLXOjLbGRx8YgDm2snl53wmLQ6dqapdpsKO4ttt
         DTa9LW8E5Xxgnn7wZdkvQuwkUcaL2DEJH7HB6EdYql2Y8064RzvSswcSiI8Yjl2iU/oF
         2w/vHp7LoONBYtMSoje3iByComSNZY6XhmI3iK5YFQQn1iDZKJU47/v51pXOSLegbctH
         95gmoMkLQcO0NzJ5d8qKNsE/5zKgx0paS6UhENaVDRLV/c5S2ZnijfQEnsknlqTHnCBX
         Lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704239; x=1796309039;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YMdf8dZZ3XD9ty/AOcOBfYoGbewgxxeb9WLsPQ2aAU=;
        b=wGLSlO0YzKscus+oIoaETo4Z8jkFqU2Ktaj0zFYtFotgzzKojpUktq3HIilV6ucAii
         gUhePtosfD84hDgrk++evPkDY2KKzWSwNW42N8uCn2UR3hM12D25rLdvH7ZKr2FvVexo
         9VDpkxdovuXXT0BVElQjc7UsUDHmDRIJH+R9xO8Yvt+A1kTLm9jyMp/nh/42BpEoSXuh
         dSpKq4e+nq8MqGDFMkMIiFKMN27fVN9uPmBaYuOxx3uv2sJcteOZh7iHwEIL3LlbXKMk
         FnxAVhMDljQtZD6/wIguKPxGAnSI5Ztzl8qY4HEOE2CHbFyQoouwUDqtt/rY388bUjwK
         rPdg==
X-Forwarded-Encrypted: i=1; AL+hErHAWU2rQzTruufVSQMUu1njnyYNwKlKg3ypPk2M4YevLKo8+NT8EdKO0xnjNkn420QtQSA5u75Cig==@vger.kernel.org
X-Gm-Message-State: APuU4Z+AhNu2rltfAPYTMBckMMY8vetSoxDxSAivdeB5xSsjk37rJPby
	sS5f8i0O0lv1HFda3E7HWTapoAtrdp8BFCOBWCxrKxj1TOBK+sRDVe9og77deugQlfeehhg5BwB
	llEnPWpU=
X-Gm-Gg: AZFdTZe5l5oDpRtq7lQChqVhxWq6Qkv8oTrbn9ogHFm2Q/bvKrvPadl5u7wpeDjsji6
	MWGfih4LO/HcqAXBfyIQH7s9E7UDq3gtIXYG8nyU6HsmrexJZZ6MwcEFqKspoby2yy4H1nqZemE
	Qn+EP7j6TAGzSkYJFrnaY/Cbj/GrN/0C9WrxQ46jGZas3M1KNu1BzH8OQAsQxzczvvlIS1cqxbP
	cW3zqvQuzldeUzPyUQDey2DUGCmzPSLpm67e7S/nHIitNGAyuCrcpSMj5/8/Gy72L3azE8KSZoT
	VBg/m7XSsbfien70nzrMsBfP5wjQUxHaiPR43ymP5hyGKpteoXc0eY3QR2K4apGdzbgxemQxb54
	r6cQWAb84IyOPYhFIcPQgMOqHPwnT5HJQD5PqChR9EH12rt6hmJMlz01ZwAZime647QNtXo+Mga
	wbMi5OLYA0DlShBuVcYksT09gxZDwxs5IGVtOoTsvjxk9bZyuNX0yuvKxJznKkbnzRcdI2Z1o6e
	ufvrtOq6JhqlbvIYgVIKB6Y4RH0NqzJ4FjF5GmAWQvai6tBECtbeYM7a+r2JdEcSiRxYapXrh8b
	J5yaVfGs++R2mwooLAEGUAdqkYGQsXoPNF/Daxc=
X-Received: by 2002:a05:6000:2c13:b0:4aa:874c:a1c7 with SMTP id ffacd0b85a97d-4abb86ed79amr40096146f8f.43.1795704239358;
        Thu, 26 Nov 2026 06:43:59 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3882sm40596392f8f.49.2026.11.26.06.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:43:59 -0800 (PST)
Message-ID: <4adc1712-3608-4fd7-9eba-79b129c67b77@linaro.org>
Date: Thu, 26 Nov 2026 16:43:56 +0200
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
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org,
 daniel.lezcano@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Juan Yescas <jyescas@google.com>
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
 <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/26/26 1:51 PM, Alexey Klimov wrote:
> On Thu, 26 Nov 2026 at 10:50, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> On 11/26/26 09:16, Alexey Klimov wrote:
>>> Hi Christian, Tudor,
>>>
>>> On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>
>>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
>>>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
>>>> independently of its interrupt mask. Setting it to 0 C limits all three
>>>> clusters to about 200 MHz while cpufreq reports the requested frequencies.
>>>> This was found through trial and error while tracking EAS regressions.
>>>
>>> Cpufreq reports the requested frequencies — are these cached values
>>> being reported?
>>> Or is this what the kernel gets via the ACPM call?
>>
>> Requested frequencies are reported. The 200MHz I only deduced from PMU counters.
> 
> Tudor, your thoughts?
> Is ACPM reporting an incorrect rate or are those cached values?

Both. I checked with debug prints in cpufreq:

- scaling_cur_freq returns the cached policy->cur.
- cpuinfo_cur_freq gets the freq via ACPM call. The value always matched
  policy->cur

So ACPM reports the DVFS level it was asked to set, not the throttled
clock. With the hot trip lowered via sysfs so that the slot 7 throttle
engages, on the X1 (cpu6):

      zone     cycles/s (perf)   scaling_cur_freq   cpuinfo_cur_freq
      68 C     0.85-1.21 GHz     2802000            2802000

Without throttling, the three agree (e.g. 2.19 GHz measured, 2188000
reported).

It would be good to specify in the commit message that the governors
don't see the throttle. Something like:

Program slot 7 from the lowest hot trip. Above that temperature the
firmware throttles the CPU clusters on its own, without cpufreq or the
thermal governors noticing, so the hot trip must stay above the range
where the governors regulate. This matches the downstream setup.

Cheers,
ta
