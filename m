Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC242903E
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184122; cv=none; b=fJ3VXwqT6+jUbadDDY7RhdjgXiKEXebM040rve8m0k0UYKdAPp6t3A/5Gh01AI3BQlk9sgyvVB1D7WQWttDg3oX/BdZHxLXNpFJTvEvS9RSLBHCc7zjPxORWQknLhd1NjUsDqyWXDjB1VMFhEnt8wr9K5iCqBEuNOGbf55nwo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184122; c=relaxed/simple;
	bh=iXWnCvVZ87ZhxeHXve8z6eGPTqXNBUtx57uGAyUBYaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vuq4a8pSapFix+2Svde3QUFdpYIlOOmW6UHtC63O9sYI8Dt2toM/JNYsqodzp/oo0sFjkwVPZjjQ2y0873ONjWq4VQNidSDc0wHWPKVJrQSaLGE0jKyoevkTKEYHKDsmWXSSC/47Pfs0guwvC9Rzkd+9sSKlOdWgkov0aOQa5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQgu4Lr0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cKUeNf5M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQgu4Lr0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cKUeNf5M"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIC47j4029065
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 20:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=; b=lQgu4Lr0xnH06IRI
	8zn/Xfh2RSw6Y2xrKOK/boi9q03xKJDIMEu4BiJQW9kFn0BHicPZICCusB+Gu/Ua
	zblKX42Ds9JlYXKQxDxpmTzHmcSfDb6wdfmZgo0YWTq21mS23Lx5y5Vf7HHxqeVx
	c9tCCKnn8OQ2cmAJTQS4OYxhJyEPZZy3g6NVWZl5cY3tjpzqya7b199Bygab10Cj
	7/FI5S2eCF0SziDa1c1qykRbWn3PeLig5PF1+lhdws9QifCOPwJxrBIoG85tJtYU
	L5zVjtiSmajiwhbtstdcX0M/UXqenVnUEHtOOpu4qpjjboZANFpXImTNySUeVZs/
	FeaHHA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6au2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 20:28:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb711c88f2eso1951084a12.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785184118; x=1785788918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
        b=cKUeNf5MjYufietstw1tWulbv+10NjknhYNO3pcg7QsQobMgcm6bzh5/NEBkrcjsz6
         71uBlB9Y15nU/m+TFtKrxh8gUN+pCU81e6bICBBXqbPmNUgQMD2ra+woqt+TnSA0dnRz
         35KLYcRE48C79EmbS6BHd3ubzFMJj5Ubg7GwmUJrro7DCe9iv+OUfnEK1D39Z4ATm4HP
         VbBSynyC5k7MuYG3/+9cHiNNuS92Ppuk2tvonxsumcmKSjk+rbrxww2eKehg64XgHD4t
         CvI+/4zfquhupckodGAwLi8FQCU+qzGgm7J9AEWfqcxPpYayTFCFMHsHpLKj2F/LK6eA
         /Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184118; x=1785788918;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
        b=DsKN2irtlBG1kSJDP/3HQDHtFXm+BJko608K6unR43m1A6Zk3SZq2KaDQYfWVkTnFh
         zKl6ETJ1m76ls/yy403ZxB13ZnbalN6TXGGGf+PegHceW+aH6BYZwo/Biaru6DVo8o7a
         XBAk7YIzgQWsI8yEjhi+4zN4onUzX+htggrzrtiNlDEPmgCiX6ZunMKUYCsOVxliXQku
         NJLq+o6SSmcxKBkMKVeT4h8msVz389sF9QmyZxvvZkWxe/j1cbO2KPWKStreoFB7sMrE
         qOEWI7CiBZFvit+chAIMaNRiFFcL67kbdQ1a2SZe06bPLLoDdxhvIXos2q7jjs+jfFhW
         VRvA==
X-Gm-Message-State: AOJu0YyeDaOoE62NheEgKXwlMFPIsSp2PCwb8l4FN6PVRtD0Pnr0dL9g
	lWo2NnXQc4CWNGpLu0+8XNVTDooy3kEyP2sU4JL/EF5BxcS9mHcSYEUVT9x56jyzHyk5yu+mWS4
	Y6aP9VJweeRto5u/Okf1wIukr4rDguR0tvxu27YCB1/avSmvz1Mae4gWM5kXHZQ==
X-Gm-Gg: AR+sD10fTK+qQ2f+25eWpm+fzaj0wur26Yv26GMwOrkWXhUgxoo2j2TBWVRfJOJQiCA
	3AkXgKIQ0eo5EOqey3970H083/z7/6cYQOer/0MSoQGqJFvwRvWEoxc2+QE9/mHcpiOIOrtczyT
	4dOsR8A5sZe5NlbCsF78lUkvQfes+lnZST6aVeUUSlydfREHnSkx5XstiblhZ+33cs15n3PSlNC
	GArXqd0JVNyTadAmG7XZGWOmgeDq+T0QPqujKxCn23BVeJ2LCwbkAyyLx+PkHnk5DxcF44iQ1NU
	P77LA78EprNtItZhnmSARwsAIp8v70Ms/VmUTaIx2aFAIXQYhvJBZ/HLXp9b4BWz7JZJalehdDK
	gHT+B1+K/AaPrvdSFwtOXKzcVJD3rzETHRwhKdf6eFwcCxqXsvGpDGBji3Q==
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3c6c7b3d0a0mr1108971637.5.1785184117718;
        Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3c6c7b3d0a0mr1108941637.5.1785184117159;
        Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc415eafsm35949179eec.7.2026.07.27.13.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 13:28:36 -0700 (PDT)
Message-ID: <477e6f55-d6d7-4a30-af28-dcee185cfbc2@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 13:28:33 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfXz1C8BZVvdsTe
 dFHhgAiA65YW9ifrQtmWejX2qLpnCLTMr2Mos/xy659+1LuuQJd3VohRWsXw1qIAsAx2qKIFQ4s
 DZii6KQBohxNVhEXv0eWK6rTRVTY1lw=
X-Proofpoint-GUID: t3YRDVB2NLTPO6NIiLDKQSAR7dh7qx9h
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a67bf76 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=u4B4c_klvyXDgThYlB4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: t3YRDVB2NLTPO6NIiLDKQSAR7dh7qx9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfX5JtE2x6TBQYn
 fOagLy+YCVzTbg+FF7BVxumthUvm7G7T/pSSKOU3Kj0MW2t5BU0yIInX0PWEilZCjpFlb+Axcn8
 qMRBg0S/FnPi+8wD4LBfPZACW4RFWMUw17SLARX4z1jUoPHapVIRumwlz+2fpF9GvKrzVGpisPV
 9aSVPlNpKD90R6wPbeGnOtsPBDN7b0cs0HkrSJJdKP6ffKI2AZW4FAi6kX00gv7otK76bzk04p3
 BQ5sdIGZaG0MpJ36KoxGnHLwrhbwcuFzDlbYbLZtk+XXpsHC85rdDU/FwovNwCoV5mkmuPRrFpU
 jD4HH8DylPnPlEL+u1Ls9JRl+L614hUM0oNpXZWVbzTe++z7uGXPFj76Jq2Fpt8LBbTUX1IJRyN
 VUvxSd047TvSwI7/2tS+R0cZPD03NJmyhbIVBSKe2wbsel4sMMXWqlYfvVgsOdwloHvWcDhTeBg
 ByuQyFt+Xv0Tssr7ZQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270183

On 7/27/2026 2:57 AM, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> We will also introduce the concept of "non-controllable" pwrseq targets
> soon which further increases the disconnect between the naming
> convention and the actual semantics.
> 
> What consumers of pwrseq descriptors actually do is: they *vote* for a
> powering on of a given target or retract that vote. These operations
> could be called get/put in line with runtime PM but this could become
> confusing since we already provide pwrseq_get/put() for a different
> purpose.
> 
> Change the name of the two functions to pwrseq_vote_on/off() which
> better reflects their purpose and semantics. No functional change
> intended.
> 
> If at any point users need to know *when* the exact power event happens,
> we can provide that information in the form of a notifier.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> I've floated the idea to rename the two pwrseq functions from "power
> on/off" to "vote on/off". Here's a concrete proposal.
> 
> I'm sending it as an RFC but if there's agreement, I can queue it as is.
> 
> I'm doing it in a single commit that should go through the pwrseq tree
> with Acks from subsystem maintainers.
> 
> [1] https://lore.kernel.org/all/CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com/
> ---
>  Documentation/driver-api/pwrseq.rst      |  4 ++--
>  drivers/bluetooth/hci_qca.c              |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
>  drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---

I approve of the concept but am not tied to any specific naming.
So whatever names you end up with...

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com> # ath10k

