Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7F45A29E
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363102; cv=none; b=d0ONH7PHvzoe0totxjmrEqHMnXdPyn2yNargdZOM4TTRvDsLWCwkRauCvWPxtb3WyJnQ8K7MstMgjIuaGycMDplwsHsZCjAh5+TEyyoRsI82f5nepFsG8XxEqfOJ7/OM4yPDPDlWiO/rzrTQoGucLCbZ6hhp3qnRE5NDtOVxW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363102; c=relaxed/simple;
	bh=CiCPHoKbA7QwOLstlzHIyTwZHiWB29u57jr15U2ffdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Y7dI346tYCS8yvDzTijmhNcDa1xnEneD10Z92daZ7HUc+S5d7Fg+pmxZHNwtDCFu1JTo7QUm034m9idO7fKq1NWhpyJFm6RaXIDH6ySLN9TmQrUHyROfH5ikrLAMwNHyOEwRPLxamHrpf90ov/Hu8s3nGiQyOmVK6nwpClV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4OpEcQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YfPNoujj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4OpEcQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YfPNoujj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jiTE151949
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 08:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=; b=U4OpEcQkQIQ4z5ej
	X4PJJ8RUbYDn3oovYkwGFkhHWi6r5CyCyPlzQ/d05CTJCrQ6IKSAfCgYAA6rW5Jz
	giHiRMXWfsdCljgvOd4zpvdcxeU8JHTfljCgbK1WD0kNzZ+4giroSrHf6q3uXj3g
	yEApDeVOHzVf42ENaGHa1nIdV2GZ7zWB2FcQNdVi+BVEhhk/Yeu+bhE2chvvWspc
	k/uqDJtOeQTeQP7fqxW1foOGAbfVOCN6Con/wxoYOxxKrz0zs/dYC6gSwQKknrJW
	y33M3sgngOmOpox9KbL8Gv3+7NiE171C7tRE/1PSxnEDdT6ErsD/Y2oD/VtIo6YY
	94AQGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719apm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 08:51:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso4058186a91.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791363100; x=1791967900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=YfPNoujjzYkqOobFz5aB1TDTBYPTrnIW8H+psjxkZreV/LyLZOl0EX31al7GwGCDFs
         UHS8YIYn3ag5ONpgmIrGWMvsSt5I7JB6Zws1QcWujpmRqaHVagdTuT0wuem3xf+Ak7/m
         OLo93p9xxWGOEfPa2g9F+7ehJq6NXNBltyhnYe4FzgsHFRek0xRHO3BIiFnmVawg2Xxb
         3CdRHlJdLUiYbmHqoShxwZ9ZIrglrH3ZfDMcRmkanc4rPwf2sXiNbNuStlDBsLEMlozd
         T+M25qsOCJ0YWpIe6TMCaQgCnMMqU4AhDDrKJ2So0kz5QhKtXXY5S+rOzUeGUALOZvYN
         plLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363100; x=1791967900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=o3fyqGou0kQTa3ucM0jcGunAlc/Yvd65TiEqaPLhqtHpVrweOCqhCaeNHoWf87k/UN
         CHfMfipm14dMs7Lcmq7TUxyGYmfXntiYSzzN9d3Bgk0v6vavEzqzM8+V3VzigUSMijea
         dpk6GaT4N9P7EpxBDhwRhQ0NSv28FNwnulw0ff5Xvh4NLoqDZV+wvFRuM48CaucTHUhm
         Ssz8v3jvlgu4Nh6puLTVEN6qTx/eTcBRlAU2MqH+w/5Qs5q006vIeN6G1jD3AYoWwYYV
         rJpbC6KCfpbja73kGu+iaVwTa7lOgkt7pQdJSZgwRXOGHoLhavDiSbRtWAbs4xF8zibT
         51Bg==
X-Forwarded-Encrypted: i=1; AKwUvBzZ0JP08d8XcXBRKGHSNRZd2Puz8wIMRbTIQYeWkfk9z5xCKeG/yukkvnEGEQn8tiJw9YTmZbMIcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLfHPUJikAQ7x/lLXBXsGuuMy2/MC1gohN/1sj9w5CJoeC+QiBs
	qHCKFVCQaX3sDK7zbUOrh41Ujf84W++ijYyFzC/i2sylalTDGzliiXamTGddfV/VubtrNzrzeel
	pDwCVYj8rLORS14BCm/+qC53606hH/8q/1Yoadj8pncAn4le6OntssboccHmq2A==
X-Gm-Gg: AYBFou2JZO5NhUfB5PhbXMOYW0S7fe9+qRSRB327W9GPc0lWwikgGicoMCQ9Xe5/PxT
	geHVvSevxnfNA0PaBhNNmmVb9LuFRU7dTHi6rVTOS+DUX1QEZCbQF7rSgvEpL10xFI1r/JdL8qm
	kIxDwPvun+UzTvswK1gw/aIjpBORRVD8naADWRedOP7xHLcZxfc8rNHipK+tQGQjEPQVWsfrl0G
	Uk739X7Sl1BZpGZ2luwW6teYEPKELvfwngiXMWf80OpbYsvGRbmQYIqBlNV4vs1hbtpNO9xysnB
	PeLTba/JOQxh4B2kWJy0IjqtDSXqndaBFJM48Sm93u1taH7Hd8SSuySvzzxhYdfj9P2U83QpeZp
	wyOM9f08Za8V4VqmUOf9nEq1q1fHq8t0x
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409056a91.47.1791363099903;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409044a91.47.1791363099481;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm6760885ad.50.2026.10.07.01.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Message-ID: <57f068a0-41fa-4986-8702-8fd3d6dc0976@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 14:21:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX2WeeQkKydu1X
 BpA5w8fx4C5b6DylC38XiXahrPFcLCPby9MDzCnE9+68mbf8GV3FZeaijf6HrHY3/jMPU3QAm/A
 fQtePRagtXjDAgB35bpjBliuPdJojDQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX/y9kmlO1jU8A
 JIe28NEJ4XchVZkQEqk0DqIn2leIM/P6YFLF1ubTZ4Wt1oIGKM5xK5WAR/HVEMle4bDaQk0I8UB
 8LEsbzULbbmJI67Sem2R4EOCES35Q28laTj5UkAEg7qsbVchg4BcB37SGYW08IxF0PUXi+ZHRwe
 J83QqR1PIFhF8EL3Fa69Tu4v//DTTCEv/to3Mu8fRF46pLl0Kd7lnDUoQevns0ecnAWOvUT8OHb
 9keJxCAmbQ0iFQ6qcFR4GN2LmWCYHLZ9D2PYK1iaCKw/ObbXwxyA2FMxmdGiA5F7jlVYezUMkYA
 hNRu2ggiqDEjAWcY2NjJwGN3rq+yR0q6zBdD44H/6a3fu6qRMpfVybSxxuS8Ya6qc1hDIO5HCBo
 kQGOji7q0jB7pszaJXoVb0mG1eL70VSiTDY1km9lyLVKBpk0bZKFLD3dbKwXRUQDb657/Tf21S8
 6XDbuq5E/HNdbRTQqtA==
X-Proofpoint-GUID: AeByyScGWwvTu82dg5eh3xez2NDof7CE
X-Proofpoint-ORIG-GUID: AeByyScGWwvTu82dg5eh3xez2NDof7CE
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac6081c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070035



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.
> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
