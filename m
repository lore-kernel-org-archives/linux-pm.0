Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D538D41C
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588174; cv=none; b=lvWw+SHOdghqkp/W/xyP/y1crVHUGbT3PgkfKNOayPUKHqYOwCIrw1isrvPloNMckikI+bhVeNhDdXoqx6Cl3EuL4YIaw5qEz6lmANoWi5fIgnw4KZ2Wtz3LI39bNFZ04TwdLT6W3eDx9JneH+oJ+J3AQ/fxAAUT/yXwUsG0ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588174; c=relaxed/simple;
	bh=WJbj0VUbTJOIHsU/qG51gaTf4+FZ6AkK+zLqDSQueH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6NGobziOC1YCJPlFRUecR2JGTrtLYztFKMaghxkgvNY5z6c051i34fpPAbHcH/oX5jtd4VgQN5C0Gmpc66XZ5PNVfXl4aJgeWs4QSrXKEIHd4hTYis4+Vrpr14iX/c0Xm6K4ch6FpeXFXIJbWSgbj9COpK7XjFcUaqvVqoMVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVNhecLq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zto1N+Kf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVNhecLq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zto1N+Kf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB04qm2573888
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2MDoLVE56Y2SNVjDTt2clQoJLy4r8ALPLSko4jH/grc=; b=SVNhecLqJKHYixPe
	HP9mg1XwGcFFWuidg9YrFgr0QKRdMIUGAxBWHzGYHv6c8RYuwaqV5PDtRTY4vOOV
	BLAHMrXula6NAxYJnAQSkr0WO9b2ybOlhW0ehZVOlTQfU+q3bjXO9PZB9RUqjPNa
	xJ+efA2tv8lt4Hb6CVgXbfpqQ+b67xPu86aVNEjTtY1uLMFoEkMnaZwZa6NRJKLb
	GyIpO1FR4T6M7MBgnUtAPNY/MK+XWL3cUnNwu5Tg11lgNqVklk405rGLnH+/eRI9
	JdU86OemfhukfNavZXypt9sxADOTq2NDSZ97X4rp8306oJdYgLkOgZCLLLAt2Pc1
	/oUXwQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2b7nf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:16:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eb04e1b499so125895485a.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778588172; x=1779192972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MDoLVE56Y2SNVjDTt2clQoJLy4r8ALPLSko4jH/grc=;
        b=Zto1N+Kfkj14liplHojzeoDWsHzVsoaJUOgkuN3Tgj2LrnK/Ubk3+pY+K2YRfIdhSy
         aMHcWfgtZlgNcgTedG4BosyO7/tYhmrE6yzBADHSOt/EQd9iMVuWTXM2OuxJQNpTaMQI
         GovBb2kU/PoR7+bVNU5KR2ys//3wrlre7C0F5+zTSYZXfC89VIH5tyrU+uy5Pz0eotkb
         6QCuds/34SiNvwuD4lxSAEQH+ImMBGtkw1bnlXCynsVrdIZbzRkBqBiL5a4oWasSgSCY
         KIbypXZkOX7Ydj5A2EblBc7N2Dh2YnnAYgIyorfLCLKta7GUmHtJovQo+ZrWU0fKIuG3
         65mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588172; x=1779192972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MDoLVE56Y2SNVjDTt2clQoJLy4r8ALPLSko4jH/grc=;
        b=k6U5sy2OQCjGbiu6QgB054Kncjs+kcTQZ9NbN2ffHN1iO9oceBAdev4Y2FWDOy+CYC
         uguZH+ogheHDTP3E3/oVVV70m/dNBsrFEP2K4/DcLMu3sFOTJVreR4KSka5ow9954Uo+
         nLdnsrrl/xjQG7IVOHMOcmHeTaEzIOGlqmJoT7fXnmtGHXvMAHFZ1P98xbqJiyRZrv+Y
         cYvsZ1btzEKyXqShk8qgTeCNO+KOBrCKl6rJMIqtMuulYLdm1WyhfcKfuI5ZvARMdbNj
         da2viJbgeDE0yN9Cwjfx9hvJJxE0bQ+M7+CM5VTxxssFWkb9NPVhs8kZ3aIftCrhR15v
         +11A==
X-Forwarded-Encrypted: i=1; AFNElJ8OK4JAVI+uZJ3TuI9pIXugNlygu2pyaWXv0RVws86roHFZ9F0ngeZzA5IU0k393rwuHafWkZlvnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqN8MilwpSA96hs53O+4mbIhwxmdqPkzO3OxDfuHRUIOqamT1
	63Wlf6inI/1KMGgtoD1ZXzXUg9WiVUejqGomISoBVkzVVW2ZsNlUgiwmoghHyxNeiRaoCkVqtNV
	SxK/9jWsSnD3uSoGfHNuWxBF7CkL2UWGUylAhPEiVFVz15yZqI8fB46YAlOPyVQ==
X-Gm-Gg: Acq92OEX2hOZyij8yK7/UgNmO1wFh4yQTLb5imf4wNHNEiiM4kSGRjc+3+t4dIPoVQf
	ahe8Mc6xOANTY3ShDFyrSgJgGKKohz1bnAkJXmq7gyfTjwTEvroADbK3+5/JZChEq6o5KcV1wO7
	6sUeWbIkF2/txkfpCWT6YWgTp4DKChbwVgtWvZos+JgOLSX2lj4/gsgBReVv9vVF2dUWjW/dmwq
	eeC2/6wizfSsaYyaNsXGhq6tyUFjrMjcOrwin4Jqd4jwjKVlaxJ8Nht1C/P1AQnkpiybphOEzVK
	282EUUZzUsCRol6P16h8lzsbuFeprfVz4L2Juc0gcPCylVww9FTFZUZyRn6dbcbtqhTlg1ZQeAa
	eOgyUeln0B5/CXNLZ8WTTGuWNTI5ncFBt+jtvE+bBAGpGThbH+Iz5HrUkq2JX+zuvDxASbi88M9
	gytFk=
X-Received: by 2002:a05:620a:2894:b0:8fa:1f2c:c9a6 with SMTP id af79cd13be357-904de2998c4mr2750327085a.3.1778588171641;
        Tue, 12 May 2026 05:16:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2894:b0:8fa:1f2c:c9a6 with SMTP id af79cd13be357-904de2998c4mr2750323285a.3.1778588171091;
        Tue, 12 May 2026 05:16:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67f7d2b204fsm3850056a12.3.2026.05.12.05.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 05:16:10 -0700 (PDT)
Message-ID: <e032c072-57b3-44b4-84a7-5aff062b9c00@oss.qualcomm.com>
Date: Tue, 12 May 2026 14:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
 <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IsAutr/g c=1 sm=1 tr=0 ts=6a031a0c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XoaxEQdo0zjKg4FK9Y0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: W0yTqxz9W1eusTsoUOPrMYhRfo8Ce5Qw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNyBTYWx0ZWRfX0cP1JIlRerAz
 VKHJIr/Xb3znIbAT87jOofxyIwYsDBw9xR2tcGzf4op1tR/k0TcYdw8SagwfKmuNegKLjFZW5MO
 4nscfXDy0LeZgs9oszjOvboRIXna/GAydPjZPWIhzFBg18iSXtevrxn77TqtZeS4jYfnoQjKc75
 XQ6Zkyy0HQAifUCXQLkAUotHC5gdYtLLw7qJ47PyOiIeNBupeNlxZ3VHXfNuCZKAqKuESZvjH6M
 uMhHBboWrt1+uJGpe1qXtktgBtC71Cfa0XZRPkA9ARPqTs2IAFXX6+waRXAKH5ypNdnsl5hLfk/
 nISobV7CHOuHfyNsq9p8/ZT7BOOo1rqbmJWKOc5okB/80qkuQyYA5MKtzMtIRnMH3teOHB3uY+l
 M2X7/e3gjEp4ebu1zMVBYmqSZySXSogkl71vb7QPxNUA1m3iKyqhooI6QNME0sbGK769475IcwB
 DdYmIzWPVnbRjRYdbRg==
X-Proofpoint-ORIG-GUID: W0yTqxz9W1eusTsoUOPrMYhRfo8Ce5Qw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120127

On 4/29/26 4:09 PM, Rakesh Kota wrote:
> Add RPM Power Domains support for the Shikra platform.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> index 15a11ff282c3f86b1e86c6604d165e297620f6cf..6f751ee5a7833912d54d2bcfd5d85837ab7a97d3 100644
> --- a/drivers/pmdomain/qcom/rpmpd.c
> +++ b/drivers/pmdomain/qcom/rpmpd.c
> @@ -863,6 +863,21 @@ static const struct rpmpd_desc sdm660_desc = {
>  	.max_state = RPM_SMD_LEVEL_TURBO,
>  };
>  
> +static struct rpmpd *shikra_rpmpds[] = {
> +	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
> +	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
> +	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
> +	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
> +	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
> +	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
> +};

This is identical to sm6125_rpmpds. If you're sure the list is correct
and complete (no LPI domains etc.), you can drop this patch, and proceed
with just this change:

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0bf1e13a9964..e7d9e8e65641 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -73,6 +73,10 @@ properties:
           - enum:
               - qcom,msm8937-rpmpd
           - const: qcom,msm8917-rpmpd
+      - items:
+          - enum:
+              - qcom,shikra-rpmpd
+          - const: qcom,sm6125-rpmpd
 
   '#power-domain-cells':
     const: 1


Konrad
