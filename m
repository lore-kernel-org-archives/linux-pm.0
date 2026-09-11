Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27363380FD2
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121783; cv=pass; b=mqTAgVyMMGCUBjqG3SfFhS7SFQGwmaGqAm2R11uh22bcaBMtK+4tqU9q4gn0QNiN1jeW8CSdfT5lLWysyS8nfObYjp04UUTCiRIB8DKCFrwrL3XNUQSlCXV3iH2fDiB8RuPWfavK/stOwrL4dXLVX9nI2Xnc/HUsBp05We4foZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121783; c=relaxed/simple;
	bh=sTM5l7/mcpTgFtlO+bTq27FtaZVY8D3bMeRpxINvEgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEow/Bvekh+ikMOtu9hlHBm7HtuJ6pJ68NNPbSZcSFTcWLqOfRIgebqbQ/O5gK7shO/PeAS5OIXTFWXl6EIvdVnPexJVRglWh+LQl6Tfzweud5U3j8/F5hbVi29+2Dzl/cAXiSZ+WHUTo4cQFKefzC9uB7VsQqkrswvA13PhmmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrR4J3e8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTysus5B; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrR4J3e8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTysus5B"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7ksZh423725
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 10:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+OJapG3xvg4UDzpEuXgFJ8O+WhYav0LSOmiv7Ij/KE=; b=PrR4J3e8x+OtDO1O
	JurWKSGR7mZQMxGkxFWrpX+utMAc1QQmmECC+J99ANcXMVPnpxGQqXEVk78ieeLF
	bxhyraqi/484Ui80ebM9twYlZamO5izrF5AYuLp8+KAX2jecaajL9u6H6H1eISCO
	v932yIZLlL4JlVLgDLqgzvpPfw5EYDItlo0FNKWU5r2eqec0HiKlQpI3O2nnncM4
	qUwBxfMZZSDWthrnGgMgYc7K7xaWcBsBZURlATzRDj2dBWIwJc4LWfERpaQg/V15
	C/4QPszSa9Vrx6kK/UPefSCK/uJR5vDyst8JwV86MsQvZBGuljEO4GqtcEY9DMmf
	GGck6w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8h5v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 10:16:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d54187d8b0so16679955ad.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 03:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789121773; cv=none;
        d=google.com; s=arc-20260327;
        b=FUO+bhMw++jP7HG4ii6eliXrt8y9YZyFJJlWO+ybGW8n1CELTC5JtCgcHS0DDrUfCw
         zshNheq7XSLbz6VC2cbiImrNK2cH30Qa1s+NFLkfpmjpxShFOlUZM7sNctIPklJoT4bn
         0R4vND1BBz3w0jJAK6YdVD3426XFdI1aKU6KsYWEMRXl5S9LvGgjYlIBK5XGGfWCS2p+
         abeKg69tzZ4PYYNzjkexDgwYP7KWwD3KlNtNLF/iSS88s6Wj7HE/NYtucpMpKynMFOsQ
         A5HGU1JFZ1L0d28dijytVfYJF4jEGHXcc7d9Vo0TFtDFiugnHa/quj+uQHUvs601h3pX
         bcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+OJapG3xvg4UDzpEuXgFJ8O+WhYav0LSOmiv7Ij/KE=;
        fh=Q3RygLmtFVswK1W0EqCaZ88CS7hcnvwinttvhb12NW8=;
        b=A5Yso1MQE1Tuv8o+TFrsfrrrq9HWvpOed14t7gls7IIthK9jWRPWzRuZ7sNA9cmm/C
         foXoa38w4uvlM8vd1SYEsxUNdzzoUd01F0IKZN/hVrpcAiZ2hGlvMsXbB+1stfmnUD7C
         u8x8LJuC+VtBy08nFvre5rf/y4gDIGimKJv87NMYrn8B2RfBViDWNb+wkELNjULOdarw
         fe+0q5HmCg/WVb4mP6CYIj/RMNrTgwuFEndI+xZmjGYbLZYJjFdZmgpkLYRZdgoN0PJW
         6UvSzKrXX5t5aSo7gq7Rxw+MoDEdi/TNerahqxLaCc/Qhr5l8PK4WSkXFItoXwkuebqZ
         Mc3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789121773; x=1789726573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O+OJapG3xvg4UDzpEuXgFJ8O+WhYav0LSOmiv7Ij/KE=;
        b=QTysus5BIfdvN/xf+iZzwakSsQxEVCMTjFZ6uGr8a0oaV4Z6huFi3T+Qi3TOxqRuCf
         nR9wtlZDKNe8jwU/1t61V53B8CUZzniUma1gewwdRJSTqGpKUinF1CWzp31BbTvkM7Mn
         jFQZUnu82uds/rntrqwW4ks6uFbPnOVUfGCP76C2e56MLsX+tsQUTylIwDAI6D4U/dGD
         tJF/D5LQ3RD/iaRNQLuklpvwjtKwc1+0iz//4R8j5X8E+PXMDe2t2HXbXk7BuM+r1krz
         T69d+gvZLDFkVKEPrxhGPEg3/HMvOqFMNxK7pYTiQ8EkqnGdhQNGpmniDOVZ1EUWtNW7
         8dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121773; x=1789726573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+OJapG3xvg4UDzpEuXgFJ8O+WhYav0LSOmiv7Ij/KE=;
        b=L3vGBAjFRSz7oQpnXLNoewqQTJohY3gJcuhkjD1ipyw4LuHGQDY7xnPmHrMbEdXAcx
         ZjhH9ybuBLT5WwTCOxxk/XBx7CNmrwWWyCUMlU3ftJ4pMzaQ1TjBx9BTtCvP2bP3HzDg
         0Pd4uuoWOflnnxy7EuwAxWgTt7S02t93RFgW375YoMh4yzg2L3Nhf07gzSDW5GxYac0W
         0hw3QoT0+eRh/uvRDISIcCZf06eGls+q6SH63eFfFri3ZjWkxuej6ubUv57sl/SpO2Qn
         xh3If4Xj89qk0PB2r8xBVc0xWtvt/htEk/s6rVsKbWOy7Sd51qD6lO7mBU576DJg8XTG
         4VDA==
X-Forwarded-Encrypted: i=1; AKwUvBziQ32jdWjaua2hA2N/kxk+h2S6ScgzFIY4VZ75hWGilXqLiB/qiNZetAmgj74BsAkRDUO91Y3k7Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kKTGn2h1qXv+Cvlk24UQpddDNNQtoo7tXsvKZgf2Kh2ElelYP2
	2yarV/BiuSzPmJhuqneoGZSTPQKMT/NpENE9t5hEoW4t2hzCpibmIjfoUS+uGAWozUuipgLb5PY
	cFnty2EJrjB+MOagRjx0EPD/D//GUNhyHV4NZDsLEvEfLB1tab94EW8y3jUgWsGQZ25Zt+sHFMQ
	GsIVALZf/1Rr6cDBE/fvUzlN1iwaHEKbT4ytAS
X-Gm-Gg: AYBFou0GeDHd9byiTa2gaTB6TF43l7Tb9p17wFCVn37n7wo0RzTVZvuwBwbA4RUiNI3
	qu0HVhpFd7yFw7W2pfDbLBuMc9E2YI84UxDzSgLuaJo8e+iZXyohRMtZpXxcSGU5drabZ2F1BO0
	h8Zy5wEZpWno1uX7EH2L349NOmwzydcU7au4kePj7yYxY6nd100G6tGZqLXA==
X-Received: by 2002:a17:902:db03:b0:2db:55d6:349d with SMTP id d9443c01a7336-2dd2a45818amr67010605ad.21.1789121772772;
        Fri, 11 Sep 2026 03:16:12 -0700 (PDT)
X-Received: by 2002:a17:902:db03:b0:2db:55d6:349d with SMTP id
 d9443c01a7336-2dd2a45818amr67010175ad.21.1789121772237; Fri, 11 Sep 2026
 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
 <20260907111659.263324-3-ulf.hansson@oss.qualcomm.com> <02b29827-3ca3-414b-9377-972f3d46eb03@gmail.com>
 <CAPx+jO8Cf_NGJ6h30+cd-arAJGQL=V1HayRZqaTrM-xg9eUhpg@mail.gmail.com>
In-Reply-To: <CAPx+jO8Cf_NGJ6h30+cd-arAJGQL=V1HayRZqaTrM-xg9eUhpg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:16:00 +0200
X-Gm-Features: AcwNN1VXOL5T2wS1gBfHMSChb8upujLEO_jTsEBDjEO09CtMln6UezixLgCoqhc
Message-ID: <CAPx+jO-ZP_09poe0rHm+h4QQZBbHJisCdQGa6kA67sQAkU-BfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pmdomain: core: Allow a non-CPU device in a CPU PM
 domain to do power on
To: Dhruva G <goledhruva@gmail.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: lhpWhoPHhjlEwCgVTS5rS4ssOE8FM9Pt
X-Proofpoint-ORIG-GUID: lhpWhoPHhjlEwCgVTS5rS4ssOE8FM9Pt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0MiBTYWx0ZWRfX36/vbFF+QoAf
 BmpoOrRCuWiYCd665Ao7RVsA/aKwMP8l3y5fgiu6FikZMJmh3oS53UCAoxz8k1HTqyPqSskAaFn
 foXl6xxVQlxL+q3JKnrk/ce1O7uaDJF9LM0d59pCGVxmQIMI9SbPYASo60wMb/tYOxmasiPQOrl
 uI+XQwBh2YX7aHTRyyKqc/Yx5i4DCLleaa0I8pnnstqDR480SubA2qBmLVypnHnr0jo7UzPRNDL
 3rb88yAymJTg6I9PwXvzhwgs1Qnz0p+tEpwxtTFuTUJRA+cONZb8fPIoDDQ9k/i9qWq0nWsnVkg
 QCuQusnuH0nB6eQPxQKxay6ZhIitmVHvqB1rzkyHO4UjD6YxfrZ8bOgadEyfG/VqF42b70RZlSe
 6T3le8Qe0i6Xyidv5YHiaenTOZPujLtwMxS5jYyLfv3Ui73GH2V2RuF9xI0Ep2Edj+JgtowWwJX
 n5IppWaOUD5qEyVEVSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0MiBTYWx0ZWRfXz6Tuf2T2WUFo
 kUOwY/LwfxgyjpzhKnq8T8KKg5RV1t9Zt2tMZHUzlogwzauWYXTWgXbqPXBwLq2j+itzMYjsbXC
 Agj1G6CqGNsQEkw/0RtjfT9MDLPDLew=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3d4ed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=u8BtVuMVLpZXKRMe:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=42KKylR2Cj7GAKIKN3YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110142

On Fri, Sep 11, 2026 at 11:06=E2=80=AFAM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Thu, Sep 10, 2026 at 8:31=E2=80=AFPM Dhruva G <goledhruva@gmail.com> w=
rote:
> >
> > On 07-09-2026 16:46, Ulf Hansson wrote:
> > > A driver for a non-CPU device that is attached to a CPU PM domain (th=
e
> > > genpd has the GENPD_FLAG_CPU_DOMAIN configuration set), is currently =
not
> > > able to power on the PM domain. More precisely, to power on a CPU PM =
domain
> > > one of its corresponding CPUs needs to be woken up if they are idle.
> > >
> > > The current support for a non-CPU device is that its driver can only
> > > prevent an already powered on CPU PM domain from being powered off. T=
his
> > > leads to problems for a driver while probing its device or when it ne=
eds to
> > > call pm_runtime_get_sync() to turn on the power for it. From the driv=
er
> > > point of view it looks like it all works fine, but when accessing the
> > > device it may end up with various errors as the device may not be ful=
ly
> > > powered on.
> > >
> > > To fix the behavior for these types of devices, let's adjust the beha=
viour
> > > in genpd_power_on() to wake up an idle CPU that belongs to it, in cas=
es
> > > when it's needed.
> > >
> > > Link: https://lore.kernel.org/all/CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNr=
sZVYO=3D38R2cLV8nw@mail.gmail.com/
> > > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> > > ---
> > >
> > > Changes in v3:
> > >       - Moved to atomic polling, pointed out by Dhruva.
> >
> > Thanks, but even in v3 we still have potential issues.
> > It does not fully address the consequences of polling for five seconds =
in that context,
> > nor the parent-lock nesting issue.
>
> Well, I assume we will not be polling for 5s, as it would be an error
> and it means that we fail to wake up the CPU. But, I get your point,
> 5s is really an unnecessary long timeout.
>
> Ideally the timeout should map towards the deepest domain idle state's
> entry+exit-latency-us, but rather than looking at what is actually
> available for the PM domain(s) in question, I think it's easier (and
> good enough) if we just pick a common value. Usually these values are
> in the range of a couple milliseconds and in some cases up to
> ~15-20ms. I suggest we decrease the timeout to 300ms and see how that
> plays out.
>
> Also note that, at this point I don't know of any use cases similar to
> what you describe, where the device in question is in an irqsafe child
> domain. Hence the polling would not be done in an atomic context at
> all, so we should be safe. Anyway, if this doesn't work we would
> simply have to limit the support to non irqsafe child domains.
>
> In regards to the parent-lock nesting issue. I don't think it's a
> problem as genpd_wakeup_cpu() is not being called recursively, but let
> me double check this to be sure.

Confirmed, I could not trigger any lockdep problems with my tests.

If you are fine with the above suggestion for the timeout, I am
thinking of amending the patch when applying to avoid posting a new
version of the series. Please let me know.

[...]

Kind regards
Uffe
