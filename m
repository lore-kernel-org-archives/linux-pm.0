Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897B389115
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334026; cv=none; b=rIyVY4lV7Oc9kaXdX0a0/QYaFDg/mplFI7WGRxBdCSSIdGZRaJ9mMc/RiSS0co3n9Xng2VKCdrBxuhQfiZfyyAtbKpchBLCcxmay/0nqTmO/LOmq0GvMqZfeoNpD/ncnkfmRtGQyie0Lqe9dte2koQ5E6I/7R7i8wU6KHKIYVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334026; c=relaxed/simple;
	bh=OvJAY+33UpQmhMQA++lwMTSQLdFQ5zwlZWNAV3YowUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpkuh7uDtaIxDuVQMvQ45e9cxazgUKy/lvDvGZTY6+jPtzXdeKqPJJpYFrjTdAnRZLyObbgUiNfEkEEwlmiJgCk7GhsuR1w34lCZ7BlG9FU1/TFllNhaLXOLRqQ++0paAJKzNJiRewM9rqgQdqajUdC5jbz7dsCN8pq5zJIqLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWd7iGqt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JkhyXvdk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWd7iGqt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JkhyXvdk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669pbSZ237498
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 10:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wKmnLti28rKW5MbWMbSFxzmp5Oz/FD7hTeYS02Q+QCk=; b=LWd7iGqtwoil4XS/
	OunbUFLO0NJh725OatDHeAMkxKovF/TOSfepDu5ASuLbCZMyOiCu3Q69ptrnNcS2
	Qdh5hjYnyUayiOFFp7IDJ1lwrFKBagd4YUDTeA8rroX+5mSrFZipq4M6bDeI4lha
	mbjlNs/Jzcveqm/gFQHWrvh0yMLeg1efmQ+856CNMr7595pu1sItZhLWmZHmcbRk
	k+5/wTr32BGlxzWsF1K4Y/8sSpDevTa7DYPW07wmw5gOsbr1gbmcgx+tRJFO96ez
	dW+0AgKtSOrxx0tFbFks4PWqV5Mi/kASFMh/yDhZUYw9e0SaNl0naaMF+YnuckmX
	p8w+iA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r05g8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 10:33:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c27616421so11129981cf.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783334023; x=1783938823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKmnLti28rKW5MbWMbSFxzmp5Oz/FD7hTeYS02Q+QCk=;
        b=JkhyXvdkqQL7C5V3dYfF+JZ9x+QjCfABZk3Z4r9sUIPAc8T2S2QWVFDWJOvq8b+7Ra
         IyE9Vdz6SHO8dqzkYsyqIIpVctyXGjJbUF/lNObmEpcf8TVRJApnouitTZK/rtklrJnZ
         dy2siEXOF97d7yEh1RZ+zJjtd4+e45raEIusbilFkOAnO+L5gBpu6rQp4cFjEN/rEIeB
         iTewRM+zf4AycxzeKjz2oPp8Jyn+CoVk4MdR2bTJrvaIUzhQ+eL6/bU0HLIoWzFtvbVC
         8Ak5AG7fJBJv9YMBnVmP4wfKvvE7Z77VXndW8v3vaBEjVCckuOlWhqhUJfos9GG1XJIz
         +CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334023; x=1783938823;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKmnLti28rKW5MbWMbSFxzmp5Oz/FD7hTeYS02Q+QCk=;
        b=Wv6xwGIX3ZS/QAnI+kvaUgBOAdUPIta99qrHE/9mR3XrW67Y2ZZYa04S5+FDTQv2wc
         U+FQ4Blme9Ez8ngj9WAx6u882o+0JIYkDMXFlJxM9TZI9ta/MauYVpyKjFEa3STa5TLL
         3m4YQqZJRiMz5wXfcCAEvHCUEmIA6TweH0nDZ2FlNzUUNjtoorZPbmkNSV1pbnUlLMbI
         UqPPeURDznH/5+hzRw2y8Xt67TU+oBEbQeqj/r/NRdsXpRuLU4+48nTur97Ha1ejd0vl
         gX+NM75rCsGBY2F8KRm/TdWV/EgwlPdMWUJKtZIILdad8+gf0prRE6MmRfPt6KmMk+UK
         ZNgg==
X-Forwarded-Encrypted: i=1; AHgh+RqKfExCEkHsoay5KQL8osyaCRT6mKQVc7zKhbq7aghe/NwjOeWLIK4cDi7GX6Bm5qaSyheZwPAy8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuOUBmv3xUkuEk0nPZkdv25Iwo9NbbEug85I6tOGZruykDieW
	H78zU79JS/mFbneod/fx+Xt9oxlyXPFD5FlNVANacqXlUo7SpDF6F7ALFPJMmWJ/eETzklyyRDb
	tWhPcAenA2tY3R4MB1pCefcxKOtQvcjG3u72lysgFJ5tdYhonWCH4LNAAM9JH1Q==
X-Gm-Gg: AfdE7ckVOeywjOMm92WSAKj8AleE8uzqbqcCULyh3x6jDq4g6Uuk0kQRbOL2OUEt3cf
	br8A9f/1dG65XrF2CTONfmpum9JAM+sQhBbBkB5AHNR+Pb+HC1aW822lyE/MGuqfGC4RKKWGEz1
	klkoz1WEW3q64dp64w84EgMhsLnj50YZnxxsIERLJxpsVuxNnHLd2bI5Dtay8+Z2Wbqw3JtFEdt
	LV4QV99ZvEF84V97YvB9nQXoFe1UC/N5xbH8pfAkhM4EAysuwa6fJlQ1Tcw2gVZzwA0/QUnmYcv
	JU+w7nta3yu2e122W0kz9zvOJ1X21majmw+QS6jdTnbGUIzsTV2PJZ0O9yoK5CTZYt2P5Lcaq9n
	WOgUemLzQeXO8aAP/cv2lTXGh3En2NXkLuVI=
X-Received: by 2002:a05:622a:82:b0:51b:ff78:f229 with SMTP id d75a77b69052e-51c4be04aeemr81020941cf.5.1783334023036;
        Mon, 06 Jul 2026 03:33:43 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51b:ff78:f229 with SMTP id d75a77b69052e-51c4be04aeemr81020731cf.5.1783334022637;
        Mon, 06 Jul 2026 03:33:42 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a3652a02asm2764065a12.11.2026.07.06.03.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:33:41 -0700 (PDT)
Message-ID: <946b97b0-6e39-44b6-b27c-fba5b6f1c859@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 12:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: Add support for Qualcomm MBG
 thermal monitoring
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
 <20260706-spmi-mbg-driver-v2-2-f883ff1d8719@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-spmi-mbg-driver-v2-2-f883ff1d8719@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNiBTYWx0ZWRfXyZBsduBgNdlr
 GNZfuFWazAqWWOPburFfrdUeOM1oehbZcBpy7Srz5gUOtD6kdpXhkPuYskDAKMUsiH/wkDUnPFF
 Pv6hePOB5+vkHRhAlNEMSIvP/wylkVQfCBH59EBFw0kjw5lCSVwhorurNeiIbPpGTyLOqQpNkdz
 kign8criZ9ucKVv6TAcvBVq4eLjlOqBWc5Brtv53lNEyjOK8MteCD5SE1oEaaVRJtBS+KghzUMz
 ywh3jbu16FfxtSW55chnyfkE1J4zXzbHfUNaSx+Lp0ulfy76/ag1X22KQ87g+jOizTotyVjQDul
 hbtdi0hzVNrN1FEHL07lCzEUEBoemcSYEv13teMkl+7D0+cyfN7bIKwhlg5Uf39cUfeQL7dQViK
 63DOk6iasAHQXQYQde6bLSiZabAG8aB1XyI/lOBciNfM3VGoHF5ujeKhlmVg3XjAXAiy2mkklg0
 /sZ9HBZi42kNeiSaLTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNiBTYWx0ZWRfXxE1PCyqprT1u
 EPkKilIkPSdOwSzbcw6/f3X+1aisOhHGLMlznlEXgN/VOi7ClrZ3OO3vfPBmpTgxAAmYMx/ZCdM
 y4TUQXR6GHm+yfG3jZoCr0dXKzQ8p7E=
X-Proofpoint-GUID: l3Q77L4LAuTXNW5T0uMgWV6jmErHcX_3
X-Proofpoint-ORIG-GUID: l3Q77L4LAuTXNW5T0uMgWV6jmErHcX_3
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4b8487 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GuqtU1ANSuNXSekCfckA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060106

On 7/6/26 10:14 AM, Sachin Gupta wrote:
> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> 
> Add driver for the Qualcomm MBG thermal monitoring device. It monitors the
> die temperature, and when there is a level 1 upper threshold violation, it
> receives an interrupt over spmi. The driver reads the fault status
> register and notifies thermal accordingly.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---

To the best of my ability:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
 
Konrad

