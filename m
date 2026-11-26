Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706474;
	b=JizlmIBrDvSEv3yFhc1WjEv3tgkT/c1PcajISXRisVoYSsE5P+aFRG7WZguMD9k0T44H
	 yTdqSMbUZzV7JtNEMyO/65zK+UZRZeZUKItQ2Bkv7uQdxXGFGgqtnAns4DuioEdihCSrP
	 SFwHfSFv7qaZn9z77mQpx5TvJUukl4h3Zm6h4EDzB3ruI16wNEhoF6bSYLOU5K/mumJfY
	 sTQZqXyZmH401MSCo9V1bNQHoK4RqzGjuGTp+60yUjb3QbZ/cR/gYoo7vHopyud58sw7y
	 1jbQg51GhlUEd9E9RV5e5Dv2rRqU3jO0nK5RAJ4xEB0BhnWARUJNuXG0zFkR91IoAew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=kILnoOSlT2YE/zjHB9okNcwTkN0bcn/3NhvFP8gsjgo=;
	b=2Ldyc5IrZb5n3BLv6CFB/HNsTrgFYoSE+Z1D5nWqChyr9/0EQ5Z61XAT72m6zfbsbF+t
	 qudSz3WhM2VbFltf0OWTish/EpC5Oi1cGtV3SfBauWukgzfvjGzKcoHjTyXf8RKHknd/4
	 Om4ETeRblX6J7M+yc74MTijl7CNsiCYdu0JYrjJfaZ/vnomCg2Sjyf0WcIr+J4TuNDFcB
	 o7edcqrtYKh6uhpaxtB17Ji1KAI10afySgmFqZe3LCn3kJ/szPk+t8g3vYQJvc5osEeus
	 +FcPYAsyb9cjGxTy2mU+bim491EXbmhyE4mrQfOLO2H6A0UKtC4THC244gWfll+xW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e69Fq7fP;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E4606A32D
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D96E4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e69Fq7fP
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so18255865e9.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795706472; x=1796311272; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kILnoOSlT2YE/zjHB9okNcwTkN0bcn/3NhvFP8gsjgo=;
        b=e69Fq7fPvZ+l6DJ4RuxB5Db+9Wj7K847lZlms5v6qeLbl51+9/jHRa7hRe7c/nDj+z
         Iy13fy9h/nRnFN5lIy3yK5MIEy2UrEOhOfytdM3LvUX/X8ylSQa7ku0PKUT8xsWP1nv3
         1gag19RA8dJuMJYXg2IoSzAcAyEFjLF/cMs6Cq7zw8zaAORDuCCGJOqcvHoHtIlVXfLT
         XHQRgT9iTZbEDwyhsQrQkd9b9UBGVNAV+eVLThdljEDJzpKZCDk9gy4aELxsiZbIfIQG
         uRiDTFqWcregBRuf5UQSSnVM7XiN4MhZocEJatEGNL3k3MAFZJXXZhE0uWlM6TXtORKI
         dvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706472; x=1796311272;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kILnoOSlT2YE/zjHB9okNcwTkN0bcn/3NhvFP8gsjgo=;
        b=QZBGRkRQJMsfSbCxsbpiGLFprkpXJi1l0Wx7JPE9YFwoAxnzjZYP4Lfg2qvuqozwrO
         bbtr/A1PMyBFy9VaHm6ov5KhY9Mg4hF3eDAvDOIA96BJkmS0UYfS5pC0MWWgiez9GA9v
         Roq5mBcy89dbX2p5XiRpZg9wIndyH4X9ik/0DdWCN+eNQK54BkXuYLOUti/FydNze8Qd
         lTWseN8/fbUJUpGbhFctfJpYf7/UPsE1uPv69Xs2pRQOd5zVbcEin69tpynX05AFsYKd
         /9jEYkYoiji6fNSc5/0fP4uEveu10p89cSY0+N0QeXpiqfk9/lSrsxnGo/snZ6jYpN3B
         Mtuw==
X-Forwarded-Encrypted: i=1; AL+hErEpx6nIGNsqEKhKhL+e6pVnY8iyjnBEG2Xho1BYURHas7SZGBkmLewhitm8pO9dIEIkOr3Nlr6c4A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/jfxrsSFP4G0eFJDbLSxhCAk26TrKTDNayR7mQ39RntHJ9ffFh
	ip/FyMLR9/7EXlqTxY75VRmOiNQAKdKK23m5SdRr++Y0xyETBT/3Y38Oa4EMeWNxjU0=
X-Gm-Gg: AZFdTZcY74qg/KXrwlbfDPC1GhDgf9rIQAGI8sFGHw73DdivgY5yOVXimXlvBo6r6Uc
	4ZAo3jh58k8yq5OZ5vJ5hJRreeyaLO1UrA8aDkJefaTXHteIGQCD5MTP5pKVNfLrMuLkn4Gy4Uk
	W7kbX9bbdbxNRRhYi/0UEgt7w9oXTJznfG9jgG2So6g5XHkw3ZCTekWKXB9fkJ/ARdKupukJVa9
	lRJYnqnK7W2zpgOiwm3vx8KmMEYXvlVX7g0//5TUBGrKjwDwiFOlZjMv6q9zOPln8f/dueYOmD5
	SkVgHu1eTbVMSELFdQVuZvIUMrjmmZWrPdJzy/AQ5YGyzwZdMJupBmLfSZ5/KTpDCD053b/WaaD
	mo/HcHfdc8jdXFNq9y9aOSQ1nyO5GVI/iy36pQDY+1upaekmWHrU09pKillSrtCSPLzdL22n8Ls
	mVMAVepzf+JKnLXQfxJHZ3yNuBg0SiLjGZmOh0w9OYpOndfNGh4VrNhyiHKONT46tQyRygFqVed
	u/R0fJ1OW4S0Fkzgm/+TAEuPqwrrg84VL9vCfuhVnNWkplq3KBuWqe4URb0/XkILBHg8ThX7203
	mPHsm72WMAvwX0MrwAVbcm5o0VzIeh49+CA0yN9qRXTHpfDUSyHTLqG1FpdCOQpzaHmtaEVJo8L
	5edY5xJl2zgB6kOSDskY=
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id 5b1f17b1804b1-4bb88934652mr411385855e9.27.1795706472139;
        Thu, 26 Nov 2026 07:21:12 -0800 (PST)
Received: from localhost ([2a00:2381:fd67:101:11a1:dfac:b1c2:1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm42419697f8f.3.2026.11.26.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:21:11 -0800 (PST)
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
Date: Thu, 26 Nov 2026 15:21:10 +0000
Message-Id: <DN58TGCM0EUJ.2DYM0M51C78MI@linaro.org>
Cc: <bzolnier@gmail.com>, <krzk@kernel.org>, <rafael@kernel.org>,
 <daniel.lezcano@kernel.org>, <lukasz.luba@arm.com>,
 <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 "Juan Yescas" <jyescas@google.com>
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Christian Loehle"
 <christian.loehle@arm.com>
X-Mailer: aerc 0.20.0
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
 <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
 <4adc1712-3608-4fd7-9eba-79b129c67b77@linaro.org>
 <DN586284T46G.271ABU0A683IZ@linaro.org>
 <e329ce21-5a24-4301-9328-917d0ae4fdb1@linaro.org>
In-Reply-To: <e329ce21-5a24-4301-9328-917d0ae4fdb1@linaro.org>

On Thu Nov 26, 2026 at 3:01 PM GMT, Tudor Ambarus wrote:
>
>
> On 11/26/26 4:50 PM, Alexey Klimov wrote:
>> On Thu Nov 26, 2026 at 2:43 PM GMT, Tudor Ambarus wrote:
>>>
>>>
>>> On 11/26/26 1:51 PM, Alexey Klimov wrote:
>>>> On Thu, 26 Nov 2026 at 10:50, Christian Loehle <christian.loehle@arm.c=
om> wrote:
>>>>>
>>>>> On 11/26/26 09:16, Alexey Klimov wrote:
>>>>>> Hi Christian, Tudor,
>>>>>>
>>>>>> On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm=
.com> wrote:
>>>>>>>
>>>>>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command =
writes
>>>>>>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU=
 clocks
>>>>>>> independently of its interrupt mask. Setting it to 0 C limits all t=
hree
>>>>>>> clusters to about 200 MHz while cpufreq reports the requested frequ=
encies.
>>>>>>> This was found through trial and error while tracking EAS regressio=
ns.
>>>>>>
>>>>>> Cpufreq reports the requested frequencies =E2=80=94 are these cached=
 values
>>>>>> being reported?
>>>>>> Or is this what the kernel gets via the ACPM call?
>>>>>
>>>>> Requested frequencies are reported. The 200MHz I only deduced from PM=
U counters.
>>>>
>>>> Tudor, your thoughts?
>>>> Is ACPM reporting an incorrect rate or are those cached values?
>>>
>>> Both. I checked with debug prints in cpufreq:
>>>
>>> - scaling_cur_freq returns the cached policy->cur.
>>> - cpuinfo_cur_freq gets the freq via ACPM call. The value always matche=
d
>>>   policy->cur
>>>
>>> So ACPM reports the DVFS level it was asked to set, not the throttled
>>> clock. With the hot trip lowered via sysfs so that the slot 7 throttle
>>> engages, on the X1 (cpu6):
>>>
>>>       zone     cycles/s (perf)   scaling_cur_freq   cpuinfo_cur_freq
>>>       68 C     0.85-1.21 GHz     2802000            2802000
>>>
>>> Without throttling, the three agree (e.g. 2.19 GHz measured, 2188000
>>> reported).
>>>
>>> It would be good to specify in the commit message that the governors
>>> don't see the throttle. Something like:
>>>
>>> Program slot 7 from the lowest hot trip. Above that temperature the
>>> firmware throttles the CPU clusters on its own, without cpufreq or the
>>> thermal governors noticing, so the hot trip must stay above the range
>>> where the governors regulate. This matches the downstream setup.
>>=20
>> Ain't that mean that ACPM ->dvfs.set_rate() call doesn't work?
>
> No, set_rate() works. Without throttling, the measured frequency follows
> every requested level (1.80/2.25/2.76 GHz at the cluster maxima, 2.19 GHz
> for 2188000, and scaling_max_freq caps take effect). FREQ_GET returns the
> level that was set; the throttle is applied by hardware below that level.

Sorry, I did a mistake, I meant get_rate() obviously.

>> I don't remember all the detauls but I think you mentioned that
>> downstream doesn't execute set_rate() ACPM call and does the SFR
>> (mmio) reads, basically what we have on Exynos850.
>>=20
>
> Downstream sets CPU rates through ACPM as well: cal_dfs_set_rate() calls
> exynos_acpm_set_rate() for ACPM vclks and caches the rate in vclk->vrate.
> cal_dfs_get_rate() returns that cached value and only asks ACPM when
> nothing is cached. So GS101 doesn't need the E850 approach, since its

> firmware implements FREQ_GET.

Which returns wrongs frequency for the situation described in the commit
message and in this discussion =3D> doesn't work? But the call itself
is implemented and doesn't return an error.

"limits all three clusters to about 200 MHz while cpufreq reports
the requested frequencies."
And also your tests.


>> What about clocks and corresponding PLL clocks?
>>=20
> Upstream has no CMU_CPUCLx driver. I'd expect a PLL readback to show the
> DVFS level too.

I am not sure.
TMU should assert a direct hardware sideband signal to the CMU block.
I would imagine it may play with CMU's clock divider/gate or triggers
skipping of clock pulses/injecting idle cycles.

Best regards,
Alexey


