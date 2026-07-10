Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CE3F58EA
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676631; cv=none; b=DAVbgrzvr8wHrhuFp1eQegp8me9ls0nwLpUPPkHhUPAiGcKnlSUxZGn9Hj7Peq+uPn5A6F06VDrfBkIeNV44ZZzucjoc7cCJk9k3YjE+SlzOjq6DLwRvqWntHNAMtlSetbjply8RAlKJG147koLUjacjdKlPaipOWllV4dCCHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676631; c=relaxed/simple;
	bh=DNEj/bYxVRNoGmGDSfuPj+SgpTbOc/y+W9R3xVCwfPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyQAGLlhsTUFfzqgGHlDOZCdMykOKi3fMEjnF10EZtRoDY5U3/4SDPeZhqh0HsCoL4P47erM1M6cmNQTk/sznjDqdeoREDx262jUPLrqdUCyNsvv2G4WVgkyvlkuoX0r3ru/q85ye87gZsEfxsHBuqgpDBdZVSAWuQIydP6FQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKv35ZI+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WCgwOpMD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKv35ZI+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WCgwOpMD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9Tbkc391248
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=; b=FKv35ZI+yER7mhFf
	0G9MVvzDZC3HF3DlWssBkB1aS+VdD1ZOnb13dmcTnUCOEVnWi4B/KiiwQ8sZdHbo
	N0adpdcoNVv4g61+jtfpLXwAF5kGIRhe0fdlF9o8K+AIvutsjxcBBxdapKIvsqBC
	qVijZ+/VN7w9d9ho6yygWyNzoE8t3WSJg0gxw40+ccBvwyOb9CMqO8u3Ot8forAz
	e/zDRyx5Msp11zlzOeGOSkhRKgQDgkV7XA5+bQ53raqJbOXxLyiD520dH1yVNFRM
	rCf2l8Rl4gesAhiqU3H3aUKEuNth8jFi3T8kG1QLe45n1ZPVBzJVivHUXx6RmJLC
	FtRhNg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f81xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:43:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso2118377a91.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783676624; x=1784281424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=;
        b=WCgwOpMDZV9Wve0IGQ3qvbB8Qe2hrifXa7MVie+v+T74L3KPNxiV5kZDzV2mymOZPv
         3l4R7lH3n6S32saoHI8eGn+gbIjSVEaeNb5mLBr32Phf6CvwicbRlZna/5OP4dmAHFAB
         qHIZfXckBMvaxJf+qdKVUW5fKEUZh8hmfMUhwMfKyqDkUA4Mx7l3ycKvfQ5JGio0H3JY
         DitoJT8JXeVLdst2IZ0xGQWfNVLwCg0swVPYrDU7j0IHifDKIgHzKqftNlvV+gYPCZSF
         rU0z00V5I1XfHoztnxwCCwutDTkG7YuoW6jyRO3zHv6BCyf5RPHaifTRUptOFZeHqDHJ
         1hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676624; x=1784281424;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=;
        b=FvYfwIzU842ixOgUkEqktZ73o7xIj6FDBf5LvVBGz+Jqqsh+sU3R7SAvGqYX1v2yOX
         NTR98ozHbA8lZkdnhZ1dI7/uZ+xLys1i8Bpaskb8+ZkcymOqQRxvVxU7bo68fKXMeUMn
         S48atw+rlA0tWE8JwQIvNWcEHGAFlSUzlS3r/SWHMRrfJKYzZCDiMeN/njkTEDMZI/Id
         Nl/6bpG8D9HVZZMO4lg6jglZVhN1RpOq0srZX4iVyRIA/gBYn9xkTrJEeG34S7tXlxgN
         b/EmObjLDPK/k4/EPm+3Trvh7Xc2QEgmCV45dpqwyf8N1PnWk5KC/kfVCVZgvp/x0+Vr
         dcbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2b7i+1na60oOmeXTKCfXFIjdgeBsgBQPYLFBIdo7Nt5NVj/PL3G1Uv0Kx2FyQEXY8kX+Bsc60Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/HSI/4zqGN2jO1DqyqK0aVDC89aVCeWvPuwnffKBFD3jdmcW
	goj6xKPuPdslOKuUg04msa2rIlSwV/WFK4k/sECZQ2ONcuFNv7eYOdv1GGkf4hsRPPET9R7qvX3
	w2ti4UGw8cyqEXREz0kXPk5jsCEeMQPuSKXFNCzjHgEok7xXJrX4eY0NE5vbhqw==
X-Gm-Gg: AfdE7clBYNbYvZCcG/vjDaO6CqXU9DGISYoD9eBOL37/mQzBSpA0PXE3cVOe9pPCnj2
	LHub49qAAEydjUakd8elXaAbgUVFSlUQ201Q8IirFZWDxXhCzOr8v/5W29FeX8bKVbiqCmRX7fm
	UgPQoraCH9yGC6ekkFvz5v1G+1TjSNFEeELhU+sWvJJjo+LGQDVaTJQZgKQLZLr3TLrX854NNCn
	5ZM2cNmcD3cfxNoaRNhdHNaC9cdGvrwxaXhs2yHzJrzlzaRZCh5arGOpyRSDJQdM2ArB8Mwk6Jr
	p7cfmwvaJsQj+YHJfkOz/RMykcyLP+gK5FZqdPdjW4x2ys+0847Eb2CTIz377VAFPYFlBXJeZsH
	FqJ2F5i/l5Cic/67ll13tBTthUvdTDlo7Gbi6bChXy+Q=
X-Received: by 2002:a17:90b:580b:b0:387:e0db:3faa with SMTP id 98e67ed59e1d1-3894239bee8mr10959553a91.35.1783676624210;
        Fri, 10 Jul 2026 02:43:44 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:387:e0db:3faa with SMTP id 98e67ed59e1d1-3894239bee8mr10959500a91.35.1783676623644;
        Fri, 10 Jul 2026 02:43:43 -0700 (PDT)
Received: from [10.92.212.146] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b0240570sm5176800eec.28.2026.07.10.02.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:43:43 -0700 (PDT)
Message-ID: <a9f320e0-6a72-4e93-a57f-675fbf5d51d3@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:13:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
To: Mark Brown <broonie@kernel.org>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
 <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
 <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
 <5a1dd2b7-6e26-4806-ba71-175b195137d6@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <5a1dd2b7-6e26-4806-ba71-175b195137d6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a50bed1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=h6hYde8dkmUs3SIWvWcA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8l4N6QytbJfFR1QjToVbF2DOmwO4XMWz
X-Proofpoint-GUID: 8l4N6QytbJfFR1QjToVbF2DOmwO4XMWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NSBTYWx0ZWRfX0glqRl+nTw9+
 OGosCSEm2RH6kFyVGsyyqAbDWoLFKsKiytmvyx8IJPFeutCejWC4ao15mNlLw8BHWBeKwnS266c
 5a4WeBQAB8R3J8F9+YswVT+tcNm5H+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NSBTYWx0ZWRfXwkm+g0WfnzX/
 5JXQsbs/usW76mjZtOKxyzAolw1V2GjWGqvv95aEi71dVcGkPzkGHMXPXhtHJh4fPm1mV+ncD9X
 IDBWIyM4zrlC0bZJ66/gRCN/Vfxjdif/O17IQmBw/DH6sKlT58Rxi3VOFKmOaqKhopEr5N6uBi6
 WQxllcyZUJSRbBVrQlDabHKFLe7h0ERBNWSmzkMymCT5boUczH1yQZrtcME9Ma1kp6U6UqaBwiu
 ABb9SLN4FyTts0HLX52KPUf5GpXalAcaD+Zq0ihj63xjXZ81TnLx3ViGGi3QLHdptN8WShcIoTH
 6469Fxe1aixNuKDmt/0cGkHIGseHNHEbXSoLF5BKBieSxCI+oHc1h/X/t5JH4pIB1CIiKgMu74I
 +APgbYbOUMLhaHA0PvnbHvTxDjK7yCyp7Sft9PQ2tIn3VBqke5zIexEdhJKBLmtf04iGl4mvN9I
 A6/srBq2jbuTPCHsGVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100095

Hi Mark,

On 10-07-2026 14:53, Mark Brown wrote:
> On Fri, Jul 10, 2026 at 09:41:26AM +0530, Praveen Talari wrote:
>> On 09-07-2026 23:59, Mark Brown wrote:
>>>>    static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
>>> The above breaks the build due to removing the closing brace for the
>>> function:
>> Its my bad. It appears this was inadvertently removed in v3, although there
>> were no issues up to v2.
>> Please let me know if you can add it while picking up this change, or if you
>> would prefer that I send a v4 with the update included.
> Please send a version that builds.

Sure, will send latest version.

Thanks,

Praveen Talari

