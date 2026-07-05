Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E236E483
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245376; cv=none; b=Yv/jRaAQ/aHCldhtjV/NhgTJWtdIXiSECMBzug0fJZ47nucA8G40SLl8ACihtSToDTNziREsGmFwghHjl0OheowAAwgRh+RY66DFhwbImCIUV9zeJQ+t6jgUkzsKr7mDfoY0oxP1FORWT+QjpgMIE5zlw9dHqqxdts/F/JOtN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245376; c=relaxed/simple;
	bh=wZydx+D7+eV35VMeFKNwwx7xhnLkiOd3Pqlp0spAh7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya3jfCKlbFZavnkYLRZDdOTRR38NW369Cki1evnUCcJaTDhhvO/T0GJcRF6VKGIF+zOPyY//2TvppR/W68FmCT1uJ51h54H/9+2Dep+WYewaDsSR4jO5GNd/pp7W/hSyTRK9Wh5ihzhhKP52MnYykuEqLHjWvS7XZ98bMiJToiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9iDBty7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CJUVZ+2u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9iDBty7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJUVZ+2u"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664NkPE4160603
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 09:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=; b=A9iDBty7BwcCDgrj
	obxijsZW+M/rwRFDYVUFQHbhkEGOAnuqZKGsmTsECOmKS0FE3CMI34EozXNGIj87
	JTJ3+8Y8fSYUulkLXd1+XCs2pLHfeinK+1WNL4mFq1N2KC9kVL50y57sCRC8q4XN
	VzR61ed9eubtEoLHSR2VMDCjwx2j0NZOHGSqc5jm5ATOdLlOl2HrwbKVldezI4mN
	lVj0om/3jtfUweFUBRWNkffYepokyQLdp2LcmIAVdmu+T3uEyyn9GDe66xY8gB4L
	LWDK26qBspZoYBUizgT6+CNvsSfK4U5EaHQqzl8JtCsj++rqQSQQwEIS5l1rHwZ2
	IOnGhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjgwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:56:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc86cab84bso5232105ad.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783245373; x=1783850173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=;
        b=CJUVZ+2uxVk/eg4IpVjDHAbXkmcXGPho8Z5LK95PS+7M1bDmO+OXc1pb59wqlGnmHA
         YzXYwkEM8fizoM+H5PjK2AUhrUHf+1MGdbokjCSEgHR06ubdDwHedw+7k1pC2fomp6tv
         bC4Lj9pwQWXDP9N0ywL04U6ZZc57ZV0qaSOUZFBTt580tmYsCk8pIu4GA/lUULyXjZFs
         pD7cpDeod7/b60SapBgI8WidB9QmswVqjlkzksPF88ARPd49O+5iiBDkzOSpllT30HZ6
         8Z7IYGsmGKRYaYh7ra6fKaCa9XYtR4WpDlZx3Lx9J9/1st4wBVq/ScRx6AwNvGdV5oDU
         F6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783245373; x=1783850173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=;
        b=tGM2xRWgxsrhMBhRJMjPoIyfpy5gvewsIWWy8k6mRbzbRJ8niIGmUg4Wpm1DxgBq05
         LufrYdYi00RAGTQQlZclr5DhJ+bQ+FUaLj1AWDLi49PJWx/UQ+1k5A6hVe4CtNZB0CS/
         B1Ua9Xll+1LPEhsni3oOjz12+XI58U6AaOwdH+SqYhuRc/4hZlOWz8lOAbvQ2g/5gLoS
         bRK8A9Bz4gHvCWmWwEQM/KKNmUFo3pHRbynkLgDHsUVFjeV2wno3DcxBDgnBXOcOPMAM
         rX2d3wWm1H6k2ZXuHhkVrWxMHIndTmvJrwRlPeG7c8oU7vrpMyVpoEknl6LbF8Ug+/Gr
         U/Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpG4Dw9Sn2gh80Liewe25diUwKwJIqmSrkPyAZTxTr9OahIohh5HgBYVd/hTtQBYOpy4M/QPS4uUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv4ukUVlMFApuW/D7y3svZ18o30lBED2TmxeDf6g2bq6/7wqh
	Z/SA6I0O5+D/qIeBs484a6/fU6yRcmeqlhV4qIZtCWoY4bU2iQJZCDGnICvuJnJ+CvfufVgFVtg
	pcGmVyU46C0qFM4Y8iPsF6+bHaTLhNmvFb7EEx65RuFJaVQ1GlcbkfPrrwREghg==
X-Gm-Gg: AfdE7cljbL5LfcX6av6kNqG6089iL9XkNNO5bVwsr0+F7GhwLaUx2kdl17WrKZKG1Pc
	xSEckx2owm1tSaQJ6KrB8dJEcVkWWEEV6beoSAheQ6GGxmCx/jD7lUcPcuAaKQJueh9GLIOhBic
	t/qJXUZKTFGeedckwmR27x1rqchEov+3X71P/87s/Xw9yNLLxn0hgP1uMgoilNR7ROGYmxA4xuG
	DYhusNy00gNS1thAZj8ntaLLb/GSF6c8RthfWNTIWaRxr8mpe2KY9CPytB/QXXd0BVu2Xcizxev
	M+s/YBaPOk/M20XphfbS2MsWQQy9BmDCEz5gO2jG59CqIv38YyeZIr1FHrj+PxbeL33/jiVe09n
	miPfui1O3x8XjRqkBlM+IB446ahYFfslQtsczwGGQjw==
X-Received: by 2002:a17:902:f78f:b0:2cc:9763:e607 with SMTP id d9443c01a7336-2cc9763eb2cmr2054045ad.27.1783245373110;
        Sun, 05 Jul 2026 02:56:13 -0700 (PDT)
X-Received: by 2002:a17:902:f78f:b0:2cc:9763:e607 with SMTP id d9443c01a7336-2cc9763eb2cmr2053695ad.27.1783245372660;
        Sun, 05 Jul 2026 02:56:12 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm60691241c88.10.2026.07.05.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 02:56:12 -0700 (PDT)
Message-ID: <6383bfc4-e193-4eaf-a44a-b9a0233068db@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:26:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] remoteproc: qcom: pas: add support for TMD
 thermal cooling devices
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-4-3882189c1f83@oss.qualcomm.com>
 <20260703-accurate-feathered-mammoth-11eaac@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-accurate-feathered-mammoth-11eaac@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a2a3e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=UwBSoYOfm8cr69mLPLIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XIBNRvbLdFNrhwbvvTeH8pZpjTBpw16Y
X-Proofpoint-GUID: XIBNRvbLdFNrhwbvvTeH8pZpjTBpw16Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfX6Sy8y+MohnWV
 /p1P+EGZ/AEmAnTWeIV+K7DlNcSY8oSpdhBNDwMiNUeKtVf0Q1pXFH8t2ANhFmHad48cejJCdVL
 Thm4gsCWhjWR70u3Djra0Z5OplMBpZk0iKpkTk4+9NKfRilebT8FcchiLHW3LmafwB8urWTbnt6
 yhb1mo549wj7mFFci/zENhGOkAP2U1nLZIDZA7ZZKDEUiXayn6fVhqLALevh0TXYOYyK9HDSSsp
 0fmq6Yjfkzpex41V7Gekx9a0i7JCMcQHWIMQEYZa9ixaWiOUp4ZOZKHIo968EKhoEEqSDD5faAY
 QkGm26z9tPkv2dgSKTtkIQHnBSnnSWHyycF9muJJKPWlxyk07uQNrzfFdXOqFKLzdGi2+fQBlKR
 qCuepMZzYBkkY9XYaiJF/AMxrT90gt/RlKxIyJ1nA5Qj/D9AT++NIL3LhP3tZnkpCrxTnc6DlDO
 kssIZVEmutPiXLkIftQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfXxvedPWkyP6jo
 nlHXiTndPAWToi/lEAe+H/Jxq00w8n2VUcAARPzRrD1C1K6KtEEqdf4m/FZqltzFmu0EAPSj0zR
 XmCkyYC5Gw92BamBIjGd+uaxRYnf81w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050101



On 7/3/2026 1:26 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:07AM +0530, Gaurav Kohli wrote:
>> +	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names, desc->num_tmd);
>> +	if (IS_ERR(tmd_inst)) {
>> +		ret = PTR_ERR(tmd_inst);
>> +		if (ret == -ENODEV)
>> +			return 0;
>> +
>> +		dev_err(pas->dev, "Failed to initialize TMD: %d\n", ret);
> 
> You already print error msg in qmi_tmd_init(), no?
> 

thanks for review, this looks redundant. will drop it.

> Is this probe path (looks like)? If so, why aren't you using
> dev_err_probe()?
> 
>> +		return ret;
>> +	}
>> +
>> +	pas->tmd_inst = tmd_inst;
>> +
>> +	return 0;
> 
> Best regards,
> Krzysztof
> 

