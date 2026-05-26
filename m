Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D140B6F4
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820552; cv=none; b=glO7UoLP+Z5ro6T7wabiIURolQVN2AugNgv8DhfqQIYQVAEAfTLNiqQGqx2NJFH4vt5v4RhyhLXHy7dHntvRlHZx9ndLA5RmDDd/G2wDv9DJnzbA6L89p2rDWbxhy6MJyEWF+6uoSEWrHvaI89mgy/msIey1bfQD5RnUeos5hYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820552; c=relaxed/simple;
	bh=VpvZ5PcXkUHH4om60ug8MAySWRt6JTqtJxB1ZQAos9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSgaE+ksHQHA0DJhJDUGhDw/WHaiRnjjZly+O0pepCYbZaPsq76xbfyHbzr37i7liGxiSvaoOfOZmoZ7P9sGF4rIgfHkaz3xZ5eLzYW6A5PSZlz7/awItRoq3MfdQWH+qKcjgZ8McIO0JEnGHiM/3hRSZFkU3GTK9D7AZDqGNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6djBoeP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OCdvO+ap; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6djBoeP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OCdvO+ap"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH1diH069510
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OLtE6wjsTJE5pWtL33eU17MmRcP/aNLUd0BgNkI4/o0=; b=O6djBoeP6hZSQxkO
	XbPCIHgh1lY5Kxf33EH4eVE15Z5AAn5GKv07Adu4nJmOLzBvNJ+KoOjgt6S8yzVR
	EfsGjdK5NQwOQaTnX7U62PXSyYsi4p/WTS862oY/AX6If6QTZWR3bHH+Y5aLpGqB
	6Wjl50R+dd+MxG0maTVgUdNJQ4UZ/Jv2qfhcqhnvVV54phvk9+9VPdjjaewecvOZ
	igHVuSehRd5mCHMgsrEZ+/OqXYfDTfQOPrUQyioPFC9zMJADxCnBEe73iS3vZ2vF
	esgit93j2ligwRRfN+GL4S6Ma6vqz9hDuXd2jiAuBdrpsibu2yLBxiq8Vf/aV5IU
	dys7oA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2yhnj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516dd6e4ed4so89967291cf.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779820549; x=1780425349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLtE6wjsTJE5pWtL33eU17MmRcP/aNLUd0BgNkI4/o0=;
        b=OCdvO+apt+SDYAt+EZX8wkOLpAZCgxcZPKbYHg4RILr/bWLEPfXWGR+yN3E3VBfR7f
         RaD3J0rWokxisLl2rU/VUrEbTXucy7d0vgkp38X2Cmf3HrkrLu3jXD9haPiO2ennJufi
         Hr2dZrBjbkuNdOFX/A1Afuqh9PzEPvS5cEXQ8UwkACj8j7wC+cliYNEtjlqQT60n0VzY
         2gHpHzOo24b6kO/CcvfDv39AwfvmZ5IfoRccydaCpWv+u7A1rnJGFm9+E4+bIk7+jZko
         7a2ICLXYGX3ZcVZ7NF1k8qHl9St88aCaeM0pT7E+uqEedeK3fZYZhzPIVMFVZ6tQ6dnu
         1+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820549; x=1780425349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLtE6wjsTJE5pWtL33eU17MmRcP/aNLUd0BgNkI4/o0=;
        b=MeLYTtIZU79wr7pSITtqnEqmhDbmnxy2wGXVXbmeSPc3OKX816rQMyfyfkS2WXTkKP
         vVeohtjtX5VNnUfw0IsSzUWXu2jGFJXDoqOTNsSNeB8iCMIQt85zBHXQ2O/vxolR7e/p
         Gz0s+SJhsDzkPrMMSyAs7F1DnpzjjmdFsn7+s/a7zY88Q2DaGbHwitx1Sh58jNGoQd+3
         DgsaqO4U/7k2hW50s710HEiT5QcJMydGHysWf7bpS2UBscz8xAJxk8AvGVuv7DltxBuc
         Ia/sKPvvi5Q0s9m1iy3sqG24NieaRqsH7laxEjjrOg4AHgzk8ZEJn4cJFbINLXZSAlOT
         PEig==
X-Forwarded-Encrypted: i=1; AFNElJ92M23sTvyS0OHt/9J6UIE1ZUcQcQbvhQLMw0Qmdutbbk+NgaVqQ1HkGun5ghkbxzND4V7CEjE+7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBg2WsX7l7C61wuSQ/vvlOscTwmb3mgbfldU0Il2DfOXrNptp
	i1L7gtsY69RXy95SKvZEsFKYz2yM87eGhhUeVCCJ7bTjbv0gKTw5bKeRWW8R4SDX6hHJUm6xZh4
	35WuJFvWfwD3nSGREMMmwGuPl5xv8Y3QT+FQlKQOraaiPD+GJUH4SbkMBVXV10g==
X-Gm-Gg: Acq92OGc7kklvrTPqTVy84Ok34cAMF50bCZnvC8/Izm19YjSfgUxN3mt+5G4yur+P48
	lDvum+spcQTxgF3MB4tqO3fhPVcuwo9uIggXU7s84HR0o8rJBzFwhBWoitteM2Wy2n8abOn+EFy
	7zy1q7j7Ij6zIztE3O9OIRK8s5H0kR7dB7koAU8IEobEBtFQDXhCQmqdq+lDQPHtKRv7XpZ3yet
	judsiDUGVE0t/YGFcpX9j+KK6pHl73vQVWjWuIQMgvkRXXoifcc6/Dh248WePAXrLUEmvZXN1Xm
	rZSFphJe8l8m6HTK1UCgDjZV+uj6bxcBUrg5TmxCKFLLCQiO7+4odbhuPnDPy/bxmfwN9muGQZU
	cD9F7cO/OqOf9KMJT/zOIKgCGMGzad5G1b7K2LPA+72P+sbcm2Y0ZaNy2yfLlqchWAQ7yBJe4FY
	n+c9nnwhC6
X-Received: by 2002:a05:622a:8d02:b0:50d:82db:773e with SMTP id d75a77b69052e-516d44095f0mr255087121cf.47.1779820549156;
        Tue, 26 May 2026 11:35:49 -0700 (PDT)
X-Received: by 2002:a05:622a:8d02:b0:50d:82db:773e with SMTP id d75a77b69052e-516d44095f0mr255086691cf.47.1779820548715;
        Tue, 26 May 2026 11:35:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454dedd9sm314782765e9.6.2026.05.26.11.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 11:35:47 -0700 (PDT)
Message-ID: <a2751a8d-5b65-49da-879c-a81003d321c1@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: qcom: tsens: Disable wakeup interrupt setup
 on automotive targets
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
 <20260526-tsens_interrupt_wake_control-v1-2-6adcd75555b9@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260526-tsens_interrupt_wake_control-v1-2-6adcd75555b9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OrESj9YMFuaiL5dURKD5GavhCWg9kfKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2MiBTYWx0ZWRfXx7ghYQ+CoP0e
 9ofbevC8uoXt3JB54K8i6RLqb/gSGi61OIJYMQ/5VwPuC7fsgLl+85Hhw1+/kkoATiWEMGBhzN0
 DU1eqZ1ZSVUQ9T9Ygel17MOs+eU9Gw1aHlfCfjCdMoFUsw8SQOLIBHFzwxVi6+h+Y9S/bb57xDH
 0rvHZcFFU3dIz2TgDCjyNZSkmuivRP0hzlE0noQhciGBfAyiOKpnvgpuMrjn8p/S08onY1owjQL
 1fZy9exs0skvt+wrLhwBVvAnBMdeCGcZkfj8stQrJQ9Fq8GOUZWvAw9l7hMnnhfQyHlKFYmtrBr
 i6LFW8fOWvKOmk35e6XUagEbjsfR0sBOCPLqXtcHhL3tpTaVGB40xcJH83+kFKIaOPR8I+gmuJX
 C0nH2EsxFgmFQHLBTw5bSZX2Evxf/7oGiJDmWADbCoSHBiBmLx/LcMT69Ur8ntUwCr4ISM+VW9e
 ZN4ejxVbQBpijQlDqVw==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15e806 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=m5gfosTcClCIMLnN9JwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: OrESj9YMFuaiL5dURKD5GavhCWg9kfKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260162

On 5/26/26 12:18, Priyansh Jain wrote:
> Add a no_irq_wake flag to struct tsens_plat_data to allow platforms
> to control whether TSENS interrupts should be configured as wakeup
> sources.
> 
> Create a new data_automotive structure and add compatible strings for
> automotive TSENS variants (SA8775P, SA8255P) with wakeup interrupts
> disabled.
> 
> Automotive platforms can enter a low-power parking suspend state where the
> application processors and thermal mitigation paths are not active. In this
> state, waking the system due to TSENS threshold interrupts does not enable
> useful thermal action, but it does repeatedly break suspend residency and
> increase battery drain.
> 
> Allow these automotive variants to keep TSENS monitoring enabled during
> normal runtime while opting out of TSENS wakeup interrupts during suspend,
> so the system can remain in low power until ignition/resume.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

LGTM

