Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F339D6E8
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434546; cv=none; b=cJRyNxDfIrMo12AbpA/xb/IWL7DFdCqYSihjGdZG2MVajHgsZv5SlzHLMRcJwmnEw6FvtuF6Eb1CybnHgLwCEjQv4kHbJroALzuKqLFWYULqCQvVVwmSald5INrCRpH4W0G/BwXzwuvGmw4JKlsPd9+RKejQzXoA3ruwOyGZ/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434546; c=relaxed/simple;
	bh=Br7PglHK5VbSb56hz84af7HdMnOblCvdTjsSZQRIn0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDvt3+WoSl7IwmOjV7dU4kZWMT6kshlX2BBD4b7yAnkr4zRkhx0uLaUCb+tDrSVCtBJ5GNj0c3rmT7x0licadaL98TheoCF4nC9p4G4O5+aj1sdb8F7mfzI8QRbhbkwaS/mj3mUF6AndMQfc5CsELNphXojdr/ihudlr6qx6Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5kPv9Hf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8Z+tsxD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5kPv9Hf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8Z+tsxD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652E5xEi3302781
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 21:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UkIXV4vwPm6C3ZiF9q66clWGzHoKyEfJVyhB0Lu09Tk=; b=k5kPv9HfnQHBaM2D
	9trDxCOY3rpRAJ8HnKK2a3pXchjDIHY++OnqXdxBbRGKZGqnTODdeH7ZcUVS2w7k
	iRAHUFdzscyWfUT4HaSWh6SICTiJql0d9RXBal12p0MdZ6YVHYKy0muv6taafpjr
	EwJkAZCY9XCvndhRpxdkqMNmWHkNP02l0y2GEWDGzsipLpq0muaGr71Djzz+J303
	GScODQDuGtJvLOQ0JFDrXNYeE3kJRdm4tHnZxAQ31jZgKdffUiq+yn4xqxI/IPYu
	7G87PuGDcCHpAMhhYdU/Y4rDWyahujB/degzUAz6x+8efvK1HonAUGkJxBV/R+JG
	uEE9vg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18k9gd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 21:09:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517787172b0so5026801cf.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780434542; x=1781039342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkIXV4vwPm6C3ZiF9q66clWGzHoKyEfJVyhB0Lu09Tk=;
        b=d8Z+tsxDbAy58lrHTu4m5STL5uakfawASZzYtN//JQpBuIiy1hsGAEfR5kdyb79es7
         CHllzmTr1TlFpgMsadyuE3pZmVJ9boWO9MIHzUrtemrxE1L5Z5g4quWw3CLl5UY0y+Q0
         P0B+hgzqWQI99RfrQEamMjSxIdCLXPOxcYzrkQ0J0m1Rin4UyPh0N0iySjv+jTW0WpFz
         72nprk18HhXPAgsI3BvMe54Mw7llJNap4Wq9gFk9vPgWBd/ei8WVeyknZYUg0bEzPwRI
         Mnja2qKF4dFyJVYkN3wrHjnL6dMklT+mCeQ04DKIVwZ0Vnw9CTcwLpGCsvvhQz5P8cVX
         hdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434542; x=1781039342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkIXV4vwPm6C3ZiF9q66clWGzHoKyEfJVyhB0Lu09Tk=;
        b=soLZ8qXaj0jiaaViVrHv4PwKHoeJL1utuDCh6SmQ3JMWpJPYh6v0T1aVR7VIW/VnJt
         UIOzazVPTqUVhHsdKo1tZEIRwdfDSAu9H3Dn/wUtbt3xvCJqVPeLfhAKaEEVx1mwUkCf
         v7vTPuB4Vm+p/4lxPi9dVu4jzDp03QpgQGILsVduTd02P6Qi15goLSjGrIVzwAuozIHJ
         WD4mgvC7YoCYxP8tuQkONuRZKCz+BNq7MQkT6bW5ExrZQuXL1P2YduxsaPLb02VqcerR
         1eGDStqAY6OSV1BV2L+CqNhn+77KfLsBT9PayEDye6Mrm5hVZ/uVXH9mW+ahNpqJenak
         l7cw==
X-Forwarded-Encrypted: i=1; AFNElJ8ASzWRMzYtMEo6R3NdTGTVZ6BwhSeyejOB9Dx5LRHKSuuGjuMAa2VNE7bn6qiGTtFQuWLu1vIfHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsReVdDP/nwKw34K9RbnXKzFPi/TMK8PHWv8CgWaenBiuKoPq6
	deiRboIttsWTR3P4wYDEpxhAdSDUok3kePR3lLVnhW2EczA92qZJXCgjB+bm+guM+vHKhQQswYJ
	KXaybd+Xc6hMn/z0wwwRZ/Wxarp85DnmeTF2uzcZvMaZ/Ft0sgTNNc4mFKB2XpA==
X-Gm-Gg: Acq92OHSR2t4sDnXXpiN8xcAYxHVYWB1o6w5A2g1NnutND8IfV//N8yTQu8NwRGqOLQ
	Ns4POZW9R/T0RXWi6URIFRXwbB29hWlYpEX5A4nGZ0jqGmsCBTxgriR6nwogH33Q+Njzwbk6qSX
	ghIhM7h5n0vFf3kyzBXJWCAPUGwlkbc/ZA2S2WU9gXOBiNP65MIenun3msUQyB05VJfgMgKBN7j
	/pax4K/ocE5lCGmQ7LK+JfOSHYLoBTEEv6jCbC/V7rEHyrorh2Ff3LQV3g98nGWldCnhtWwWmcz
	+OqzPWilx2TRjzTu6M74y5LXpR0o34t2xpDg3nT9bVO6mtvBpgPPHxKnt4sHiouRy5mPUisbVtf
	TAsDHJh+NTeu5spQOs3rd49KkbP8SvnXw7eD8gd+slk53cFsB51oa/mJZQifYaWpcVeZtj3Q28n
	wU
X-Received: by 2002:a05:622a:552:b0:516:e31a:1a6d with SMTP id d75a77b69052e-517787a4754mr12505261cf.54.1780434542268;
        Tue, 02 Jun 2026 14:09:02 -0700 (PDT)
X-Received: by 2002:a05:622a:552:b0:516:e31a:1a6d with SMTP id d75a77b69052e-517787a4754mr12504821cf.54.1780434541857;
        Tue, 02 Jun 2026 14:09:01 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b614c5easm1957675e9.29.2026.06.02.14.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:09:01 -0700 (PDT)
Message-ID: <f5118303-d7ea-402e-84d6-794d6860f992@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 23:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: amlogic: add missing dependency on MESON_SM
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1f466e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ChcGN87QxgZRVD74oVwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIwNSBTYWx0ZWRfX7+EihCiq9BGv
 3skUKC83nHeYE0+0UHAxzBiRo8fbKgLRxM0HgBBDWzh07MXPyS6utEGC4JSwZ8vMFhVntqDrl7W
 LGkLkro3vSSoHdPxVvcuRBiEIuE/910rkIaZCBWPOk5RL6BTf2ESJo7mfgygLPaVLdw6VOJbSTg
 KFhPQhS2y/IeBS2SAf6wdOnbvs7XBiT2eWZEq82fG0rGjupLLjWdNeHDmgxVIQ5uTnXa7fBCu6b
 8pzKAx2HxKoSkc++ckXbx9CNwOfHIQUEjAii7uvnTkE7rwNaagAwXS1BQOP9HuIFFASGL1CSDBk
 SRMm+64IanE2FNGSKwLmuY8veoajm+hGu/2c90C0ZkVIdVDfgS/Qdmouh2JF4dudgznyB8f6FxA
 813MYt5Uy8I6pPqowyqtgcdnUxfOq/Dydt86VUnIavSF0LqagFGZZMRI+a3BB1CS7PoOvTrqTSk
 PSxIWA1hhMuZbjqivCw==
X-Proofpoint-GUID: hKnTr74_Iudx52D_yabqlD3KTwPJkNbp
X-Proofpoint-ORIG-GUID: hKnTr74_Iudx52D_yabqlD3KTwPJkNbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020205

On 6/2/26 16:19, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> The amlogic thermal driver calls meson_sm_get() and
> meson_sm_get_thermal_calib() which are exported by the meson_sm
> driver. Without CONFIG_MESON_SM enabled, the build fails with
> undefined references to these symbols.
> 
> Add a proper Kconfig dependency on MESON_SM instead of relying on
> stub functions, which makes the dependency explicit and prevents
> invalid configurations.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-lkp@intel.com/
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---

Applied, thanks
