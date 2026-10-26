Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020328;
	b=Ks+XU3pf+2zH2sB/yuraQ8PsxyXxuBkxkCYnKvJ98JSzYLieF1bhFrPJWH8bDsnhCya3
	 8tqr4zSX7UDTvok2j+Ni+nQPBVzT0J/+9tBNVxttD/rkePUUQEBJlo6p51SgJen0LU1ns
	 YH9ZEX8VNyAyw8F14s4qg9kemv/uXfiFp3LWI/xjaRL4UH01CXhICRFeC4HISTEcrb/da
	 3qFE8L5wteds4llgZ9E298n983FaSkrM5BIn6NySvXMA/AYX08GTNOQgeYHX2GGOAZVa2
	 9WKXGvVRtyTwYLKxpqtF7Q9p44ZjfrcaADTv/BlBbL0vfBwpgqkdAfFpQJLUOddr2BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2+R0WVc8dxQdKiFF2JNsjD/7q81uf0HwLq4bflyvK/4=;
	b=LfAsympMIWvkA7n5EFRg5GXkelvMp8A/Dg9dRthr0kt3vnwpYsUhownsL+wh56GsMShI
	 btqF0Ii3Guceh2QLnBq0MGfdIlgqtD/iVmXGh5t9Y1rZDbSCM5xkwgdLP14G/a0gHBhhB
	 9XjWmOxAhjDW/rks3zTOI+gY/k7AhbI33xEOuQS750ZYbHdXuI/ngGV6kGkopJB06Mb2G
	 TwowtUzqIOmd6BG1oreJlP6iJHzrDrIHO8eZqaR+0ycxs7f4kilQYyjRchjfquRcCSxTU
	 XnbL0RTXp18L+1sGh/WHWm9EgUHc8zddnGkH/iqISs3KFHzjXLJFZ6/LerS2GB7vjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AMKFgxSe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwO3z7rc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AC606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 13:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AMKFgxSe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwO3z7rc
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtBNa3050171
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 13:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+R0WVc8dxQdKiFF2JNsjD/7q81uf0HwLq4bflyvK/4=; b=AMKFgxSeuegHHZN8
	YrT7ACUt4stSsxsEmR90KoI/4kYGEMrx0EEbKStDk+nT3aWJ379akLCm44Gy5MLa
	xd2wBglGKOnnpfoSNI7DZb+EfSvwZf6KAUpb8spcbhZX3QRKhqXecACR1bS5nVKD
	bRX+9GJq8kdiPygSOYZYB5hTFn0meW65G9iATJO7fJAxd+PnPVaHz9VOihUx6DrR
	ZTyqWR3H3Un6NSp7kHKJSvIt+JeATgIN/NXC0LzNfbJbHqLSHtZbvxy8gYZtOXSi
	rOcfHQSENP9Q0u452Km/53tCim9tRTy5PmyPuLgLS7PRDbxbh4tIG5tasth5V5BA
	s+RD+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdda92y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 13:12:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ea8a9cfe6so89115885a.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793020326; x=1793625126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+R0WVc8dxQdKiFF2JNsjD/7q81uf0HwLq4bflyvK/4=;
        b=QwO3z7rctoZyNVb77UyM7lmsLgdXdgja7Y11/samwFYMM4FSAgKMbppDigG+O5t/8c
         xckpr+yVvY8GOeMKhiQn6VpllR/mPIgHfAkTF5w3oMIO+/TwrkSedjbUjcwdcRpzyBTA
         /hbgATueUXcMrZ4OkQ6f/0VqxojRNTIownqld6Sf6swvYDGOqaMLLQQZ//DCRac0Geqm
         H/RlgiTp/Q8xDxjAvcJInxlI1KyHn5dqn60G+KEBEZZA5vYf6ifhr0tMYXdsYog08xzp
         FENnCpLp5wL8JI3MCeDYx1EITZD+03+wafxwy8T1otjzPacPePLMMtjOAvuQcoRt+KX1
         sAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793020326; x=1793625126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+R0WVc8dxQdKiFF2JNsjD/7q81uf0HwLq4bflyvK/4=;
        b=U9jdse4o1iac6JDJjtUsjClhrktPA6NkrHO8WKgtiCGjFMLgJ58VbWrmKQyasjAIrx
         z4cwMIDfWakqy4q8PcQcg2ar8MaYcykeoMBdte8FiQuH+HJcSSz1/cL3cJjU+KaJvcZd
         u/LDsDIe0xonp4mLiWnJJpeOlLmt/2qcMVWRRS60WImmpUpvYL3DmR8xIfoaMYKot0WI
         lgeg6WyFRbgwmd6PVZZBhZz43uf7f+297ZiLDX0nxMcBkRkvChWU7x+uE94uPsxFDpYH
         tRR7S6QAdhXTTvdjFfWWwNnapDkymMKLQtNz7lWTZ8MCrSjkGuenH5PRiOg5yq3cQlnm
         5rdw==
X-Forwarded-Encrypted: i=1; AKwUvBzPgVqFpyaY8s74QAGkO3c6xh58qN7TApxe12J8Jytkccb+KosUEqatMnOphYYGmH7k+TF+vQH4Hw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmqvbUN+TKgT6g3OEqSDiKboPPMxj2Xo6wa0xGK3dym2AytHJA
	2IETUW00XWq722AAxS45Hafb2q0Zx/DYhMWiMAppkn0SNL8eeV2fveU959bz4S8O04PB5Fho5LE
	JIftwmzQU+CbkN4qNzavs4rLjVN67adNLWTnaUZ2hgU+/y5GiOcONLP7FlW0WdQ==
X-Gm-Gg: AYBFou2KjDdBGylzjuA7POwAKZ65eUtjDpiHphEDn63Ju2nxDz1a3VjBtlFaFSBrzLz
	2AWkGJIJZSIvbCFcmnkt3oUggFAE62OohVKkTp3V8zi6UxNBghBV7yAVt07jLYnNF7xNZKonFsv
	c3s0qRzkw9M0uv8xnWhEJ2cTl9Mer/d+qWsI0bkPWl0KudoengDs/fFzlQs+hR0QBWP4THCeEOz
	NcJIvvmKV+EMfrn2mcuMZNYmuranREf31MLRHdbEqBu3Yvpp/V9NYNsCdSdWa279wGOYxocTrzU
	ybGE9k/rCVmtrQXwYXRDdxW6yAZXk8Pori1rqq0wJpby+IaVoNyAIZpnl1OzVZrP1Ged0OXQXUJ
	kiCvc6YGGGwxgOb7VTTK0qQ==
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-940ef9710femr1205343785a.6.1793020326027;
        Mon, 26 Oct 2026 06:12:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-940ef9710femr1205338785a.6.1793020325533;
        Mon, 26 Oct 2026 06:12:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445984c99sm3707047a12.28.2026.10.26.06.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 06:12:04 -0700 (PDT)
Message-ID: <f0ca2bd4-851e-473d-bf21-678cf964f854@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:11:58 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/16] clk: Acquire resources for clock transitions
To: Jerome Brunet <jbrunet@baylibre.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-2-3041b788e9f7@oss.qualcomm.com>
 <179275170360.4070168.11650113664838519061.b4-review@b4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179275170360.4070168.11650113664838519061.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4JD8ggLUYn2absx5XC3DNUjELzkijJoH
X-Proofpoint-GUID: 4JD8ggLUYn2absx5XC3DNUjELzkijJoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfXyZk2DUs8Tmwd
 CkPpTAzb/lp1thTCPx7AVo3Z7N5m0cWKW/w//1RirZ9xXwS3iWWu3rucqwMRZSAAA49CF/xIX6r
 h0Jt+FIFwVYulS7O80kvnyxR5WwlrmSzvVWSysMNv+6/awrW4FHDLIGx/66vDYoVfn+4QFwvK+c
 WFstpUMfVts9fL1qK207WyGskei92BP+MPYAI9TSTlGJyf49YKUp0FyaNUqDmAR0mZC1ndpBzEH
 EvOt3MKgfMTnKmX0EBI6e37NQcNBLvm5heXcBRGtJTBwaw+7h20DoIQB9by2FI4xoTnuqxBqbuY
 AkTENZ1pnwOJlqlyX8F1TUy62MRxG729rcT9WupZFkwavvp91Y0gYKjDy+KEo6a82HJ/7o22qiR
 Kvflo/cdPigj1rjueGqVayhY5UPLcVTx8XJWLbX50gqe89SmdEeeJfHnssLmV0jL2BHtEatgqsD
 oJtVdKQBVWuIw7ovHtg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf51a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Hc6wbZxCDKPXCg-kSLUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX0RC3kLPdSrKP
 /ewVoFHcon3uGNjBMibdUiE+iq1EOvsNeauB4pJgXCPRHsdu1FUB6TLAqn8qqDo+Uyj9QoZJ5aY
 48tr6b09el7H8KVyLovONnAPTj5RmoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260052

On 10/23/26 12:35 PM, Jerome Brunet wrote:
>> Preparing a clock protects its current requirements, not the resources
>> needed while changing its rate or parent. A transition can temporarily
>> use both parents or access an unprepared clock, and a parent rate change
>> can cause other clocks to be programmed too. Raising resources one clock
>> at a time leaves those operations exposed to insufficient power.
>>
>> Failures make this worse: hardware may already have changed when the
>> operation returns an error. A matching cached rate is then not proof
>> that resource reconciliation finished. Retaining a temporary enable
>> reference without a corresponding prepare reference also breaks a
>> consumer's normal disable/unprepare sequence after a failed reparent.
>>
>> Make CCF acquire the affected tree's and parent paths' resources before
>> notifiers or programming, and reconcile them only when the walk stops.
>> Keep fault recovery independent of rate shortcuts and subsequent
>> consumer reference-count changes. Require explicit recovery of an
>> ancestor's uncertain parent selection rather than reporting success
>> from a descendant request.
> 
> I don't think all this is necessary to address the problem described
> here and in the cover letter.
> 
> IMO a new provider API is the wrong layer. The framework already has
> the hook a provider needs: the rate change notifiers. What the core
> should do instead is fix those notifiers, which do have a few issues.
> You are fixing one in patch 1. Another fix, about setting the parent,
> was sent recently:
> 
> https://patchwork.kernel.org/project/linux-clk/patch/20261021-submit-clk-parent-abort-v1-v1-1-2936181822fc@gmail.com/
> 
> You want to act on some changes before anything is programmed. PRE
> notifiers are the right tool for this. The user of this change in
> patch 7 could use them AFAICT: PRE sets a temporary vote, POST settles
> it, ABORT drops it.
> 
> Also, what is acquired here follows the requested clock. When an
> ancestor switches parent, the chain of its new parent is not acquired,
> although it feeds the whole subtree after the switch.
> 
> With notifiers, the parent fault state is not needed either. As it is,
> it blocks every request on or below the clock until the same switch is
> retried.
> 
> Could you tell me what you need from this approach that cannot be done
> with (fixed) notifiers?

I'm a little worried about the ordering there, since some device
drivers may also be registering listeners in parallel, so we don't
get a clean split of what PRE means ("has power for sure " or "may
not have power")

Konrad
