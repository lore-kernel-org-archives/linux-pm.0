Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E7409289
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691078; cv=none; b=tsue2AebTzll2oMUpuExZ2c4xLhSM/cCSdkhPgK9PUYkBvrR6QDHqLz1jvOMHQ0LtGzjC5HZq/D5rnrn2+OpjW4jSIxeh1SCsdM8NnFYlfLn16xDfjZJ9MtEPnhdWSjCaCZdJDAUeVQQzTx640V1qstYgr63HiCRmpycCr6KJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691078; c=relaxed/simple;
	bh=0mz3qJv0BDahOMHl4Qms0ZQnz0C2OdkzNWbTMJy9x1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdebjbEK8Bn2PFfPVxi8pH9xOPml9fWDP/yXC04EMAgIYj638TPWsAOfvYOsLWlEsJqriFbl5uKTINP4fW0HmHIkmsL2kb1lAcDFLfcFBymsaNnrFbpzk8GBhsARtD47zKOxNeTIwJHt2I/nZaClMCgYCpQ0fg8OkkNlumZBomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo2UR+/H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dNl5qxFH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo2UR+/H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dNl5qxFH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6bhp730326
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BajnQZ9UnlDgGNW46b/qmQ3nKKqo2dqOPhzq4QZBTBo=; b=bo2UR+/HPVjPOrD/
	fSVhw+Lz0XugpoOGYKugMdE89cXqjG49tK76ooDKuCz+kHyV7g18+NJdeHDGzP6d
	PTLTVKe4+vbIaTyzNbfISQsX3wrHehOlnxqMoMwCvETKwr8GgAn5J0c2Shj291Mx
	AnZ9H2dDDeUF8saWiDNqay/vCdZrPV2ioZEPN1v2q7RrUj8G7QNG2bkmStpL9la0
	Ft2PjJdPSSF2FgGSqqyyojeCLvKDC1VdAZDuQnc0Yp1JT8b+AxIs+VAunY5lKkgz
	6I59jdEsrRCnVl3cWBhOuW7zjbt/+ZnlvPu1Da0FJvKNgy1Zyk3wKYYXevd22vJJ
	xnop8w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24vftb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:44:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8fd356ee3a4so2849256d6.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691076; x=1784295876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BajnQZ9UnlDgGNW46b/qmQ3nKKqo2dqOPhzq4QZBTBo=;
        b=dNl5qxFHRN/Fk6w21Hi5Mzrl2yOO1WbRRscSnce8o2rvxtS80YLQRN9CP1tAX2YDy+
         gWIj1jiJfMCLbVZ71jI8Qmxz69eVwnkVNq7PEQD6T+u3VMAI9utl3+wRZEg+5BCu4z5n
         2JFJPzO5GZAnXNf43ZVPmtIdkcSfvh2rV5lTXBF7t8VZytcLexdlzda3dAr1NBr1GLfn
         lt27IruF9PvmYktINZvQJp90mer6j4PKDE9YG+QMTJQohJQq63qDtvcTPacP3jo4ydbH
         6Fc/KSsXSutHvC9pO0PEbxnzDC6Fep+h5Rx06tcxy/J3/sY9GtXQgPOb64eJiAy6BB6/
         4uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691076; x=1784295876;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BajnQZ9UnlDgGNW46b/qmQ3nKKqo2dqOPhzq4QZBTBo=;
        b=oEjb4sGP/B8McfANHs3nUonzeC3nhe4GvBn2i4yPVsl1PP3rirQ33JtBD5OwzW36YY
         XlK0zkgyd0XZcCjet6TTwLrvqBKyVPS288COTPVdRjjB3qELdnonwAmubOCxOJk4wlR/
         hCN30Q/s7BnUMjGCUVmQcJzNcsA6gg6/vHHKpFuQt6e8xToloaXZ6fYc2tU1p4hWvnpU
         jeg5kdoFKKqgS1b03++iud16AwQ5OA3ZdT4J1qrmeHQmMavkSs0q6iro1tjeMN2cEiZ8
         2hL4J54Gj14TO1pf4/fSBoRB26uQcvMothsCzas5PKwfYCZhuWmVS76sl5+JBBpFEZhG
         1EFg==
X-Forwarded-Encrypted: i=1; AHgh+RrEG+id2C1J6sxnJIgxMgotSMpg+6XKqWt3z8tLlMBNuRDEMOvidtFeHyInabI8+zhvG+rtxxizXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMBV4h5Quwjj7oc5hYzlUzeAobBkzCGpI7xAngbxLyTHZUHfS
	p3819S45vTFihFuVqau8J9c9bbjcgjVfuVOBAoPVwhncCFL3EvXVMojuTHaKoeF2ZOQ2pEpXBkW
	w52vhWd4mMY9/AcPefduIPeXgsjEek3Ju6W3fX01H72HRKstVpolrFfnCRrLrBg==
X-Gm-Gg: AfdE7ckeeBG85tQlx7et5zOwnRQ6G9QehWUHNwzIJNfQ6dNQu9CRbT3R3P8qiqloNH7
	BbYbkL8eqKp+1laktsfLCJcrdUUh5XMpNZkmZFVvTV0Ch4x44whUdWLBY3ovX6eBejP9ePWZvAs
	62FM3tCNtXnaBghCSzvfa+k02iuA7oVY1ct7dW4fACtsOpI8tBs8P3UcSfRXt7ROkaf3s8zPFPc
	R/EUXkvVy2XGTlrTzALtoRUhRJ4rCvwk+pytlRjRpvIZnfGWwRJeG8bykigWqsbOHMHem75T1Rj
	RV8S5V93pbFvGLhrWK7UN1LMI4H9izXBQzUCYkVVQM7d2QHTH7UMpZLrjRZG69W7jX5dCPYD97T
	xqu773W0azJChBLxxOCc2pmHRpGUPAHP/jMY=
X-Received: by 2002:a05:6214:1d0c:b0:8fd:80cc:e9ad with SMTP id 6a1803df08f44-8fec7355228mr108739696d6.6.1783691075641;
        Fri, 10 Jul 2026 06:44:35 -0700 (PDT)
X-Received: by 2002:a05:6214:1d0c:b0:8fd:80cc:e9ad with SMTP id 6a1803df08f44-8fec7355228mr108739326d6.6.1783691074996;
        Fri, 10 Jul 2026 06:44:34 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd3e06d6sm3254661a12.26.2026.07.10.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:44:33 -0700 (PDT)
Message-ID: <bf766035-54fa-4e98-8abe-22cf0a229ffa@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: milos: add OSM L3 node
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
 <20260710-milos-cpu-opp-v1-2-ae7f4b09bc77@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-milos-cpu-opp-v1-2-ae7f4b09bc77@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4i-itj-h2cSditk1vLooxlX8s-GBCEHV
X-Proofpoint-ORIG-GUID: 4i-itj-h2cSditk1vLooxlX8s-GBCEHV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX6N/AOhY7kERL
 mp/5VXYgucsEBnCrJHLMP+N/7qzC3/KgxZZB85sBlk42NHDPAN2d9/VrBWNwcP6oR+VhR64lR7a
 STC3pClc5n/F3ZJqZb7J6Kt2Jb9gB2c=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50f744 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6H0WHjuAAAAA:8 a=75QiWgRGdHY30H_rKSEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfXx/bVnvGjVHxc
 W0bndqskKhMS4lmN9QZcALifBqy3/RlG+DS/q9cFWWJR0m8uIghF0tZwsfV0VqrY2CAMP7+n8BK
 CAq/OvAeYnSrH89m8GD8EgMykXXCX9afsrLU1KHScpVPQYzBjf5ZlgeE/rGP9ePaW7Y78ikVBMj
 0CqIULeawThnjy3Mkvj1RLqXRKHR6RUf1B9/O1IReFQlj63SZqn8aI7+Hma5hYm4zzhES7g8wg3
 EZuUzrqq8Y9TZ9ru7I+JI6Qm05kGHWNb3flxy5kjbD6i750hFaXl14ksVYM/+f5JVWkqMe/hfPs
 +yCVEKlDCta/cm8X86kkDeX1WxX1kllpThIajbz42606BTxno1gJJPSJ/SJLCgs4wCkI+qKhQ6H
 8QNT7APwNunb1CC5uwdWJvFZ1ZLSLPMHUUz5P1EOrenoG1rNhMDxwc/y1Vw5YXOtNlURkFPS912
 dcJDCrI3IA3WRCKEGUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100136

On 7/10/26 11:22 AM, Luca Weiss wrote:
> Add the OSC L3 Cache controller node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

I'd suggest to squash this series into 1 big patch, without patch
3 applied the OSM driver will engage and perform sync_state (with
0 requests, so it will vote for 0/lowest) and the system
performance will be tragic

Konrad
