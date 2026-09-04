Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738863AA504
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511792; cv=none; b=tmvxdRQSMJuH027vSsSAhfrMJhzS4J6v7b9PRRl/8S7O52B3MsoDMr88208bygsvTyGipqSV71gtYLCOoOy69DBTuClmhl6zfwmVM+OVjEnl9zYQnyO5sFhDPZbLR2ibcfQq1IQAC3mxnkb/j7Pl98yIy63ulCaNMGldMOwH3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511792; c=relaxed/simple;
	bh=i5WV/wG5Dqysz3kgPy8ahQVJUTCnfA7qqWTM0oCKVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TD32yeTQY6AjQ97tgRGHWPcJ43GPUiwBm9sQerrY3YyJyrJnFuOf8gguH1RsLk6joRc5EFAo5ptPWdv3RAsHEMFtRbvMxMz28snzaswdCZVZM7WWmxuzt7mijaOXnPgYFOt/ZlKQeQowPcoVaE3+qOU74G7l/OeXMz+zfiGiNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3rY66/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJC0pqY0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rY66/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJC0pqY0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mpLf2430019
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 08:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=; b=L3rY66/ZPsUMtp1m
	yZ5+t8eehR1pILzku+yzJTRv9c8fPHtBIRhJAtktnQcepeykDJVJPP9dFR2egT22
	WMOXcRbe7Va+vtP5a2Tw5XvojiVIYPLjk+2ee/Q+6MSvITBw/WKAjdD3LvXvVF26
	LHt+lhPazQ0+TsN/VttyPFw27t8eLdEf22Tlki6wwUyZl3ujIeNXuPW7NsMR+17k
	RBztDGxY7tL+s/J3A3kCF348jxqh5vXyDwFaa4WQ+fHJXk80JFxJ/g66dtXvCviO
	mvoG7dfdtvdRnFPa8nMAyyN5Din8JuJqzFYNdbhOwTPy2doKvYdhxWwtaGTwxuOy
	WGtymA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfk921esa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:49:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930bd2bfc45so13753685a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511790; x=1789116590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=ZJC0pqY03lNzU1bS5U2QmJ43xCEZkGhJoFLhlCtmUuci2T5nrM5Syaim0tOEgEyL9y
         h5PgqpWtQH99ohsps2z4Dz7LISjT4Av18GH9g0LX8rMMQQ8dKtEOgWtUZOeRCDOW53jo
         8Gn73ejHn5YZUMspBhEzZHQUeO6+A+ltWCKwCdYtkZREvoZ3LXHuqzbvLUfAMKWKd1Rj
         HPG4TpV5P6Cn6pRsgIwDAJU8u/kCj2Dlf9z2jA2tMQ2bxNVewzIUYLjrEsY9u4v6f4/5
         WMKY3s1mlItWGdffdfNn6Whbui2hIT83V8fTfFcxh9QKcA5EHd12N/snvqzdA/CieXdi
         i/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511790; x=1789116590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=JFU48pN65eWPoatperU5agUmG9PMYgARgQ0h2eaNbAhgd5DQcsZEORpLA3+xYJGYzs
         UW7BWVN2vxovDubfcs/C5YMJJBSlBZzJw0VJTA570c/YZ5J+eeS9ayuywrCD0f/3hoW7
         8Z7QP7rNBxFTgHGh0nybP6BLgGxY5Pk+Az7GqLNK25vFtvJcP/FHh6881wM6X7YFXRtt
         6WgksbIilMc7AWA6HKLeQC2RbpTrtrRxW3usacXFB/ue9XdGMbmgjCmJ7cYJURs3TC1a
         0obgdAvJkkK32BGncrDpKbPog3SWEBxwnEdgWQXAC1mZiRjg8q1gTysUf0DKkcWJei5a
         oEJw==
X-Forwarded-Encrypted: i=1; AKwUvByrE2PqMZp5pHm3c0WUnyayEXcaDUEDYLNTWHMOH4MvmLqF7RKn3pQeEodGSrjAmsfU4OFwZ58q0g==@vger.kernel.org
X-Gm-Message-State: AFuF++kzOC58qIgkVanAY+B45MENEWiyiyRd1kPThShTG9wTxJtQYDGu
	15t7ulsQPszSTBQNGT5gMDcEwv6cJFB1s6IAIwm9V28bOKXBUPXyif8Vue0Z9rvYol2JZFzAeeN
	g8S8MDEHdZHGHJkT2c1WJFsvY9ZWtY+WPYe4+JNl22WbpGV144weHV+9gQVNHRg==
X-Gm-Gg: AYBFou06IbbWZSAt/cQyvoL7Fa1FECv20XYPjDwJ37OiiQ7q7FgUGY9oufoTvJVwD1V
	/Lx7tG2eUs3uUBmYfoHBOL/dHtlcB8CKlYU0S4ayKc9x8WqIdKmg/cy9FalWz2JfSsMGI9a5Uaj
	gRZbm9C7n6ugjBR6zBCEzz79c4xHWYWf5piglVJVKXJXeplW0zQsD9yvqsffHy+vjWwHJD3OAes
	OVjcHMI3MCA1xndlbofASYMvLU+IkX/pTIk3ew/wVZYgakjcp71tyNjjPu8dgUK093j+FZEfH0w
	JS8vcPnywwfcCq85v0BeTICLvOyVSLjloeCwBfAWSwSLNRRfp3sWUbu3yIFAg2iaQtM4J8PeFW2
	YSRJ59c3aojwCu/Th+R1kDQ==
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146196185a.6.1788511789691;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146194685a.6.1788511789302;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6a1dsm867795a12.7.2026.09.04.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:49:47 -0700 (PDT)
Message-ID: <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:44 +0200
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX4d2FMXRVXobF
 kqdEtnjSx9FXqpCJD68gBE/PcdpaPUdOtjlWg9zW0TTNxcpSJ3qGPMg7mCZ7ylxYRwxQ9PrUd0b
 HkTgmnflopgDBSiGrJCt5f5bHYFzoiwgnueZ6Asn/i3aipLBXSGAQXC7QRNiXA+pDl33l7z8+X7
 xJKuOwwLb5GU39S8b/cYiJbUD0jWKfK+BTaXe32ExX2wPdSHT4fMb1CiTZlKUPT2vfb8xU4w2Iw
 8MAOPkClfPLt9h6p3RPl19q3Z1h3joz5lUCZ0nCZmMP90j0wVAR3g8W8Q8NSilvUMf361e0gGSP
 mJnQLOc8RC6d1xeSJXOLbE2iKciGbAFtn4lnCS2JCQw9hJ8a0obcfZ5hkNafM7ePz788eWpIZPJ
 /lFRz9YhRgziestBnjcINwpb1fJVaensTpxlmBx+o/eNZEAi5pSK7dHIKMyG9xVQNfZjlmZ5jxo
 aKwpso2WnJq+1lb/X7g==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=6a9a862e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: olZi7CTj0BHVK1psWDaTpN3NkSzkCHvO
X-Proofpoint-GUID: olZi7CTj0BHVK1psWDaTpN3NkSzkCHvO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfXx9ncukvZUpI2
 KZHDoyrGXK/KmcCPR8izR12Gj87w8awZsCpHpfwmWXj0qk1ZfvMBLOKY8s8rTuGrXgvpvh+hwdr
 Ps1T4Qw/ipXxMi+gUmPeX28iZUhQ9oo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040080

On 8/27/26 7:59 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.

I believe the opposite was the original intent behind creating
these helpers..

> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.

That is, on the other hand, a valid reason

Konrad
