Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D440EBA8
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571610; cv=none; b=d7MJh4wlZEp2SCQDnGrjNtRls9omMjr6iZJgMiERVLMAeqyeKi66dVY49UhDX3oGlBmyAHgOePOXhRsyPqISd8Uv1BK+FuuYke+6VdDo9diUi3PUH0ApfxnySLvywQrz1RBSuRkp0xUXGnEoLYoyTfyLQzOIvQ8PDt2PJfyldiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571610; c=relaxed/simple;
	bh=mhM1nJgariA7Drln0GvxSUCFkFDiM3od2qwlyHrudFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/TC+dzCWEtSkSIryy0wvHio6AR+2i6mOVNuW9CaFEnqfOk1EKwhPMMW/7s0d/QH0hm8CxROVVB9Pyehjp3A7QnnJxGzM/UbF4bYhbpQpgYWQCRKrk/6cdJoECsK/LZPeZouvKwzKM/2J4W5MuLtSeWk0su/fs7oKQDOMRu32co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFJI3fRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbsCTWw9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFJI3fRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbsCTWw9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMVx82372289
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=; b=iFJI3fRU23uszfgu
	5sEEIzYEiTTWjY1lLLHsvKScGW1RZlun7PE2G2leVNNyC5gj+t4lxuZpkWDMJBoZ
	7EFRFKRd1CkFXa2bxK4W4YfsWUUTBSkkAQTsXFtU86Ys5cOj6uMCbzUrtrag4eVb
	cJl/kxC9jSRcvT5OkGz06ZeFsHdmpF68J5Be8yqRhapo5MsFG38diRuSJIk+XBTu
	tushN3mu71MMuQnbh3Ln2PThkoIYOfGfVBX39ZSTJQnrpqVpYNiH5vXzCbIw7FEx
	6+UeqFTb9ea82QUhLuPY69R2WrpoCo7diq1RQKGBo5bL3oLbeLX6Mvp6+fg4q1R8
	G7cD8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshcr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-385d2703b64so4750154a91.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571605; x=1788176405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=DbsCTWw9qBigNpukJCfLohk0niBZIcPnLiUe5MK1YvR1kNtfOL9bxrmgeE24mIz/Qw
         YVPNF3l961Db6M4e8+Kozmr4Ubs0I018s/DyrOW3PjyCZbTYE7jO2peV/HYk0vXjrxN8
         Tt1LjCIi+EFKNVqLIIoLmfDRntM7X/W4RkYUFyUEzge/wo7M/yI06K3Fj/Yj6oltqX3f
         NeRXNY/BtInmePjX2EGPotcRnsQODsm7UR6gFvSw7B7LpTB/rD5OSXGjD9FVZJpH+KeH
         7UidrantMfF5xAQmM2QKktkZcpDZYj8DpuUBJyTRvJHoh+AQl5gB/tgRKpCyuqmEXGdR
         9V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571605; x=1788176405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=qUMIvsiHxEDsgF9AtiGYtos/b1T7saiFJQJyb7ko59Fp0bcDwhsyJjyklgXyLXRyRa
         i0gSIqUbbJJoqjV2FImAA6fo0mUYm+g2KVgcW/maJT+2MeYSv0HXDi+mUDx4O8Q7t50s
         94YlSI0spQpfjfgWoXUTnzuxxyKUfn7tHp3i90c1/D3zAMkbNvJEsRxznLvhSszQ+CFq
         OpPZLlDr6ABIxAdKhFyPYTYLBXsBxpkbvD7evvd7lvNUmOpvLQhrGmXr605vhISOy++q
         QBs2Hyc3c9w7ywTFSGDZzzlF5xa7wGm8u+ymTMIerQueGHlD6oN42z1Ah87csSBK5lvZ
         wILw==
X-Forwarded-Encrypted: i=1; AHgh+Rogayfzr5Ntv6fPz7h8CQqNViFUsEE5vSyzzSp7QhqhekTrvhGs3uKq5sy7vI1MsH+1DuygAOsYcA==@vger.kernel.org
X-Gm-Message-State: AFuF++m5V70oihTQ6Ue680m4JW3tP2lLCxjGdREFCOuPq4p+uje7LCuA
	86AU8UwMbhYnPtJYRPoAKFtPJ07kYfJu3Uu4axUtPJpz76jSUluC++a0ltitla6MA7/lEKPB3Yr
	Z93E0wrGSunlFtA3o9+Br/Cc/0NJ4ANnN3Uhl0i7xmlsvCvQizux+CH7bhCTQ4Q==
X-Gm-Gg: AR+sD12pqR+YxliSPwkdLAQxUYcRx8OQ3BgN99opH0VIddz3rNI9JGyqwaOybBFU8Eg
	5qS+8Bn3giTmlT0Wv15qDZcemWMjWQIe2GdL0U2TF0cqSM4/MsYZxOvTNUCA/s/Lg+t8Jeut4+W
	E60xeJ54P8W5ktlzaPDpWPXY2i1N3tpAU9az6YEalOm42qohRuEUVPr9mNeXUnoX8rDAFobY506
	1oBNKk+kZCFDACVJggPfO2+kDMaLG3EnMvl8zPQcHRAXXEZ775JGcyi4fmQmvqHEXH1nik7kcTy
	ITmqPlU6G3oyhrLXmnRRNl1G/CoTB+SucmWBjjf4vWv/dzbWMQZk/yck8KirxJLTdWu1fsRo80b
	+/FQJMTcS6Ea4LJLx9Kkuc2ScT8Gc3oJ+2JQ=
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916676a91.6.1787571605395;
        Mon, 24 Aug 2026 04:40:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916593a91.6.1787571604902;
        Mon, 24 Aug 2026 04:40:04 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49e6f59sm9678818a91.12.2026.08.24.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:40:03 -0700 (PDT)
Message-ID: <9d73e9aa-240c-40b5-94cb-9b1b9c2ee380@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:09:55 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VjBARoqLHFqhazKdX7agdGM-IiFeZqX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX4pG4HaPbkPs0
 jR9D/PMbF7M8oIlv6f5l2Sq3Py792N1cYviGUNtTsQ6xH8Pnm7vR+z3hzKeC9Zxy5tfpWxlKK4e
 6J0Df7xciTRjFLXwYLyYh8ORSdBoPd1XpQZo+HvFcDVx29LNDf3j2wGqqGnqtKeQUFyTxNnKJpf
 2bTiZRtk1v/TDL5Yqbpfps6JouPch0JPaSyj3hxR11SeENoef+OLUGDjyPXpE6vj2AzUtwOcCjU
 PztS5ScFwdrisaUgyQyty3WW+0izpjYFUjIhX+2wllJ8My+h8JJHYhXCd2KUrgS/kpgqGdDBHYf
 jRYXS6KbpKfvLk9razIrvYIuRx+j4290EQ07BygpjAQhRvfrgTuEXQphZBupf/4qGnqb6La8Be7
 nKFkS45KT16gQFHMS7P7d6BFN91rWdz05CrQ/YbCIGaXqf5IJISFCEwN7+cKXznrcTnTTq/pgRQ
 wv+iyp71Ck9eWA8qlWQ==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c2d96 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=qpM7YB9Ikm2qReIqoCUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VjBARoqLHFqhazKdX7agdGM-IiFeZqX-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX2DqIxKLzXFCC
 ZWkoBNbhWBmZnYazBVJywOwJdHg3lbc/DISmIFlkJ+/lBVc3eNCZU2RRFrgCsK+S3wLH7+xvboq
 agrRdpFau+s7Kg39qrE8iSSGLkkrOlc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240097




On 8/5/2026 1:27 AM, Praveen Talari wrote:


> @@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
>   
>   	uport->uartclk = clk_rate;
>   	port->clk_rate = clk_rate;
> -	dev_pm_opp_set_rate(uport->dev, clk_rate);
> +	ret = geni_se_set_rate(&port->se, clk_rate);
> +	if (ret)
Can you add trace log with an error for geni serial driver ?> +		return ret;
> +
>   	ser_clk_cfg = SER_CLK_EN;
>   	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>   
> @@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,

[...]

