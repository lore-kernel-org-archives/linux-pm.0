Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993E3B38BE
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740672; cv=none; b=DiKQ+kI8IDr+/nkPSEmM2l4X0vzE57KvJJ5SSUValNE/ysV78KvoZNdh/t8XcKr5BmPWLg/Sza3+uzerQvjEz8znR8lTOAzn75NzrppKf+BjNKKf7l+mOP8qq6+L8qwIDKonKeMxZCDQCUoaurzaXjsK6Iw7oTBGBSbas/eLmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740672; c=relaxed/simple;
	bh=HCnsPH9Um0ZG08qyr7R6UQ8BhsID58x7zuxQpv0mkBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbQp35y5ld3RnALf+yXQDJ4KavmiraYsJjqyacAGnlvRR0fH0jSTBpMIVish/cHMHutk0w+Elk4QDTYPQIH4ONHkzBtlCUIGeZ8MdmCuhZjLhsdE7irGlS0XtmH2VinUeSSrM7DAYa/F5B2uUg/bTtLGibSP+5pp/J3Y/MePVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8vjvI+h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gXGPQwci; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8vjvI+h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXGPQwci"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDObL6882178
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 14:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zg8ab/uvVlUMvrE4Dl9YaZiPUZgCfIt39bL/qT8QwzE=; b=h8vjvI+hCtyQSqIt
	/BpIsO/apRrzPDQlk6taMfJvhv0e+2LTtyQhJ2dBpADJjIxdbD0y/GuFJS0LrbW+
	FoKJfsV8X8EILUyERuC0/Wqd0rXAkdiWUofD8Rgv+3zYr9hj/VJT9JmlOVmCRFF3
	fkqI3oD5BfttQK1PDQdsru8ypfBgGAxfcgdoeWhpkmZJkqf28mjDYMcnxGX95TEu
	GfsocAtH9MBGSn0paSjoy+S879PeC+TssMZCa0r7NBGCQzskbdKPAB18/1RVP3gJ
	WBCJeTapQHNQooXcz/DnzfnEHw4jtM+OE/ISaTF5gcysKgK2BtIntePvjjWO+GBI
	U/i6dA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grwxrt9ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 14:11:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78fb9f59781so751547137.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789740669; x=1790345469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zg8ab/uvVlUMvrE4Dl9YaZiPUZgCfIt39bL/qT8QwzE=;
        b=gXGPQwciIcPsW9G/LL0nSoWntBsDMouKFB6sfLJ+CDXMc26WRqxMyIdBu6mAGEAfPk
         /qQpE48JWz9G1j80w6I40Pa2vmUqctrbwa1Xy1S+fJV52skdq/5MqqNwu9ipWr3/Uzx/
         iUKmAJpQJ33myBFcQjKG9HqBTY37m1+6fuPiXOlzXXc5cJ42xyDQvUHsslknNYKOrRhI
         rbybCwUqaToUUAZRUCACvk3bQm1k/DPT6+C4q4TIHBMme5DTuQGxu++Sys6NkZk1ugRY
         eWQoZjD7Eb6qKvOndsodwaHbef5RYNJOdDwrwF8OGpYhwfL6CJCSG0Qdl3aHuldRjsTR
         gReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740669; x=1790345469;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zg8ab/uvVlUMvrE4Dl9YaZiPUZgCfIt39bL/qT8QwzE=;
        b=uGrOxA9uSsfcPkx8F1UI84akpzZMyt/InlBuIjaddozBY8C3IBKzEUI5VtFCSvGUVn
         75IS6q5Y7HauUTqymTeZ6XTewbJ6ThBfr+W9izS0g9dWRtzsteDLwHr/fBNAe6Pipdt1
         vIJ3B4J2cXpN+DiI3RO1NkbiQQDA2O/Tz3NB/3Ddo7I3orn0oUox8wlCoUE1fD0URtnk
         bZVJHk1XigUTlAzwvIPxMrzaC9s1UQFlEg+yNNgZv40dibVUeWBikEK/TnMl/kZnP0rx
         eSIBzD/OML6kSqTUGafcpg9OG6q3wrusmTBQm0Z1y+JrU05avGr7gcVtPZ8SRPAHllEh
         HOfA==
X-Forwarded-Encrypted: i=1; AKwUvBw6d2g6vj1p312G+2bR38URTVWVGPpzoSASW7IbYbKE2Q7xqd4+EXQ1Bzxhyip03USVbxozdtC5nw==@vger.kernel.org
X-Gm-Message-State: AFuF++nLAgzGhy/XRXTx7cWK1xXXD3BFt96mE9zbCPH4DFilWxX6aLJm
	1JxuFs3e7quXTE+PNfEOoajNXDEuHDoTaY2JEU+fkWcehFAkK8uwEjOTiV9dHFVBf0LkEtVqQY5
	rLS9z3+C3Th72GyjQsB3sEc/HklaJ7dyyFXdayfjAItP+fCmb1z7vYlkeVTeOZw==
X-Gm-Gg: AYBFou1y/53bQreepOEwu/rgOgCGYmLQyykttMThds3M72eF7W2/E0OGAtZ8E4G+LWX
	/rq2xw4pj/YUJPrMSA+AgWSrRcvXOv6r839ZgRiwYH6gu55ekTyLezVUSaKnKNKRHKhnHJuUYaq
	CROux6ib2BSjRZAS4WIK4X9RUkW/aOWBtj6tbdgpIGey+eOqz7UzBMfQGQ5jl/J7VBLL9J4YoBu
	yyVsKt/cesH/8oPOxFReEFRw96t4rIYo4EEaIahOt8LIBBK+AFW2SsMNdfXY0dYs/SGVB9fXagh
	mtFZU20IxbGqUDfPaXTuoBitBNnRkivLVcdGLZpeZ3QuCsWgF0jRSmkggMEPkcmf3ScmLQpdxir
	Qlv+Vhrr7o0rsPCYKwOAoVIQQ/6jUJH2x2CkOIMfqtF7Z+tZWjqHqtwDXr2Soxgk=
X-Received: by 2002:a05:6102:8007:b0:7a1:f7d2:e817 with SMTP id ada2fe7eead31-7a55ba4d3eemr1053366137.16.1789740668688;
        Fri, 18 Sep 2026 07:11:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8007:b0:7a1:f7d2:e817 with SMTP id ada2fe7eead31-7a55ba4d3eemr1053328137.16.1789740668303;
        Fri, 18 Sep 2026 07:11:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7d1cca3sm55062285e9.11.2026.09.18.07.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 07:11:06 -0700 (PDT)
Message-ID: <b01f8d1e-353a-46d4-b52b-0f16ff63eaaf@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 16:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom,pm8775-mbg-tm: Document
 PMAU0102
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>
References: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EMWTQFZC c=1 sm=1 tr=0 ts=6aad467d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4cE7jvQ2eA2NNYLkAPgA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIwMSBTYWx0ZWRfX/hN4brGxYZNC
 BasOm7gqLGXmM5Eu8VPAZlriKRcO2HOEk+pha2Ocsib/CpO0tK/gVYpe9j5bnUdfIeuwAl/e0gF
 W9XdEAhinvwv6dd9U9dmCjO2XS8hk6oNkpFZBFvMjvVz4pECHEzC2hkwN/Thm0pRB7dgjziEqPz
 9XunYMt0W59FLX4/4mti/MgEIB1U023rjHm72Gwn5dnk7wQZTE9DGVJfnAHFiHuxh2TMbzn12mq
 HIv/jbCXYNGMcjkM89qBOMw7ZrZVW5rmYMMriImZwj/j4IXJ0/KtNTETSTpbgYL2DBrMQ9PMmMj
 ihEkt7Nn2OavUAmjOwTmkPNMxOn+NsxFZ9OeiG3ipZBUbJyY/Bq5TCsSxD6tvdyL7nOwns4ztb+
 5GknsIJwyx4ccndCoOZmITQ5hwblofuGxNUD+QKnTnXOtI2Xb/7JhUd/rfF/ex2EzNHElw18Mi+
 twISYwK8M0j9tKwLD/w==
X-Proofpoint-GUID: L1GUmCgj4WtexP3RyEMycDt4neJE2_aI
X-Proofpoint-ORIG-GUID: L1GUmCgj4WtexP3RyEMycDt4neJE2_aI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIwMSBTYWx0ZWRfX9Z7v+f+w8oEO
 chZcm1t8tYZkVMB3u3JdvnDo9q3+PwXsVY8au9ETT47qkk7tBGvZkY0c4ps8NDuH/huiOpL+9y+
 dApLShbgivOrW6Fg+hmMzUclHNpNhBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180201

On 8/30/26 12:10, Shawn Guo wrote:
> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> 
> Document MBG temperature monitor on PMAU0102 which is programming-model
> compatible with the one on PM8775.
> 
> Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Applied, thanks

