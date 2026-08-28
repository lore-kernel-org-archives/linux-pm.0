Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0137C927
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912098; cv=pass; b=JT2Y4XYB7nowTt2cnhgaJmAd+OjlwJDhL1K6LVg5AqhNdB40wGO23e7wvUvV8O+FLj0CH3MpoEnOC5moBUreUp43dwKT29k5WjC8ejFjYW5TsvBkl4QgMasRT+45clWfV8yZ/UotHrrjO6aT255PrMUSGoiamFmxidZjKlp0na8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912098; c=relaxed/simple;
	bh=1v0dWB6wdPLQarMGeRV+L7km+yD5Klgx/RyILbyOSMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcd09BktUnhDPm+AcywNRRlL4nsvkZ4SzcZwt8kpEUQI0MKDvklakWLFL0Jv5S6RPcjGQ3921PuD4Bwrfflv4xko+h2pP6sk0u6ZrfE9XuD/3uLOIcWlTwXKK0UZoo0r2ih9we45yoYnj7gNeFrv7HySZH+q91lzoXqeybf5LuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no6m/T5B; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no6m/T5B"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso1374544a12.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 03:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787912095; cv=none;
        d=google.com; s=arc-20260327;
        b=EckiTnHWmN4oHkRm/VI1olGGkEWp3q3LnfycFCMFUzxiP5Zw4vwJaOsiu5XdpYun4A
         av/P2NBweSZra8Ly/GfWcvy6W8uMFtwqMRMhdJqgaB8r6wukeOoEJnZssfYBJ5TkY+aM
         GWqJV6tt/rZZWFIcGZKQWpinZh84oeXXYZSFzFXe/MLHjdHsKJnzWhRFSHnBoBhhY5bn
         IpxCPyRu8e3MI69PIHKUN3Nc1N7EGOGlqFBIGAPTQoixo87MJ8jAV+UA+KIiad2Li3GU
         E7hXmUc/Kih/XG8t6Ws691gtbZVsjZS+Lp3pnbb+8RaZDGUOLxNS7FGUu04+SRlCyeVk
         LG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1v0dWB6wdPLQarMGeRV+L7km+yD5Klgx/RyILbyOSMo=;
        fh=ylzUX295FVpnFfJdS8CF5L1lry0RDbrSJ+Vogx9G2Pc=;
        b=evqD+YmUgipfRqfNOhdXF6U5wkfS+jjyN7weswi7fhXbgXvKXV6jDo6oScXiX8aShp
         C70MHvGtRActSkvUJAuv+B0qnmnknjSf5xYdXYtz+M5Crz4vikDVLN2kLnqCJ0mcT8zU
         OsTDt3IBX6W3HfB+EC6/L5on4vOhHBBFjaaAQvN9Qk6udTrgd7cDaEHKGamQ6Jc762Z9
         AUVs5m6S9A0PEB/hDQpVkTGF2Bk2SvK6aMIvjlmy9HShjD3OcTiNk/iRGXCiWzZ5K+x4
         bK90lMj7jZvVcyoVvO3tAVNZoO9GuFdUvJmDra7+082Xi5IQWliAjdkf4VxccqtEeNA0
         V2GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787912095; x=1788516895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v0dWB6wdPLQarMGeRV+L7km+yD5Klgx/RyILbyOSMo=;
        b=no6m/T5Bw8c0DLSeM5A22ornHVbSjgkRZwqR3U2HtV6WyaEpB6lcmVAz8OpqsWQn6n
         k0UFY2zZ+AAFgBlq19ptPsX5aS9Ed+lv5FaV0kFkHNi6ULX9Gz7jhCFDC8vZBR19Km12
         gosgw/9brnv0PsIRROiroFwImYB7XEyZnDc9Eo2ietqRa6WkoLoRLBBn1TrzWQYL9y5n
         7hJyzBgQsJbv87gqIiQjdo4yHX+TCZ3xBEN7KehsnhAq37TCpJK2KOuJ0NOnVsnKynq0
         zdQZ42ESzDOPfyH58UrNlbXf/pokJRApl5inRFNmWRWZJP/gF+LHckYfMy3wyAwuzNQ6
         SPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912095; x=1788516895;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1v0dWB6wdPLQarMGeRV+L7km+yD5Klgx/RyILbyOSMo=;
        b=IrmTDbfkum6i4G8zbEXHmadntD08DNzsfWNH8dJVHHnaXB348jB+3Qhhx448Whn0/9
         sN5ony0OL0nOD7eTjAXeGOgZ0yVvhQ1y8j6L6d444bZ4DkEF8YpSokblgUnCMbD0NlRK
         i2NmKozYnHQe+coXgKvSRD/oKX/yUFcv5YqWCJWXtKYpzNBEipmyvs9oPFsZ+Q4EC+eP
         bZHCfccRQz07BkDPzfp5XMcs96j0eYx8lFTETDyxBEBD1QetzBUttCqvOmUj61ZOWWge
         T/xHmBrBeWQeF5nDyWzPPDEaULfuAH1No7rGVSS3fYwMUHgcFxwbfmOqhK8MF9AJjpMv
         K84w==
X-Forwarded-Encrypted: i=1; AHgh+RoKkxKpFYyk56xA6Vp4uKQUwznUW64p3UenVwHJTp4ECWQw8Ni0GlcR/B5qRAwuSpWNFktAm1rgdA==@vger.kernel.org
X-Gm-Message-State: AFuF++ndr9/8PVUa1chKuq8rXLTRc2P7qe7kAxggdRTWBzG8ZtwvhNC8
	EmAHKLSxvQ4hLFNmj1I6LbBqmpbBg8B7upzebV4N2zGuMpfUf+9nsIafGxOBhCDsThsAtPuuq2+
	zdyb+50NEAD9ilU/49ohgbrAkGHY3qrQ=
X-Gm-Gg: AR+sD12pqWNukvj1uzfO/XN8hgArHvoWmFDBm8jfECO6v89B6D0m+93KRZ+HlASQc0N
	47W2Po3YMReleToK3NyP219nY4jtrHW0berRgUL58irji0nlA0wQu1LrnR5esTeAh+qOaawY90q
	Cnx5gHgPdOYZvvgKoqAWe7sDtFEgx9wNaGgJlD4InBK+0PUfpsm6yHbYjjXVJbWNtLdrEbLjRpu
	RnnENOHEs+OZM1LndsmR9I7hhH0a4xv/c6L7gPIY+6D7Dxa/MQe2GJEaazgslxibXPAfYTBUp3K
	Ng1vgqdcdunU9sjWL3YB5HMljLaBc1CbzE5EZ/1mzs7V946TaWd8mOtWZA9GrcPDzcoilNVtQ7r
	CaCKr
X-Received: by 2002:a17:907:d0a:b0:c25:32b0:e56c with SMTP id
 a640c23a62f3a-c2556bc8abfmr482808166b.4.1787912095085; Fri, 28 Aug 2026
 03:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824150156.1310-1-sreeshankar0910@gmail.com> <20260828-liberal-jumping-quokka-cff4da@quoll>
In-Reply-To: <20260828-liberal-jumping-quokka-cff4da@quoll>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 28 Aug 2026 15:44:42 +0530
X-Gm-Features: AcwNN1WwE4fV98-9nbf9QfdMe5RP3mFos-H2h5xcNNdmEyy-SXjW6DtC1QoidsA
Message-ID: <CAA-+uk+5zWvmTB5NCbWpBqHSw6MswBAaJHGHw5LnKm4SBhXcLg@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Add initial support for Qualcomm SM7250 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, konradybcio@kernel.org, 
	tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net, 
	abel.vesa@oss.qualcomm.com, lpieralisi@kernel.org, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 at 15:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Aug 24, 2026 at 03:01:43PM +0000, Sreeshankar K wrote:
> > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > SoC (internally codenamed Lito).
> >
> > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> >
> > This patchset is organized as follows:
> > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > interrupt controllers, clock providers, power domains, and reserved memory.
> >
> > Dependencies:
> > This patchset depends on the following patch:
> > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> > Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> >
> > [PATCH v5] Link: https://lore.kernel.org/linux-arm-msm/20260824130437.2771-1-sreeshankar0910@gmail.com/T/#t
>
> Please keep the previous changelogs and links.
>
> Best regards,
> Krzysztof
>

I will include changelogs and links of all previous revisions
in future revision.

Thanks,
Sreeshankar K
