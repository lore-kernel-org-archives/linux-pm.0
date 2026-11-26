Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707104;
	b=QBpih+NfzaOl656z7XUvLGnNtXlv+ijr0e1gOeMnyY3VxhPehuLxqphKTQIbRsD3UiB/
	 i0MsqPNbYMHhAEkGyeFZdaV/kBYnAJO33TRckD0c+aAfI7iuVgbZoh806c52kxL1Nq0EX
	 4NKWK+8PrsfgqV6QLfQKpCbVvFhrdPSI3wN8H/tfBq7daoS7wmwpROsr0g5tYA3ORbSqH
	 S7UwRQRwvMz9mv6uPz42L43p7D4DsR3+7dzVkhc/7hGPY4fPYiKMQenpWxMrzq5sBnd1r
	 QYj5gsvJpeEg7I8Iy3rxqPwQzZrmLXSrHNNU9e7KTY5W5AcG3alyvIC60TLTeSjYs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=CNCCU62jDJl9wNoG3rW1B0EyVBtl7xnr4/sj56FZ3Ck=;
	b=XpjytedW8t2LI7YuwSPXCbqADMtUX/4sSWDOnxtyfpijkH5Nl1x0wsYOYnSkOufYYqm7
	 4hocmsoSS3GlzhBp3E3A806xqVkdJbmCVG7P2DFIXXN9vpG61FuiGR10I+VOH8j/SQwAm
	 DODR3BF8rPc9ubGt8/VBvj9MRN2ab6aVd4tcbCOlgIDmzVbVe0tUUUyI3CvqtTNEUsFvm
	 0qi5DUhql7GtF3Be2EX+wbIXYxFrn2xKFIY6Abae5g/loyWTo+AjzL4JTF906eW8uT0LR
	 x81MlxCgemlr/Fhlk+oo2Kezur1GMH+dXh7FGgbVA9m1zNtLAEZd3B7ycn3fuYDplPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mG3JMuiu;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E06606A323
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E06606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mG3JMuiu
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso88261585e9.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795707103; x=1796311903; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CNCCU62jDJl9wNoG3rW1B0EyVBtl7xnr4/sj56FZ3Ck=;
        b=mG3JMuiuTh0qJHEgtqlWO1QzHe5cXadqiY6ZbiCRf+9Y8OuZWFJTbOjRFCdDV0FHiF
         yo0/VV2mjXJounpOzQuaQcP0fXNpVw+6YBwUaLe2xUfdvyGWUvICyeR59pkYmRVfcA6+
         kgkjGNxQTU3tC6HVXAulQUDLlerh4h/dQEl+qmJ/CJcHfWqcNJ4UzNOqdrqy7UyKy0QY
         FsZmLJSYWdagR2ZBAcO18fcAR84OutmANWh4TbzudwM3ILZwz8UMw31C9GKoSq278m2C
         48fpAArBX7F7UrlFa8Y5fM9pkq82TnCqjs6LqjApE60izruG0XhF9XZKgVA1peF9ozW3
         NpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795707103; x=1796311903;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNCCU62jDJl9wNoG3rW1B0EyVBtl7xnr4/sj56FZ3Ck=;
        b=Gv+2U0Q9Vxd6zkplxFz7US9a/bWT/rbluKL77WNFLnSqXnzIJSfHoqLZlQRXR7w2+6
         SkE4TCoQ/37wtxy6eUgJh2d0svmGhSSB3SUwPRnLkRj49F8bbMn0Sap3HMeuySHtEEqR
         RcS4yy51CPOwqBB2Aota6Ui8SPTMOOmRXwglNCAu1E9NHHrBiv4ZtXB3pgnEOUsDgkfy
         dVnP2UKGAAed5Et1XnyorODpdAfbADRfezEDIIeDELJcWuHf+ph3jeJn+jqnFcYk9AkQ
         NPq9vS94COo2PFNrEEfvw6WWyS56xVYTKYpBZM/sYgKxocjLKEA6/e0dhHrA1VWH2CQL
         MNZg==
X-Forwarded-Encrypted: i=1; AL+hErEKzJBYaAbiOHprf0OR9q1+1KO16gvrtd2DD+Emq6+z++TZn1fQqDFdT4Z/IKn7KmKvurGvYE/j8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QXcvR7YIjMg/B0apD7JAXXw3ItCO/TewmU9DuarD0/eTOjixc
	YD0VLvniOpyuQjBXJDl40keDNizMT5XUSJMcaFkpt4mWpO5/41icpSx5cI6sogl6vME=
X-Gm-Gg: AZFdTZc8fOVQlSwauilXS49zUWjtHgh5rjbElPdZy4aEm082tcFV6edAMD5zaho8kTU
	lk40SBLrV7Ph/KT7Awq+nINLEzrpC3n7shHlvu/fqx7+Op1i0Tty6qmxCOn3DFdz3u0KufVsXha
	S4N/6GZJ5PeimhELnfBPA+RjflJOtmcjSIdDrTWXffBXYONNiVEKFBbpzMLP+TOiEyaXkxYFdKQ
	t5vVn3CYEYhTEr8jYKctXsfWBiKmPdllecu5x3RappcBg5U17YUXUQzLwAPclVnP2z/sbP65eIV
	9K4hssKXYLlzpnCm7rIzrSAHCL2jrcg2aaKMJbTPlSqBlRkxcGHkcd/6FdGvWhhgtV90TRYp1N4
	jVeG73lBG2P7shAEdXO0INtdaZJAPfiDT1Hdlr64iMAzWOX3hku5z+nH8PlidWVkWA7WN00CvxR
	O4ExX0/KIVmSqx41+XIYz90+h8+mwGLUS30wM1ldyFzEpa4fATlyjPPONv26KIT3zllafzy7ery
	hya3ZDX1fy3SUl+7Qk9cvJxZ7zqalQ2UHsKZPfzdLQQD2qI3wdhIpcQsu9BIRlBNDHiBO9iE/YW
	RPssIWv6B0pZdI5rB+4+7/2pEeqzpGGK2T2yDMWP4PjRCCpTkMthO0t5Tbe34WzFex1ySsX71B7
	YgyjgS3EFupMOTbP/5R8=
X-Received: by 2002:a05:600c:4753:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4bb8880c73emr448397385e9.21.1795707102651;
        Thu, 26 Nov 2026 07:31:42 -0800 (PST)
Received: from localhost ([2a00:2381:fd67:101:11a1:dfac:b1c2:1000])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm678687845e9.14.2026.11.26.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:31:42 -0800 (PST)
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
Date: Thu, 26 Nov 2026 15:31:41 +0000
Message-Id: <DN591I26AVUH.11MO49ZCF9V8U@linaro.org>
Cc: <bzolnier@gmail.com>, <krzk@kernel.org>, <rafael@kernel.org>,
 <daniel.lezcano@kernel.org>, <lukasz.luba@arm.com>,
 <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Christian Loehle" <christian.loehle@arm.com>,
 <tudor.ambarus@linaro.org>
X-Mailer: aerc 0.20.0
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
In-Reply-To: <2162b02c-642a-446c-973e-ca80607da294@arm.com>

On Thu Nov 26, 2026 at 10:50 AM GMT, Christian Loehle wrote:
> On 11/26/26 09:16, Alexey Klimov wrote:
>> Hi Christian, Tudor,
>>=20
>> On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.com=
> wrote:
>>>
>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writ=
es
>>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clo=
cks
>>> independently of its interrupt mask. Setting it to 0 C limits all three
>>> clusters to about 200 MHz while cpufreq reports the requested frequenci=
es.
>>> This was found through trial and error while tracking EAS regressions.
>>=20
>> Cpufreq reports the requested frequencies =E2=80=94 are these cached val=
ues
>> being reported?
>> Or is this what the kernel gets via the ACPM call?
>
> Requested frequencies are reported. The 200MHz I only deduced from PMU co=
unters.
>
>>=20
>>> Program slot 7 from the lowest active hot trip so hardware throttling c=
an
>>> precede the critical trip's system shutdown. Cache the low/high window =
and
>>> update the hot limit from set_trip_temp(), because the thermal core ski=
ps
>>> set_trips() when that window is unchanged.
>>=20
>> FWIW, Exynos850 control register for TMU has bits to enabled/disable
>> such behaviour (and it probably works).
>> Maybe gs101 also has it.
>> But it seems that cpufreq scaling feature itself is explicitly enabled.
>
> Thanks for the hint Alexey!
> THERM_TRIP_EN is bit12 on Exynos850, clearing that on gs101 still stays o=
n 200MHz
> for me. The downstream driver doesn't define it either.
> Clearing bit16, i.e. 0x09003 instead of 0x19003 does indeed remove the th=
rottling
> even with all zeroes in slot7.
> I would probably still go with $SUBJECT, as I'd say the risk of this havi=
ng unwanted
> side effects is lower IMHO, but I'm also happy with either.

Sure, no objections about the patch here!

I just thought that for exynos850 we might need to initialise it manually
since we rely there less on ACPM and what bootloader leaves for kernel.

Thanks for checking.

Best regards,
Alexey

