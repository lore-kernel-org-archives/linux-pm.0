Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC83D331E
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860242; cv=none; b=OafTpcjemLQ5v9N0WTv0DTkud5l+32igB5D2P/vgmqNhbNVO/aTdwuY4PWreYcH1sNnREscXkd1HfS3/KfVfyR7QNFns0hX5RPXvzESPDaqS6UclRZ4nfV1CT2+UU/bW+pB7xK3fqlAtihMBnfVlsKAklcgU3F8ZDkTZ6X0dH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860242; c=relaxed/simple;
	bh=MfKTJ5AFYysRrxk2JQ+v9vd1eySQzwAgo81gCkk4rXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mia9Jxqg/1V0oVd+OlQYfDJ1rDxiHyUy+aSNj6v7ksUeAwmmJpIcRo0Pfw62qLHs5RCGN/eIrVb+lKtHl17JSIkIHBQkVesYOJsUF7VDtvcYMURqods4cfCmCTleBPEH41gSJnVf4VSK5eGHhEyK52CxprZYp96ziDkpLmHJw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tf/vTSHK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZuIWbCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tf/vTSHK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZuIWbCf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAt3kc2209010
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=; b=Tf/vTSHKXBQRMrZ3
	u4P8SJS/FnAQL57fs5TcrEM1JyTWgO/Zu2W9JnxUA+VEWxpqLpBAb9XCevAPLU/g
	JvPMpxnlww5ZjEB1n4nHGwzx5UdtAgpkDH4The0qlfw5hGyiXHYEVdF7ipMpGZ3l
	gcp5uFLH5BSI9mvaPR5k31PgRUf8iC5BJQdZjM2ICvMMYdr2S72OCV1r66R8XdPN
	QwHMW4HtMpq3vPN9LojJjfBsJwSyjb8uhgFU4AU0cQrg72/PPsdDlRizo5RFXv+1
	s+7lB6/d4jZw6lwx4C2i+6by5EuzOzLiyV7e5InUfm+Hof8dEFkRzkB7Ome+LdWS
	CVs51Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpengb932-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:17:19 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56e072ac05bso483211e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776860239; x=1777465039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=;
        b=DZuIWbCfhi1dA1epXH/l/DVEQh16chX72LV+BbI7OpiL99ps6EMTlWqypPuIX4OKPG
         CHGrP4QfSbAbkHyPRsAbBqnvxy4+ozLUowT2A72YmXwhqeCkYnfvP1b97DpR41nGWWiy
         vJy4//bSVL+gq6MaSaxMhebV0/fFFwgQVqWN8KuC33J1jqHbViy3WY1uEYSPobgh0Poo
         fmE7WCp2R/njry9Kwry8qsanNmfnhPKmrIIdzAd5BdpG/tVESr03OY6Zfe3NArsg3+ij
         xPf6PzCX7EgqxQ1rnHLWP2kCrkoiD5yhl06WGk2hspkh2GvKth9pJ+w5gM7qbj7VB6ST
         tyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860239; x=1777465039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=;
        b=IZUiEJrDIZMaOIyVKSdDAfDuubcn6t8s2mebjq35ngsMQ4NBezCRXUu45omEBy2NkW
         rs9ejtjVtyurwUDRyAy0ryBqPz1z4/z43yNdHULvro1fBTqdij1vmAp+cR9Qw/qv679U
         Nc9EIs26b+DaVkjvbCnb8XUHTI9ioi9PRzVwZKq28mZh8nzN6NTaIMHrCcrIDyo7bTZv
         hpqf8jDitwK6vBIz5N8nAZL7e5kZGfahKMs//IItpedZNjcahsK1CGtRjsTunCeZGOSR
         p7Hdpmex6D+ZlGRtJgKUWRtEZQ2yeHYj46qlhz3JzgPKERKazF0ThZE8rdY+4fH2bEpd
         qGuw==
X-Gm-Message-State: AOJu0Yws0JOq6boBi+WdgjNjqy2PJ+ELj4JeRD+JKnf8Bet9pkTTXwfl
	O9FcAfMKys6ODb2HQaIRZBpcPPqkPee2q6G1YM6+KYcFBFf+q1UKQ9jKiw5roNLR5kv0aq810oc
	Klujam9bxw0rw1NaS8ay0zwIB86f9iLvqRavZpnMrT1ev64CRqbbc9nGua4jDdQ==
X-Gm-Gg: AeBDieuybVNYCnxAvBfVStxHqR9S21DLxc1kCZHyiZC5lBXGxXMSHsWX7NwAmBghCUd
	EA6tjgXbMz4sI7wbdoqlkV5zQcd8M9vWGYjrqR2LCs95mimNum07BRTjJq0UfqOJTfsPLcK9cov
	skjmzf/oHinlOX4OYTYCDtk2Oj+jEHzzafS30nAUp75Ca1X+jFYOYCx9fMQStZ3a9wYw+70FrzP
	cgtQUskN3yGsqiUlgIfyux3YT1ALugAEAt/OaEY5wu4QuU7Kb9YYQCcASL2SVEdw0NPrxPYiUg/
	lGQZxTLu6AEaBkF2PJudoGwrPdPm3d/U/88+HDMZG+3q4Dasvmua/StCpgDHELcAKnh5DPYHM3r
	l3ONHeQijZQj1IS5YCZTjf9lswdVEG9FUJtOXLrfB6vZJcTw0l0I+DMzHwslQtsp1pgRH5Wllq0
	ZXo1r4dr90fxlTMw==
X-Received: by 2002:a05:6122:6001:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-56fa55afa30mr3725085e0c.0.1776860239327;
        Wed, 22 Apr 2026 05:17:19 -0700 (PDT)
X-Received: by 2002:a05:6122:6001:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-56fa55afa30mr3725053e0c.0.1776860238852;
        Wed, 22 Apr 2026 05:17:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e2d2sm3095513a12.12.2026.04.22.05.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 05:17:17 -0700 (PDT)
Message-ID: <fa725454-2de7-4e96-a828-ecc229a57371@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 14:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] power: sequencing: pcie-m2: Improve PCI device ID
 check
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-6-720d02545a64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-6-720d02545a64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfX//eCbUszxyI+
 hetcCQxdfyUnqg3kCY7vnxlffdxSkrbF65lVybeuXp+Ab1wDKSqg2W/kXHfs44S4TCTWkD/1fQa
 XkTZ4p07WqCgQ7kT/tWTGddIk/FLUNkLPCZmZBJqnDdkHhT5puG4Mfor4dAG/N1UpnPFd5kvNuD
 QRn5PnW34oHMX1lwz42maEhyiV1N1PxMQFV/RWiu88i2hkCUDVhR4ShrHQESlBItOftOHmDF7ZW
 X4HIZxL/et9YElRsyS25Y5eT5TvehNgyMeQkVXsSmwbXW5exMMHjlOPlH/1fjoQ40BLrXkf3UJr
 PcxPGZpvohvGQC0eSB+6e/n+xJEoOFfOhEp1ttJFz6szfB+CTe9cvqQ3ggpJOzt9YLgvsQooIkp
 D3bIEiSBYioqLFuTvMnWxOUH1zFblZ4fhPlYr9/EOPp3/T1p1Qisx5GgPIhWW91lyO8MHSJiEjD
 6j+Rxl3gssXCaKpqiGg==
X-Proofpoint-ORIG-GUID: qKTHmCYC_pgn_Mt6l0tZieIbc0pDyYA3
X-Authority-Analysis: v=2.4 cv=RYygzVtv c=1 sm=1 tr=0 ts=69e8bc4f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=q668qMPRPbE92s5sCn8A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: qKTHmCYC_pgn_Mt6l0tZieIbc0pDyYA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118

On 4/22/26 1:24 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Instead of hardcoding the PCI device check, use pci_match_id() to check for
> the known IDs using the pwrseq_m2_pci_ids[] array.
> 
> This makes adding support for new devices easier.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
