Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89F3E5EF0
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350254; cv=none; b=PEGB4NPGQ7dQPBoDtDXWWLZHXJuKmexr5l2qL3RFWu3WszG9gq2PElbaV7hKzhpjthhcAAQGOT4zaH+VcfHdD7i7Nnplrw9KgbptnZ27//Sni/XB8U2kHlDhyykgLoD5RbUfU+GrV6bRnk34NNG+6aMWSWhOpJSi5xYP32vx+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350254; c=relaxed/simple;
	bh=kXwTzM8m3chUzL42QlXn8SAnILWR/tBEk4o9I2s9F4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sdZfVjY7YmiklHnsepweLH28lCiXJ/PCAV/0X2wTKsKdznqtlExoVx2/RKPt8xWJ9PrZ53PGfT8LOkvpW6eXP7bl3lmthfIHXTXb8h0HHVKA8q8eeSMBpHfFZNy/qnWA5KZqoY2SGfl4+4BcF0NmMFmA0QLNU23vg6dNXTTWv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=f05CdQI/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="f05CdQI/"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6694d00e01bso2155083a12.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1774350250; x=1774955050; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJSft7WXDopdPtbx38F8LsPABdfo1rbEMNuhG4z7KvU=;
        b=f05CdQI/RavHH7lpKnR8u9xg+5kpwVVik9lHUmiBDRB9heFQblojFpnqXMhBEr5FVy
         HOyDRAwoaWbuhCfjHMT5Xm1d/yYQ3rj5YLn+/3wLm+WRq0cP9HsWNmLyuxI2T84quOtZ
         KsdOBQE6S4UOYggdm141w2LkF3QtPIWowY1MJ4XM5vs3p7coPS1laMINOfZU7KWBrJ7t
         Qua30+1Kccp4JfNKOA4/LSEiDQ6cQGgihOT7tgNH6jyZ9ZF58F749tyZbR2wvkdc51kb
         to6rB98I0bdETPYqdi/QIMV6DKUOXlK7Qt87jbvneKPb+1g/+6Wv64BcJ5i19lF+JNxT
         XeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350250; x=1774955050;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJSft7WXDopdPtbx38F8LsPABdfo1rbEMNuhG4z7KvU=;
        b=sNHQxoV1y+KK3cVBw7WAFwC0TWmP8ECztdVPtZCZLD8nNfiHwXbtBecGsutbI0W014
         V6BzY/lGvUUXBP8vDXFrdnr9vzlA70vbnKn5bqiFNZhJnmD/czsRSM4m1h9SBhe93noY
         dHqxhdCRPqrZooNZjJr2A2/PcJjvDc2GdBP8sUgvijdKqToPRLtwcDQeh7OyMlgfLOjg
         ZsR5RQCmsJEr2zKqoMWIarvDcms2J4rKc0FDHcgRZ+mEB+LhUR3iRL4Pi26KdUN7e7GI
         YRR4MXCx+56MSsRu8zyH436dU2i57F6FeknqjRZq8XfXeucXm0oJp/0ai6ktpl5l6D+6
         GFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtzoHmboT5aQILN1N4khmPgFqWt0CZPkVHm7NU3pjGtsZhDDM+D86CK6nsa4aZICmOO1Wp2p0Wuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpA5YN/ZTyjJzCIUR22TSYhLLXhSvS1Doc9CuOE7d02rM/IKP
	gNXZbiTrIOGyk/ChfI5jdqU5mmW6biuiPLlBqI313D/8eZv7HX0pJwCxbqBk2HPnAns=
X-Gm-Gg: ATEYQzxEpp8aXtsYJo3vu1/+8DoEQBfoQInHmjJTTDuPhVGrbVd1KQYE1qqunAxVapk
	QGiWwAgEu9CkhAYl0f3ePlaTvr85JMUE/xmgzXxjGcvnqlcqlGz2juW8uBKjy3B8eWvbP67eagD
	ZSwT81/kOKUGshSM4mZmEMhu7Je66QadIBEcVtTHgEL9CKV5CSSmjX300kJ40fOBCR++1POzKJ6
	6fa18Qejz2NNmizvdhLdgJJKhstpr5CNVpsmfqT4Rr8fCdzIwhnNrTcoHJo7SUXBxLci/SgJQJM
	Mou8bDTMt/cmMnEIVyhlmd36SbXnTxHXlRUJuZBgLU6bMav7sQShHWO+igZe1eNPRLFSVWwxjLo
	rRjrGkfMbpjGIojPQEWXiChlskkAK4B0d1V4BcsOkqsqzFO2JZU1YjIsfWFhdbmvkI6axEXr31+
	eTbdt65Q7f5knf/bz/v0gQUYebVWdp0Ujz6GsQVqxs28yiDmtZfzIZ+G6pQKVNCp8mOIkw
X-Received: by 2002:a17:907:7ba2:b0:b98:4156:878e with SMTP id a640c23a62f3a-b9841568891mr1060559066b.47.1774350249586;
        Tue, 24 Mar 2026 04:04:09 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983387103asm622419066b.57.2026.03.24.04.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 12:04:06 +0100
Message-Id: <DHAYO287YDEO.12W871ZAAJ6GD@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] interconnect: qcom: let MSM8974 interconnect
 work again
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Alexandre Messier" <alex@me.ssier.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Georgi Djakov" <djakov@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Brian Masney"
 <masneyb@onstation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
 <b09a51bf-26b8-4c88-ab23-c92ddc1fb801@me.ssier.org>
In-Reply-To: <b09a51bf-26b8-4c88-ab23-c92ddc1fb801@me.ssier.org>

On Tue Mar 24, 2026 at 3:09 AM CET, Alexandre Messier wrote:
> On 2026-03-23 20:10, Dmitry Baryshkov wrote:
>> Commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out interconnect bus
>> clocks") moved control over several RPM resources from the clk-smd-rpm
>> driver to the icc-rpm.c interconnect helpers. Most of the platforms were
>> fixed before that commit or shortly after. However the MSM8974 was left
>> as a foster child in broken state. Fix the loose ends and reenable
>> interconnects on that platform.
>>=20
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Swapped order of clocks and clock-names properties (Konrad)
>> - Corrected the ocmem comment regarding core clock (Konrad)
>> - Link to v1: https://lore.kernel.org/r/20260323-msm8974-icc-v1-0-7892b8=
d5f2ea@oss.qualcomm.com
>>=20
>> ---
>> Dmitry Baryshkov (9):
>>       dt-bindings: interconnect: qcom,msm8974: drop bus clocks
>>       dt-bindings: interconnect: qcom,msm8974: use qcom,rpm-common
>>       interconnect: qcom: drop unused is_on flag
>>       interconnect: qcom: icc-rpm: allow overwriting get_bw callback
>>       interconnect: qcom: define OCMEM bus resource
>>       interconnect: qcom: let platforms declare their bugginess
>>       interconnect: qcom: msm8974: switch to the main icc-rpm driver
>>       interconnect: qcom: msm8974: expand DEFINE_QNODE macros
>>       ARM: dts: qcom: msm8974: Drop RPM bus clocks
>>=20
>>  .../bindings/interconnect/qcom,msm8974.yaml        |   28 +-
>>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |   21 +-
>>  drivers/interconnect/qcom/icc-rpm-clocks.c         |    6 +
>>  drivers/interconnect/qcom/icc-rpm.c                |   18 +-
>>  drivers/interconnect/qcom/icc-rpm.h                |    7 +-
>>  drivers/interconnect/qcom/msm8974.c                | 1637 +++++++++++++=
++-----
>>  6 files changed, 1274 insertions(+), 443 deletions(-)
>> ---
>> base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
>> change-id: 20260322-msm8974-icc-0ac4c28e139a
>>=20
>> Best regards,
>> -- =20
>> With best wishes
>> Dmitry
>>=20
>>=20
>
> Tried this patch series on top of 7.0-rc5, using "htc,m8", and can confir=
m the device boots properly now!

Thanks for testing!

> I do see these messages in the kernel log now:
>
> [    0.692540] ocmem fdd00000.sram: error -ENOENT: Unable to get core clo=
ck
> [    0.692582] ocmem fdd00000.sram: probe with driver ocmem failed with e=
rror -2
> [   24.173125] mmcc-msm8974 fd8c0000.clock-controller: sync_state() pendi=
ng due to fdd00000.sram

For that you need this patch series

https://lore.kernel.org/linux-arm-msm/20260323-ocmem-v1-0-ad9bcae44763@oss.=
qualcomm.com/t/

Then ocmem probes again correctly:
[    0.859855] ocmem fdd00000.sram: 8 ports, 3 regions, 24 macros, interlea=
ved

Regards
Luca
