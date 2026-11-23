Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440906;
	b=GyMC9QgXMUkGsm4CgPwFnVFsuxBp8kIottj0TxtlqFfG75Pkvla+Q3wVp4fV7RpaxEHh
	 LOiRGn4pZGJWjlAUO4IFT+gQbbzF3C+n6K7wo+D+0Unsr1KC+V4MqzBOztgDOfBeQAwHA
	 HJBUsxPZwxueQO9Z/1ek51N7Co8GcvJHzgqn8OSkGq3xew7UQKSREsXK6CIvGuqJaVACi
	 UAopBAy5EVV/SHabXANO5ADy+z1wDvoSwOxsTw8UZ9EouIZYnTBqJM06f/Ht2lXqh4hUi
	 4hoKsIzh9Z/MOUKphz+7gHVq5LhWfByGJ36X91tLMh0AtlRje1g6kgBiiKCk/rJ62fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W4X+lIkpMnuBPXB5cEtedMsQlEel+NCp6hl7V/xtT3s=;
	b=ptAEhUw30OmKVBbA8aLpdhMslj9atmLfe8zs0SjSXiYxWEP//SHc+6gyMP/9RtcNArKJ
	 QoCAFUCVzBbCiKDW7rOaUFTSz207bKc8p66nGUf3sMxXg7F244j79dkRHFcloVue+vggF
	 lnkmIIhfbzlGVtZe3h5coeqd2x1RqPB28J1CGPjA86wU4nSBlYG5BhiNyRIr1nzIOCkKP
	 JKZHIiZLWwh9SwoJfmkwLpmCd9+TfKXhUa4ZrFyGZxprDXUkkipG6x5/kAExkXj0mcyIK
	 Y+gEUiboXDkkyvNGvzG1v5iCOPCgt4Uh0ABgNiRE2SNFNnr5Kvxz/N0TNuvkz3bI/yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VEFaZBcv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhkGzK6B;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B0606A31F
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F39B0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VEFaZBcv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhkGzK6B
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKxL63329337
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W4X+lIkpMnuBPXB5cEtedMsQ
	lEel+NCp6hl7V/xtT3s=; b=VEFaZBcv6QGdGPm6O/xtuaSamAgwZMZvMl+7bE4H
	kMgAoM+nduS1Hxg0u3aC/Q3I4DawmUMY4gcm5indKy0X9c9vHvhenmPBCv2DMUMz
	yc2nPqgCe2QiA5lUXX7+eO8cad3MVuxjebjLtvafW9YoMz0kGBuERs8N/Jfin4bq
	gNbxlU2t1K6GypHjoywh11oJBj4AZxiIhPCAvnjNX4yUgSfT3JiXW5zTLYTu/oGw
	jEz0eL4k0C9AQXQqy43GriIh4PWHvisZEAjof5aTNIjRMS6KyqFVP4qritTfFctp
	KWzeXnAPVlTVpEVd6S4iZY68WHVGz/sesr6gdTh7ZSxRHw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd1kb3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:35:05 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b37869f851so52820257b3.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795440904; x=1796045704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W4X+lIkpMnuBPXB5cEtedMsQlEel+NCp6hl7V/xtT3s=;
        b=hhkGzK6BXsmbaSYX5+Hcbi4s7pZ7AMQf8v6TJ/i9eXk9UMOkZIBM5Grj4hT6RQkBk7
         PRmzol2EC1MFVdKgwb3Qq+FPN3Yoaqst6q9YFW/Z1nF6nAlcT2K3Jkso6h737AyD/qzj
         uMz+MGtVx+8L/RXYHxySu5EKZ700RXpSj8rgLEVk4iXf9CDuxKYi+Rtl5sFwq9VjptO7
         DE4TSuDWeq8nsLNWqb7SiQvh2SOeZPPkR6eDV+7s7rJAsKcHPOITt8kjjQFFdN0ltNWq
         MJaOO/gWhYiE9OOYfAdm8YDH5TxE+b21vHzHQTDBssVPdvewinN9LbbnNFq2j/YesU6/
         ppiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440904; x=1796045704;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4X+lIkpMnuBPXB5cEtedMsQlEel+NCp6hl7V/xtT3s=;
        b=tXKDxUQKmgAjFSlbNyRMMIwrpUJOVNx3wZA/9u+DBwTzXNj361cdslK37+YXEulEkT
         3NmWVmhH9LVYcTUDiFMaS5pMn6ySFf14QALmtCdTwjeIpDAbKwt1s5uoUeX3qy2zJLqf
         M6Wo6qeLheiFne/v+cBDVWgSyVIopxJLHL1VUQnVnkcfJXcYWotWi6q288XndlXMWSUt
         fYfLanwVLxlPO4si4Un6jJJzD60y/1M0SkED1/wxL7VrQSX069Jrw6xOvH7cIN0ls39f
         eXok973ypyD7l18u7UpVfP3EL/J0v8lZqTTaIpZ3JDuerykqURINksCIpp3ZvmWzWC0V
         MCdA==
X-Forwarded-Encrypted: i=1; AL+hErHyclhqN0w2XFgNUhP7ufD4Hxa4OVicm0E98nd+a20DQxgfnwTOWbq8jX1b0vzkh4Yg3z35TXKEmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9W1CClnjqUQKHC+LuLy72gyFB9P+rsg5cpoKq8gy8/b42YMljw
	TL7o73a1ZQz93zOd5jRwdQ2su72uO/ATTiibS5WlDeYRiAGSRPw1sS2+scaXime9Y2h7OO90u44
	34VhPkFcr2vawdxUvBbjcxWvTexqsF/SdobppdZufZ/VOzxB4j88m3kJORxLwSw==
X-Gm-Gg: AZFdTZdLSPGG4nIsvfAicl2VCtSiw39uANBEo2OpEKi4cbt2l+l66U/8+DBBIu/8DsE
	dRb+StKIDoIsOyQELodkAwK5lxWaSWm5imhDVPOZEPbHhI6Da9AN7X1bi0GHRds6S8qTZBtqIAc
	4aRZ6EOwvUL/V6a0xfLuNeR2XEgMiFHIxW/QkcTn+KUYW4umstQX6Flj2qwc4kcCA/M+KiZAiPh
	yGH5Ed/EqBEk2vb0vYuVYPwEegs2B8LmeKzbFfPITVtFMl7SHjFjTZuWoa/A1uIp73bAetHj2Pe
	b1e5QBRkZ7cWcpSSDQ7o8dHut/ED6zzwuUi5gkfGQ5r3RwJyTgly8307k3nv6M/9YZbcAMzGnc9
	0LimeXBBUUQTayxwGMIXu3hFe63DAKoRBbwvsHCY17OuCpnOWlFgba0yXUr11yktdT4mPJdrUdQ
	vc/sWKxd2NQDc2oz5F
X-Received: by 2002:a05:690c:2a44:b0:8b2:edac:7a4c with SMTP id 00721157ae682-8b52042bedamr39514707b3.10.1795440904394;
        Mon, 23 Nov 2026 05:35:04 -0800 (PST)
X-Received: by 2002:a05:690c:2a44:b0:8b2:edac:7a4c with SMTP id 00721157ae682-8b52042bedamr39514537b3.10.1795440903970;
        Mon, 23 Nov 2026 05:35:03 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030df7bsm46300587b3.31.2026.11.23.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:35:03 -0800 (PST)
Date: Mon, 23 Nov 2026 21:34:54 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
Message-ID: <awRA_lWAviFJj7oC@QCOM-aGQu4IUr3Y>
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GMO8m7NBDEPptbL5jMbDQXtVOnnmmRiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX9qYtvRB69rR2
 gx73bQqDg12WHoPMzf+FY+Ldv7G6vCoH2BqxVkuG9nlstRkim+8eMkatAu9m8kWkJsI9e+NfMTg
 vbCSF2fZa6ZYN6w2zxGAcUWsFsykzeeS2swXpOvvGsJT1HSDDsUAsEeVS27mHR2XBbpQsg1UapK
 vMd4b4arWQcTXRUE1L10rPPrvx53ywuHKn6V1etu6mIXudQj/ib/bVUyLgk8bwAwSBIhsX2YGRv
 LgtwsMdt3XcCJTA/D3jgOp1DbwguF+cKLZDSPyGQEpl///5EJMFWK8EJT2ntO00NqaMOdrAehrB
 OMjzTlNGfLJmeJwequwVCc2EtsZWdUlriN9iiDTikF8R17SslKAK2+YO/jUAF0EkrRE1wz1Yaxa
 fdX4zLc8C6hPyUZ7RkW934YkGPB4JyJYUX9ST46al1PwV2Nj6Zv7PKrGigb0O1iZt+jITXwZpfU
 lXQJmPiADIE/1liPE/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX78OlpOEM5iJQ
 5QIVRSAmWdO7Y6f1HczZF2mGm1/uc+4ZajsVr41mh7OQUbKqdUsqrp6s5b7klHffvw4lbcdl1X8
 46pdBZmPRJlW8EhEcRIZCXBugSkR6x8=
X-Proofpoint-GUID: GMO8m7NBDEPptbL5jMbDQXtVOnnmmRiC
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b044109 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JVp1Gilkp8drtUWwDXwA:9 a=CjuIK1q_8ugA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230053

On Sun, Nov 22, 2026 at 06:46:21PM +0100, Krzysztof Kozlowski wrote:
> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
> currently used only in the socinfo.c driver.  There should no and there

Same typo as in patch 1.

> is no in-tree DTS user of these, so none of these constants are really
> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
> that part matches the concept behind DT bindings.
> 
> Driver have local copy of these defines, thus these can be dropped.

Nit: Drivers have local copies ...

Shawn

> This has no impact on in-tree ABI, but any outside users would be
> affected.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
