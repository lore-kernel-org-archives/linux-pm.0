Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787928;
	b=zt9FnYCmS1D5jss0tuaPQPjP7PNtQM/EfoHOjTlTT96TX2EHgoo9PmIEjqMvq5IHG7HC
	 4bK1wvXO1wPu84tpDYM57S6x+tVbTxz6VCNUWh8cAhLY4PaPabLMQS19XjDwZdVjzeEwC
	 VTO9znGV9fsorPapAX24ris49RA1HCN1YwZfl3qIdEluXZQf3BtYichankF2P8X7KY91n
	 XCnhKsrnSwfj0dfskh5LmMbQFK5lUCsorxaJhqvPU5pcs/qWJrK8d9lU3GNN+oPM16+el
	 Y2HlMk/B0639Z/4fmLZUR3zMRQ6BdjTXhQFTHoVeTXyaNnbIk4IXsJPJDc73up+qsWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787928;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
	b=ChzhwwUo+zK2quY2m1iJ7tlrXExVgVVqG6c08tq9IeodYimUAiyKClPeIBbveChjHzPo
	 UZdQIdPQO9oErRQJJMpqhua4LLqtbBnp+cbtYAyW6Q7g9u6SVo2Spy8RPOULfFAlSCFKn
	 40w17FmjfnwIREPelMcdCtkFZWdzUJe8sgy2bRn1Kmd4Yy8CFigNMrOhJ7fsLM8C+lMxe
	 irQXxxZ4bSjTKb9CuXZFflXezdyJPjVPtF8gzy9mc/H84JzjxKBwYABkLHsB/HvZZGC83
	 cfVhRLWUf5xSyjKJvXr9QUatt3xSb7AGL91P5KSGz8K6taUxDFfC5+yhr4xlEfzOljw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOjcsKcu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FORsxwKQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF25606A323
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 13:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOjcsKcu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FORsxwKQ
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARDu1KU2672249
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=; b=TOjcsKcuDkQqhKEM
	pY+66B0jBD0y+w2WuxCnqNyxwYqmtuMoZrTl0cJPLd/mTTklLplbhyMHb4TC5Wtq
	Ji2Qk2dzyLEh2cMIRuDPdYHqZpE/N6fX61D4TPWfBAqekwTKIPscpXnW+mrJEX1g
	T67dFtRLf4IjNGcPXVhIvoHFM1MztDlxyVpCMHvcXvYw2hHwPLywFmqnznbL2nOM
	sz22SEUOUEnjiVdwNO2bgpnoMVFCLggMv5jNCcGehEEubP3PBl+8lUty7whgbc4y
	8od1uEnUK+wQdjbAqIyVdpYI0rzoM6UghTNlC4hv0RttWqdHeAoj6pqD+rHn22WG
	zHDzIQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhhwth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 13:58:47 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ee4ca14454so324476e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795787926; x=1796392726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
        b=FORsxwKQO9IHATmRZuwnt/wzNKkR76nev4Im041FDN08XKsqjU4h+VVpkDoGm21N+f
         /oeDWC7HpwU5XAoQlfBoTZucLYqP2da14CrW2L7LXHltK8zA6hgd3FYjFMBJlh7gJTB+
         iD8G6N06MrZc/leeTgaSqm4ZRHGiVGyc5hvVqtkhQ6fAsP6PylP1sFZdxlR6y/biVyvP
         6suhILDhV7T7nlzNeWh9Z9G2sijUqJBTrC7KBxzn3QJYNhf6maSKO2w+9AfKYUiOWpje
         Gc72E6kLMJgBTCsCygQSVhizKDh/Je5Hnx9bL55FUerD2pHWiPV3arEFgvFuAb+dBxTF
         OYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787926; x=1796392726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
        b=lYSePj8wKBmQS8OQQ5424MTC4HvdbCHWAFbLpTxzxipaHF3rXuaQl/wFDY3SFjR3mZ
         ksk2AKPARIs69BiOve1GuYTCf+SgBhDARZoK1TSqmgP8slBShnYSDaK94qHSjBdnqgiA
         gSFruEehlywSBWeX9N3rIpseCWX3cLnxH2pF1o9xkyS20AJhZN91MAHXl3e7iVBt7iEJ
         Ry+m3aR3MTInN8+h02viVU5XRbKLD+7imXKin6UoWrmmNQm02Xf8q2JRyr4lcJzjx/BW
         n509ymjxBStUFdU1ydsTNJ9b5YtaHkLHJkgK76wQp6bX7HVebQJXhAt9kd+/2tYlA2hg
         iPvg==
X-Forwarded-Encrypted: i=1; AL+hErEnN5C1+AvWkndVVvzwpDDZ7ZtiL7TQ+lSMrvJfftQdQUhpIF1/5IpKKSsMoSlr+aMWoFDmGySETg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DTLplgJXAOvvnOYMVQUeZdGISFmtUs8hz+kQR3H9O54hflPNG
	qCgqQdWbtc5ywq7tgFzGm8Gjhkx/VmvK3zvz4xteGxjRSUaRMpR5IwUv+IxpkiBbPa2CaZdP8/M
	KGM9ybNbKgt7W7uRt7jHMCMPukwZdDlSJeHz5Sy4ej72a9Cx7SWCBn5X7k38y7w==
X-Gm-Gg: AZFdTZfm5If9s9T7HXvQD1aXcTVkLOXe1Zx0BnPMhFGkJacZ3S9bp/Na4EUDjfMmfJp
	5Mbu9hjCC+WOuTRsTGEzNWFbuv8BwxMX0tqrdrwlRJ2wtUxvpEf/JIGZN4b+FJYE6v7AEPquJCc
	yhLfeIILrYQNe/qC5f8mHFWmFQVMNYcLRST7GJYG7KVnKuwUNmKfZJ3fwpiEb2gDF/j29oLLmb6
	+LO5J//e8gqAA6NAt48pRT6YTd5umVXOHXXMqRTPbn3qWWoSZw1GVSjJla9n+REk3EkTFRBOXsp
	8igqtG3OtvvRmYnQj6PNXdePIgZXDLRY0KdVk726gavjbdUlBdC9sR9X1m/mRFg37xUVNgVkLZu
	Gg/mug4GsGv+215z3mA25doXBtydAwBgjOJACRWDLhSDhtnEEYCQ6j+pGXiybsnsl9W1TcYQ=
X-Received: by 2002:a05:6122:c2c2:10b0:5ec:b706:37e0 with SMTP id 71dfb90a1353d-5ee8ae3e277mr16434844e0c.1.1795787926287;
        Fri, 27 Nov 2026 05:58:46 -0800 (PST)
X-Received: by 2002:a05:6122:c2c2:10b0:5ec:b706:37e0 with SMTP id 71dfb90a1353d-5ee8ae3e277mr16434775e0c.1.1795787925770;
        Fri, 27 Nov 2026 05:58:45 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109b55sm10578803a12.32.2026.11.27.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:58:45 -0800 (PST)
Message-ID: <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:40 +0100
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
Subject: Re: [PATCH v3 14/14] arm64: dts: qcom: Add Samsung Galaxy XR
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
 <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX+h2W0THS8mR5
 5wPsCqXivyG4NNJ+qL1cTf7H4nlwNmVCdQLbFBO1UjPG1Svf8mquxxByezQt6/9qV1zNQBXK/Ks
 Nx/4SNgqHQuHPKRC8hc3ZFAUt/NDO1M=
X-Proofpoint-ORIG-GUID: Ne9h4nTARTDrkMDSve6JfvAKOQUatSR-
X-Proofpoint-GUID: Ne9h4nTARTDrkMDSve6JfvAKOQUatSR-
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b098c97 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pIfNyjNAQl_vEFP8Sf4A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX8Q7WlGMNA8MP
 QANwjySanMgMF5d700RgFw3IaMottSLC0taLNLYQiuUZmZ4kvKo273XJ41IJqPjd4qpTh3mdjB/
 G+/I2nhA8ekvHHME1V0aJ45Cf6nh1LEKulCjj6u/AAtPIDUm9RlWSymKYaoKFuAUgYx7vcdZJX3
 U1j0Gsu5KgJO6dsRrHO6OCB+vLFsSgod+Bf+1aGqTf6BjzHXcsGdw2rvVAXRJJxOGhmXHZXxnHg
 qr4ZjpSPHcBJ16gxhIjDMi6ECQzFu0Q/eHNpsYRtQvVuIM4lkFRmo1lSawMbcDJRGUVWpN2DeeQ
 zpDRPDgfGuyQEP2VCjn4KCeYlpKUnv8Wnup/E8Bf73U2C1OcPMUvryUuqR5WQbI+vVPo3l86Z6C
 mXRm5bTDmf6E9ewUnZnFzXtwiBE/s0olte7SyzjC4vPrGFU5GDFSVCAKjUTq7ursfwwyfsgk6yo
 qsCdjyaB2ZajR9kIMgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270055

On 11/25/26 4:43 AM, Stanislav Aleksandrov wrote:
> Add the device tree for the Samsung Galaxy XR headset, which is based on
> the Qualcomm Halliday SoC (SXR2250P).
> 
> Supported so far: the PMICs and their regulators, the power and volume
> down keys, USB in high-speed peripheral mode and UFS storage.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
