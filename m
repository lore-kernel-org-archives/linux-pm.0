Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF737187E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511952; cv=none; b=I0nSVLWNtjqxWk9Ppt8+kkweErINbL42bkNlIxqHlSf3ZfuSU4DCxUtnWASmu/Lgej4q0mlrKiA0MCqiua+9MxSrYm22VuOhGqp2JD4Y4hsYybywEp/Xy6N8QrUAOskoUdnsh9waXZBk8fJweU7zRt5eyYE0jIwEoxsOYAaBMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511952; c=relaxed/simple;
	bh=u8emeScZ1VxCOwdH8jxMxsFHL75wPiRAAT/6Jj7JFYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv5apKIhcKUhdRgtAZFwUkIZhu9KQy+tFdDCerOQy5GbyDKQXKDJ9l20/T/BVTTy+vlVbKtflojzNMfHXLI/twUmnRR5hbu7XDpnwRBR8Sx8UmIvlOjWreYgssOm655S0yk/ArLXBYAxDz6U3V5wByHNPhimw2mR0v1eRPalpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gp9RnXbt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a6J/2ngq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gp9RnXbt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a6J/2ngq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mpF04111314
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 08:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=; b=gp9RnXbtsidWyTJ8
	cZNY/UT2P0V+NFDYRFzz2J68xJ1rm9JcKlNlnaYAfnnHja5VKKxwyJ/NzOKJbWDW
	g6Ih3xK90ZflwVVd/BOCpP6lJI5WE2QTNagaBs1ysG4Z8GPEOyFBL6WekZmg8czJ
	4syRIeuKE1VJORmbgGnUZKEGX8WLNl9KX+Wmz4/qZuCop3uGZ5qGdPRrN0GoxpR2
	t0KE/S2LpQopgjYYpn9jVhyo4M8kzFxZd64HOQdjBJ8YAJH1peCKEAIo6Di+KW3u
	+QbCWyGj1E/0TriRNcAafN+sGTg5T+o/wLnkxOPTkDGXz2jjQiPKwb5rrK6DM4VU
	Jz3O3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b1cced-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:52:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9310484c005so12457685a.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511948; x=1789116748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=;
        b=a6J/2ngqipS9J5NCh6+sgN04+JE4IfBsdSXLB+Srv8SuIBNYWrqGWPkahMb9E/J7eg
         yPn/PxedNk0tXQb4P89otAVm8heYi+J0kZ0vf64370lMAbuvxeDOwLgTGJl5gyK3Kmxu
         dPuLbU+sehTFvNoGaCHzErH5JyyFDkSW89mAGotu8yxRP1bbju8P5vaSXqo8ZXZWvwXq
         /ldcpKPAbs43xHlGypWAcVbk729iP5mPaswCtb4V8Scl6YPeGhEy/DXgnMh7DAQOcGqC
         hCZ8VyR8sVew8EaJaC9XgHCCemqK283D7y7UQyAYQKsti7cASIsQP4LB5fkgkUZ4ceW5
         HwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511948; x=1789116748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=;
        b=DRUxJyeDuRQN6ZUt4h2rq+qh3MhJ9p/un0nTQbZpeeDS8X1gSzfXKu6iNi0Nq6Rh5G
         H5p6Nt8nq5qtA94CW7GE4MXYz7/k8hyqZsYgaD65CExmXEhBpQgU/U/Aw+vx0vLgAV6I
         LHjXF/dJcRoALjNNfFt5kL1cKbPQEa8ktqcZTgFDxtKknKHQP3+DCIAi4IGq1GG9jpBJ
         hxdpBqjSEQtsx0OpySBYpB30Vmbty1C0NIkn0yLoM1mz+aGK4Sbc+MWUD7iqeGxIC1Yy
         hGio34Q6LzCKY8osZU51/ByPIQw5b71Ub0+FeVmFdmLLv+M/mvFWD6B1Wh9maUxga6MS
         gXiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwO7vE6/g4b9W66ee/VSbOVS+nHGZonqNf9lsdISEcBYbAFe6N2a9IWA9mcj5+upGNRyJbVN87gVA==@vger.kernel.org
X-Gm-Message-State: AFuF++nC/UIqmhnrcr3oqlLM5e/ayd4cUnOUUeAETGecMYCmDsASzEGV
	Fs3qFoLRx4jHTqTeMVpY4ZKEx6d4/kB2Q8zSva037jNPN9wOpdc6uF3jAvROiN+rQfjbtC0C2mY
	lhmSKRKxjSwlu9LRtsz6JYdeJuNXhJU0hX6vOsUH2z3mCLo/EwAe7fbUAXTXeEA==
X-Gm-Gg: AYBFou3SphSXaQERDgEtH9qhhWiUltm2FK4xOavE4W1Boov8YE4SfZ2UItSkZ8YNPvZ
	rTAnVIDMDmmIIp/HrZuVSg1L1gT3gmATwYFERDXgcZ47eyMRrmRbbPIzRk88QK+iorqfFGsxzQJ
	HpR0+KU+anNZSE1d2xbfxZ1P3Q5D60AuYXqCEKhd6Qo5fF3EDy2MmmoSNl3iFaWxdflazzjcqHk
	Q/HK5Km9c9c9jhRw1s9sX6n5s42VYCTmCCf58d3VPtPMqun9vErz7nE7BflcdY9hAqbQDM3AIA2
	aJGJcebWwi01rG28HONDuXuLxaEgJRKqeQTouXRJPZBdJxm2/aILELgyCeHBp1eQGNuzSS8q9/H
	AdPYXv0zOYs5/H9P9hU77AA==
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr303194585a.1.1788511948503;
        Fri, 04 Sep 2026 01:52:28 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr303188385a.1.1788511947490;
        Fri, 04 Sep 2026 01:52:27 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b72sm76908166b.18.2026.09.04.01.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:52:26 -0700 (PDT)
Message-ID: <fdfbd73f-8739-4845-ab18-c5f59898e192@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iMyW2u58SZRR8JOAdYcPNYFwpxxUkjNm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX9PEWHs3ng+H5
 TnpFqwLOwU4FADG12VqdXL7PmUTWcenTzrNFDyfR8CH8NOHEyvQpa8kZerCoL6jeHTU/m74fSms
 ah7k0ZTt2BahHvRIk+wIi88GrzkvE0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX10cjmS7JQRGf
 kxOX1aHdlNwVLGjPYdWDdLAGlCApQXQNItSnAadYNxXsWvTkHfR9aRbcor0NK/QibczyYIxckoz
 ox307BLTCeenPXngryd7aPSVHThbbodHdhD1Xr3Y+LTWzRRjJhWqImzTiyDCI71AxheVqji4Tn1
 0+SRUMYi/7QnyyEjV8pPOXHCVgLNDyBLIjOEUJXCEV1+MFZX3vzKOcft6uyQMc9nVNwUctwLSxc
 RvdABeWFiCCheQmdF6265FgP4IM23+eU2VINQyCt8D3NYnXr5FSQgAWtlOXLf3M46gN1EAhsDIW
 GzOIgSjHX9slPzJ4ovBvaVUJUjQcCERH/sPNvH/s6wRr8yppoNlsFmUTGdeLMSJjZ6DPjaa2LrV
 bJ8sdrWb15MObq4Owip4CXmq8zvknFQd30hey5IxrRJ6ZMTh8ED6cvuhVn5C7U1WPmm5y6pOakY
 faiF61/Qqjde3ROhQ8A==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a9a86cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=eEzEi8mspgMuG-bTNdcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: iMyW2u58SZRR8JOAdYcPNYFwpxxUkjNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 8/27/26 7:59 PM, Praveen Talari wrote:
> The I2C driver currently assumes a fixed source clock selection and always
> programs SE_GENI_CLK_SEL to 0, which is not sufficient when the controller
> needs to switch between different source clocks.
> 
> Add the source clock index and frequency to the I2C clock map entries and
> use them while configuring the controller. Request the required
> source clock rate through dev_pm_opp_set_rate() and program SE_GENI_CLK_SEL
> with the matching source index.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +	dev_pm_opp_set_rate(dev, 0);

This and the below call are unnecessary, rate and enablement/disablement
of a clock are orthogonal operations

Konrad

> +
>  	return 0;
>  }
>  
> @@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
> +	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
> +		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (gi2c->dev_data->power_on) {
>  		ret = gi2c->dev_data->power_on(&gi2c->se);
>  		if (ret)
> 
