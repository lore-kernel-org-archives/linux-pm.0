Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220E380FC4
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094464; cv=none; b=lMSkGtS9GPxBBCP7X977SWQpZCMTEG1mkvOI27SmL+qey3uXz0SQD4aWtar4cq0MbRV/4HiQ3SIEsj1L96tFdg9tXxFXa05wzYXwwuBgp8UOWOEuNtxIe/IUpRNqo7Eb3Vm7cD3lXcTJTfIjFsSMG4UbPhWgDKjEry5OEo8Dsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094464; c=relaxed/simple;
	bh=TtVL3g5CXHtJtj6eOzuWf7skEeoSjxP3wk/z54dfag0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV3RZQA2gBEz1n22KzbDz8RGG2qSJ7d6lEINXWq442gtf3bU9vRv+YH21/OeiCum/seOMF0bFwEYtaEb4jj2iD/XtiG0JQY0x6B3jlba+BVGTvtxKNndLL2fywQMn16DCOn0IM3DkrOYYDJSB8mmzv6fK1Yre66alwK32302xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mS82BS67; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bg7W5xqv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mS82BS67";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bg7W5xqv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UA7TZ1418221
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 12:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XgbZbNxl9MVPXRQCf49rJEHJ
	jRyGus6jFeoy1vIRV6Q=; b=mS82BS67hj4LKM38qD1GqrOOR+ZkIgJbKf58dHw4
	AXamjvO0VYdyuRZRrgUXnIw3fBT1tDfc6AK34XoY09SNJp1W6eLy7MiMr6awHEpg
	111+xNvEKEvOiprysHG5FoclGu3pSGKXHG5E7cRPPbdbqK4ZR0rwq/HZD4W5/GHy
	4nnvvnGs3g5qAmIwRpYlxCfrn9YRg4Qsjg6aQ2adzd7tLMCGYslMzPFMWdzG0mjT
	8+lN0+XjTDW1XwF+FP2BouNAmPiiEs5MZAUNL4OUX/NREhXc40mkqOkmdgyoYeuU
	M+BqBFUjnltX30gIp3yoSg8C7lDr6jnvmXWc87qGvHzH1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgyk11w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 12:54:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903622880so532752985a.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788094462; x=1788699262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XgbZbNxl9MVPXRQCf49rJEHJjRyGus6jFeoy1vIRV6Q=;
        b=Bg7W5xqv+67nEOgFqUwUggjtovCMBPYAC50dK2+Gz8t0MDFCbPmKYR1Lu3QROlhsD+
         WCxqMrpDJ/f45JW7ptfNrSBFgo/uYkR3EVmDK19Px3L54bBWaiaDZLWzRuGcNCx6XyV8
         ObKJL2zspLPS6DM9SXyBU59u6uXS6paxERkpuAwWPhnq8Ses+kRYFpx8Aa/ncMd2jr83
         RVcFoozZ954fEkBy1PLLxEUTgvnkmIxN0vePAQeh8hup9nBcDLSlBBKPgVg1go2VTfDd
         wqPyGzAkCYcE6I470a2qzYptWDOplpNgaA02lFxRouyvwnepNV1yTacf8+gghIERVPY9
         266w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788094462; x=1788699262;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgbZbNxl9MVPXRQCf49rJEHJjRyGus6jFeoy1vIRV6Q=;
        b=p0Ioqi918JGsIcHKx9+P6tQP7MmwMOAZ7/lRYYCNDI3hpBTDqJ9Sbr57ZsbDU9sAcF
         J7uF3f4l5MJdohBAdp2r+CRsW4zCz2HTbmSDYxc2QiGb7COpY+3KSUVZHjHSAzl8IjN6
         ZaohIObssgXEqmHIqQs8xgki8oVHP4sETqoKhDHdKeP1/YbDmFtpMJehdIZZ6XAH/wpF
         qF0pgympsVlMQLid43S4ZHryDgNO80EJRd868r1+0jJJz/gn96JizvMkm0WQ3bCeRyeY
         dHzAh1/gWOy819IkkC5vS7Y0xzOEpA/fsk4ISf6PBVSncHZcXY/CJQScv+BWSiFaMhVN
         RdIA==
X-Forwarded-Encrypted: i=1; AHgh+Rok0TIqYb/XD8YkR/DGFl6qck8v5J3E+8yAXVfj1TFz31HZVOtEIx5eM8o3saxwpztM3jAeuvCLAw==@vger.kernel.org
X-Gm-Message-State: AFuF++l5IZfOyQf0IKw6Ot7kYI5IuDzCp7vwFt14oCpPXu3Y9u7l2B3R
	6lMNNpiSom70E/AJniMEc5lYw06fPl3oqrKnyJHuOOJx1IDhrfnjJgFj8yD7B7LaodEHY+HVABV
	MXk3QfldBroKUq7iBtwpjgCb8MCgYRviyQp/rjPnDOrYm+ECiApQWDvstHN7qGtWMaX27BA==
X-Gm-Gg: AR+sD10vJ9h6pK1rl1Df5ENKnP4xFMQSe5Qvg9L5VrEgqetoOTW5GXs2J4FjWaObcIq
	uKnvM5Hlv7t6zcOIFYSyxl9d51Og3SoBb+IdWlooROxQlYUdNsCLM7H84saSvoRonGBBz6eMxay
	Hf/ZQpg7QI+2GyynpZOqeqAy4aXJuHTxGif9s1QxRHnQt2xVjQ9sgb54eVMskIb2gDAK3tPlvtq
	LmhWPYvj3sgZjTsijcjkM1u6wICO/3ufi4y9A0PapS3pjVlDREUpJBejMYn51OR3CPYqjPk/Eyb
	gcgz5B+adRw3VyN6cfbE6s0RPE3/CwJfcZqjNo7oIWrWhlXBEwBwlJBwP1ml8doQ3TEEnro+LE3
	OdeHge5kLl1DI4Q==
X-Received: by 2002:ac8:7d45:0:b0:52e:125b:9444 with SMTP id d75a77b69052e-5300b8e5b6cmr20132901cf.17.1788094461620;
        Sun, 30 Aug 2026 05:54:21 -0700 (PDT)
X-Received: by 2002:ac8:7d45:0:b0:52e:125b:9444 with SMTP id d75a77b69052e-5300b8e5b6cmr20132621cf.17.1788094461044;
        Sun, 30 Aug 2026 05:54:21 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52fdbsm159275475e9.0.2026.08.30.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:54:20 -0700 (PDT)
Date: Sun, 30 Aug 2026 15:54:18 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hiago De Franco <hiago.franco@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: Honour pd_ignore_unused in the
 sync_state power-off
Message-ID: <citqj2vmvg76gec3aebql5hiw5fctkud6ii6ylvvodrvoues3k@batgphik664u>
References: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDExMCBTYWx0ZWRfXzoUexD+VWsaL
 6QGHbodBKhdNvOM1Vxi0uXOHjBDGDqfQkKT6edbFs//q500rcrS+J4GUsAwSF1h+y/Cwibl9FKB
 2B70ffPo6eqAkNHxlUU6BCEt9qex7/Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDExMCBTYWx0ZWRfXy/6ZyCnlSSGH
 bM2MRDhwZV7XhUKm+k41HJn3HkarThXvhgvjwOkL/OGkn8pDhJSDE0xTx+B85zpnDM9pzbkfj1J
 H1k9R2BlBC/gRuO2mFggi87lGVqnnNfErj3/kJ9BDxWirlYGc+q36blZwsUCSdOGtHxzjF/FL4u
 GHdgkJSdTb7Rj4Jy9h2Xs0A/e8V1g8DL1uboyhK9QYv5utegnnSh9tz2KDgagf2RrMzWfHAGGwg
 fPX0RC9kIFVSKK9GQmiWde836NtmMeqIUMm/QhrFA5Q73FphRr2s2QWtrKFIngYdYiMfQhyZg9o
 7k5fO/tcUVwm1Q3d3BWNtJa+0qPZHbQPcHr7pKhIHvWIiBhDnB1/f+CrOuyNc0GzjuGVeqbxFSh
 Tg3FzbogC7QsouSDlaENj4mseoYaRXSPZaprLSsXoYnUXYKBNvrAYgzIrdfX+TfE0+OrBJ1CC0S
 erlYizamdiUwKFvTIrA==
X-Proofpoint-ORIG-GUID: AlI9pzQYHyqhjgpoNenBqpJe_ZN_U7y9
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a9427fe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Bq6zwJu1AAAA:8 a=EUspDBNiAAAA:8 a=SNTRIsVtzyLZ7Te-p9sA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-GUID: AlI9pzQYHyqhjgpoNenBqpJe_ZN_U7y9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608300110

On 26-08-30 03:51:05, Joshua Yeong wrote:
> The pd_ignore_unused command line option is documented to "keep all
> power-domains already enabled by bootloader on, even if no driver has
> claimed them". On an OF platform it no longer does.
> 
> Powering off unclaimed PM domains used to be the job of
> genpd_power_off_unused(), which bails out on the option.
> Commit 002ebddd695a ("pmdomain: core: Restore behaviour for disabling
> unused PM domains") stopped that late_initcall_sync from clearing
> stay_on, so it can no longer power off a PM domain that was found
> powered-on at initialization. The only remaining path that clears
> stay_on is ->sync_state(), and it never looked at the option, so an
> unclaimed PM domain that the bootloader left on is powered off there
> regardless.
> 
> Honour the option in the sync_state paths, for the PM domains that have
> no consumer attached. Those are the ones the option describes, and once
> genpd_power_off_unused() has bailed out they have no other power-off
> trigger, so they stay on as documented.
> 
> The stay_on constraint is dropped either way, leaving the lifetime of
> the constraint unchanged. The PM domains that do have a consumer
> attached therefore stay under the control of runtime PM, which the
> option has never covered, and a PM domain that gains a consumer after
> ->sync_state() is not left pinned.
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

This looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
