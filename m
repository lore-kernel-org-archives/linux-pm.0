Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471740;
	b=lGCom4CwRclsdQZBDWg7OqNTlNZJ0kTNg20tFt4jVX0p/iqFzLYkO7d1yGE9EKdRShy/
	 vBGtcPV8I3kpmDK8jcu+zLGSQEUAWP8oweKtCvS+pNgCI+d31rEKJkVUfoVqZ5TyXNTrp
	 fU7CCKwa2NhX7zNuuugJqNgY+ZW/HRJVeoao89wwPIW3aCRXRMqDKVZ1rBjRYo7m7jVVs
	 aXzTfm5cUluhpnAM52r3mbZkrSG3+Fu3jJPhUHstoiBi54f9OfQ2I0H7qdKMjKToN06KR
	 mArnVeSQx/QPRdRtWYwLgPBoiw+LMXQ3korWYORvrZq3eZKW5qfcC7H7Pm894n8aoRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471740;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jO0jfM6XRLgagT8aMcVQmvm0DCRJ2+e7pbdmqZkT1eE=;
	b=nlAzOKkD1woSdZDP22ZBWwWnsK0G9+fnqvlI71k5wTsoJiqUMekC/+StqdzHjQWfV5dy
	 cwE1PkzeACYBVHe+2H2M8RADlg7wpuaaJV6ziL8//LE7vH/maDp4XXNgWC5kIw4w45Zqt
	 GTEtXhhwGPRp6Jetb3XhXbvHwfp+qCG7wnVEPPGsKCRiYIH/dHu8D3NPtRAJ3mDqqBoe6
	 S/gpz7wVPkkr8UBc2w1uZRJJIphf0DSnIOOSLQXIyCOJs5zKueV4dYMVDX1PT9/FNyAsb
	 O4Esyv7HW158D2l5HHpXoUhFU9OYsMSYIQus11i41iDtVrdIhocPsfv3/oAposUyD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5fen8zl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RBGsNBcN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568C606A32A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6568C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5fen8zl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RBGsNBcN
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJuSRW1332567
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jO0jfM6XRLgagT8aMcVQmvm0DCRJ2+e7pbdmqZkT1eE=; b=S5fen8zlThJ6oL5v
	9XBb0bL0KtRCHm2GWxYG65Ef8xgZXSabe55j7G517UjzDE4GwEwHVTg9NuooKp2A
	cCfM+ywFd8syQ+XDtTJnvgMGWfIem3WDxbUWsajAJAvUAuj79copV80rurNKFavT
	YE3/pfA/DzJ40PPzbqGWEBQXRoKcsXKCZLfZYLNE3Y3Ebdkc1iqR+Hh3+rZGpeS6
	fxqlNHkwgUGFgD7/9Aaub8KdNk08GrMxMXj8tchQsnt0LtuJqbGF/yVmeGxCMAMa
	SihGfuybYwqntjlPuXjOrZLb6dVRigcmNMhKlM3keJFWv94c/zBohRAl3dYUyLzn
	ObNeDw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g743pme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:08:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9493e89d4f9so561555385a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795471738; x=1796076538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jO0jfM6XRLgagT8aMcVQmvm0DCRJ2+e7pbdmqZkT1eE=;
        b=RBGsNBcN76qmS7r4S1c29hJaGFHmEcIU3PAsxQTcEKZtt4fs2cu02ft2Fkok1yw8cv
         jfxMx9M3IWwgu/vPErLDB81+N/e3fyQYWxDu3Orpl96ZiDJI+WEpfX5EFkMhOCYevYgB
         k10tjdNBXid2/oJeZm+Br4BYUjVMaMI7Adb21rQgM/TPxAaWt7nYSvanSZLgZiYeXpIW
         tOLZt0uBo9J7VgEli6udcckDGHR8M4ncEJRxsSVoRG4uVL2bU+G40Tu6VXscHSsGwLJi
         FgecoYqS5yPp6qFDxuqfj9iN1sQOyl+p9AYrwe9dSC9N25gXnZu42iBbPBvsHaFDTC6e
         8L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471738; x=1796076538;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jO0jfM6XRLgagT8aMcVQmvm0DCRJ2+e7pbdmqZkT1eE=;
        b=GVNEVNHPkVmHoRrke3jLOuJaIQg7Wcsbv0L4CE9Pjek6ItpnuXXNkXHWVz5cres1iW
         SeaaFO1+SzWpBE82ri5BfrqgYn4Mq1y5y1LvsPQkLYMjNNJXnA/ISyEroCntLYwoVRPx
         EkxXSWcuLwd6PGwFw+gHzDeI3m8YQYKhzmpoFUPKB+RjlEMTii/69732d+sVJYRd4UvQ
         DAfKHP8+s6RBWftmzJPyhiZJBvBL18gsehql2UyhqEiz+PzsZbstZcRStqDjcaOQeh8p
         dprrsmoTHUjAViGU4NTuRKOSSTO9pPJJevvzc4pwod4XLpT2MISdanglYwPoDfvUp1QJ
         g94w==
X-Forwarded-Encrypted: i=1; AL+hErFDdzskq+C5A3YC7zecEkLfo8XuKJ+hd93OxgRpLW8psWvklF2yl9rsoxG9lDGTFPQzj/Ug84a18g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Eqtr7BIvsJI2y1NxNXMDRmzFViBGOFFStf8q5YRbFhLrslMtk
	DIm83n7Hz8rd9eYSCdrVHIlqRFWSp0+eyJ8hu0fXti8a8M3kNzfXVbTFHeQeAjfGDcKHLNfIMQ8
	k1S0FmBbluNzUFVgO9qEserVVgfS7hoWigdFw/hPtIaUMuKFszpccBeS5I9kMQw==
X-Gm-Gg: AZFdTZfBJcRE7G7Y1h88+Gm9+tMMrT7cRKi5w/n+y0PMwdDFiBK+zFFunZ6V7l6GlU8
	jUE2kZcuSnHqZ9JU2pGBofVYwB7yujSyutgsqsgZf7ul50EuiJKFory/XiV5WIYszJ58kb54yCb
	VqTHe4GP8lHpjbgLFBhioJDNpyyMpUU1T542LWg/xlbCRMIzGh3hxz2ITeOohwlo3y/nK4sL1aY
	vJRUeiFrEVC06AQBBqmQtOOVord/zasvpPVfB68Q/JUnyIn9ctUEvCRuvcGPL/I1IHIFCRLFz10
	EmRzVwjjjN84MQbBV7ElLvBKa9p6ndF27bv8ORuq5ZnncvPt19wTiqagXAvkPtQcC1I+0Y20IQJ
	0ecA9rAq0I/PncNShzHxyJpp93MFDcl/DkM/Xir7FpCco7v4fuggl3dk4LVPkSKXCrHhTozT2Lx
	4=
X-Received: by 2002:a05:620a:2585:b0:949:727a:44e8 with SMTP id af79cd13be357-949ba9e6390mr2297185085a.35.1795471738511;
        Mon, 23 Nov 2026 14:08:58 -0800 (PST)
X-Received: by 2002:a05:620a:2585:b0:949:727a:44e8 with SMTP id af79cd13be357-949ba9e6390mr2297181685a.35.1795471738048;
        Mon, 23 Nov 2026 14:08:58 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm561786005e9.13.2026.11.23.14.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 14:08:57 -0800 (PST)
Message-ID: <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 23:08:55 +0100
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
Subject: Re: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
 <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
 <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
 <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: csVIidQzQT95J8xbnheBwV7jd3B7PBpp
X-Proofpoint-ORIG-GUID: csVIidQzQT95J8xbnheBwV7jd3B7PBpp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfXxUYl5ucIA3Dk
 /nMgazMa8V76JgDCbefL8KTnzAwQ2y6RLrOSpe2mKflBqQGqgTPxRYc8NQgDqMr79HX6M7ejyzb
 hMvxw2uem+ajdbXFVBlDq9tFjsgGQQc=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b04b97b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-8XAt7TJbku-FhjSX4IA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfXyzePXD0pHs0R
 h9fntrhGRi7BIa89SAU6wN2Cj1HwbqrQwIWEF8Hp8vhfwkn9XvohIQ5tyELVciGnl687Dqclu5k
 PfNmDn9nvByXxCev3IhcLalMbzMi2hsRKuQRH8nLLPZIQ1MVojBzblyGVMlRFHBvlmpadYNMAA7
 yMCXY3AB1lNKkiOVurwoJmERwhnSJ5tgXyHjPiggF0DqtbnM1WzuBM4nJ4u0+mLGFHaBFl/J2my
 5f4ttz/wIIUbRlo7h61ShgE4dhyns3nNmp7B/eKyQitxV/ggrmc/zdpCkflVfu/ApGhXp/KwfRe
 baOlkQmgR7+irwLaXwPTB9nC9vVK5SiXjl7CnlzBP+fWaG2FI5xfJifbtSx/qrmZntT8zhvDCYC
 rzKgZI3Y1b2fA0f3/zaalXKYm1tQRz/Udo1RuhkYyKbmFiin/GKY4dVBQkn3yZHtWEVK3odFGPD
 7qMtyNsandbPUhWGVdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230088

On 23/11/2026 20:06, Konrad Dybcio wrote:
> On 11/23/26 4:22 PM, Krzysztof Kozlowski wrote:
>> On 23/11/2026 16:17, Konrad Dybcio wrote:
>>> On 11/22/26 6:46 PM, Krzysztof Kozlowski wrote:
>>>> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
>>>> currently used only in the socinfo.c driver.  There should no and there
>>>> is no in-tree DTS user of these, so none of these constants are really
>>>> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
>>>> that part matches the concept behind DT bindings.
>>>>
>>>> Driver have local copy of these defines, thus these can be dropped.
>>>> This has no impact on in-tree ABI, but any outside users would be
>>>> affected.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>> ---
>>>
>>> I think we can move it altogether, to prevent a situation where one has
>>
>> We cannot move all, because some are actual ABI. I could try to leave
>> these ones only, but that's a bit too much work, IMO, that's why I cut
>> everything at ~450 value of ID.
> 
> If you mean ABI as in "used in DTS", I don't think that's quite ABI
> (again, looking at the glymur-ipcc.h case)


True, not ABI in meaning something agreed between DTS and driver, but
the values are used by bootloader, DTS and the driver, so I would just
leave them as is. I rather care about not growing this for newer platforms.


Best regards,
Krzysztof
