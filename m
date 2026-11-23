Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471539;
	b=s8ogDBTE8L9tWIw6+heQMF9QDcvntXbb6u86TgyWyA/kvg6kcNTqBXkhEHAvurN+sdN4
	 c3tpbvtfgqcfARqaFnded4Lom3OpnZTaSrAAm5Yi5ky5uuSgg4qnNwZ6KZUTl4U6/QmQD
	 a4vPU7durbnkOLt3RFqG0e7mF6p3ZNzXswSOT1XQSM0wknuetl6HJMx9f769hqm92ZTOv
	 +cZpwRi13eVZFR9sr7rRxOUa6aTk3W1GVnyem6w1lOpQUyr6IB/9yZe1YwWRmI1UHL9u0
	 TfiYn4GV7IGdlyGtm+AZ3lzZHk9G7WppSi9j5A5XtJT9N6yDiUPGm39GOAy5iBUm8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471539;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6Hwgz6UJp1yMR/zqjsLjAqDsdzMF2c0K1/Hbqb7QejY=;
	b=PM/889OVgYGSR10jUn98XvwieXZDt7rBGAfW/y6ymxoFowGZJSZTu7tQI94RUiAJeMQW
	 oxYACzPNyNTk4qQpz1EFMw0GQuIiGUPyHvM97+6CexqWYz6QD6Lnez/ScZV53uqBtFB0v
	 47ULw6D1cWdvMtyUSPr0QgV6lG/0zCdlMZnkd+Js683y5xtJuh6KmKQQiyH9BvOmr/NzB
	 +JdN301Onkfulhtrv2OYNFy0axttjwYpYUIBITRHX+6bKrd9233o0Dal4YwprAKQ4hJNd
	 TnxTFTUKoEAg+YX3OXEeoiC28a1g+fYbPFhddydszAV24v4gWqd2v5wxmKlOzZr+meg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="oMYk/6eC";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=glG9ihch;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36443606A32C
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36443606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oMYk/6eC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=glG9ihch
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJuQg13255327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Hwgz6UJp1yMR/zqjsLjAqDsdzMF2c0K1/Hbqb7QejY=; b=oMYk/6eCMHBpz52z
	pxjsUACx/yjdyR5Na3Y8lgC9d6C3rzIA3YPT+aq9bMLsCAaO2xsqUrCU72fK2Rpq
	ravGaf4kufhebKk+JywQbnhuzTodAk2WlM7uU0zo+pMG8nwpgONl/GZ936HeTWLD
	FXrxffHXbElvhoolh3X96ZOBorOZZNKD/vRx4eNmebmgR1MacomARN4CBT54ifi/
	7arjReUqUf+Jj9lQrS162Y/uq1Z9rbOrx13yEww+aNIguPai4M5UZ3WEdPLR6H1k
	upjPHIW0VuVeysy7hevmkjzZe51l4g8uvrtc/O9Qqt6yZJY6OP09JE2mBEVPnlbe
	zMAaIw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pbm8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:05:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so722395385a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795471538; x=1796076338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Hwgz6UJp1yMR/zqjsLjAqDsdzMF2c0K1/Hbqb7QejY=;
        b=glG9ihchTPmcxcE0GmeTZQKGCQKb5qFtNIMRDxjgYN9bu6PFDj6gOz6q9+yg9de8bD
         aFSPNGCoEVWk43jzbkuIrmvnbOZV8xM0lsAtr8O1XNo+u7YLcsTqEmXtvaMahXNWhHwj
         MhgZpfnMoTpRB4jLDQKTZEuvQwkggYfHZ6UOwmTLbqthaTNAK9PayfWbr9aJIn9Z4R4+
         +u50jPZ9nl11nT4PL09KPHXnFm2c6Pw7dlLr6OTxR8vSvQHQ5MB3hFTbnM1S4rAEQgad
         rmPru2RmO2Ip7i7EjElt7R6vGeGXNnaolt/duQ/AwJNAKShVGmjFvA2M7cQCmq+MlzPO
         e0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471538; x=1796076338;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Hwgz6UJp1yMR/zqjsLjAqDsdzMF2c0K1/Hbqb7QejY=;
        b=jC7IBuj9E+XMwepK+4LF3DSRu9d9BhNifzuIZ/7A62Yabm+2gpyLmspAhvENqPAbOj
         1UEgYzTh/SXu5YrNETbIRu+N61P39ao12XZ52fqX/BiaacF4LE/TSlwYFzfsz7KWYU5b
         VQ9NUcmBi5mXJyFBEu1hwSFdCtihsecqW37jHqI7gg6tFbMU8ttSDfkmawMwkLxorCrY
         pgxKGvUtSjD3TilTf6JAMhrefiFWjx8Bjqy40vxr9lNkh7izMalq3nHwtGRUjmSw5bpE
         i2VeI4r/vQht+J98Z1GmZlQV6DXl9LtvUSysVEI04vQfoJWKh4CNZIQECw94EEUiOgSL
         iX6g==
X-Forwarded-Encrypted: i=1; AL+hErEI2VGxsBXczln29WIYTh1bh84WEykc5cfA/BJOSWttuZvOs/E8ReVmou8uwdjdRLOQ7Pv5kDP+kg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+OH6TS94eNiMKzVGhYsz6Qe/oj2QSlenRd1RUwJJgWRYC/lneS
	Gup5uts1eE6j1oi0C6KKr0BzsdDgWDy37UuLwCG4c8dx+qNkN7GVa/rve8Y+m2xLXSvb+ywq0gF
	3SPiF9LGkf9Ksl8E4RynM1XZtxBaTqpsuaG1p5ZJJghWxB0qW3LSbM7eJpOGS5g==
X-Gm-Gg: AZFdTZeFBWjn4Y+8O7OHxUF0kIQtuf6+87gkja0RkWNmI9363RDIslK+giTTO7e5yOR
	TGpaf3MqB4l4+lldZW5iEGhehvJdOk/aOaBFGS92OGPCC3TkR8gD63d+wYVlJWNf+y4A6cMdYJU
	UnJbILi0Sdxi6Dz3bTcTR836YImvldYKh/SaoYK+a0dcQwBJ7KKtsCKB3l2aG4751jRJYzY3PZP
	PG1eXI06gAINSRtzDBIum+zLjZH4AQzHl/Iz1/tsicDinz5Cxjz3Sj8xDmyko7CfZ9wA88ssz/y
	iwTaGv/5saEXHnZW6JpWkgOa1uFlswjYwNc3F1TwPl+cFvNVPp4ReTH8mgxUUu1iNALtXYd9PKj
	lCSuz45uElB78UI2Y6J1+2hoW/EHlTcoYR3uHP1gB1zMZKRqB0gvbxuDTYiLT8Cl+7gsfJ9RyNV
	0=
X-Received: by 2002:a05:620a:4495:b0:944:dbd:8253 with SMTP id af79cd13be357-949baa03d05mr2138288685a.59.1795471537412;
        Mon, 23 Nov 2026 14:05:37 -0800 (PST)
X-Received: by 2002:a05:620a:4495:b0:944:dbd:8253 with SMTP id af79cd13be357-949baa03d05mr2138282885a.59.1795471536895;
        Mon, 23 Nov 2026 14:05:36 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm708892455e9.4.2026.11.23.14.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 14:05:35 -0800 (PST)
Message-ID: <b1c75c62-1b44-4ab4-8bc5-688762bcb8f9@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 23:05:33 +0100
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
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
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
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
 <awRA_lWAviFJj7oC@QCOM-aGQu4IUr3Y>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <awRA_lWAviFJj7oC@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfXxDweZmkPmfDx
 wJKEybe7i9/PiJMWJTs96ck2Sk9s0oTX7OoadnkdYLH68/SDm0TJUatM0rAjyIHZ8HIbb8emzlQ
 dQQb/fBN6eoy/Fbr7T5Fl0omcn1FY9arUoT8LQnt17Z+5EvEwCY2SmvLhmExe5xJukffYoDV+m+
 D3bgPpVUSWLQsGENCDXvbZXtzU4gtqCn0Nsv3tJLM29cGpf32id510TJqr5CE06b7sIbOkbT20z
 KieL9lD8NBFzASKTh2rgMhBQ7sQJ5JN7Q13iHGLDbQCY13r5lHRF2FT6GJ19GOzWDnIoKgwNUtv
 KlC66eA2JIsWaGZQKp/bvGi2GufTEZ2CcfPkANIEoopcMC3LsdBuApo+iNja9JwpZNoXM1NKLLY
 ND1YLM+Kvo8nkixiOpy2QRj7GokSHLTXB8fYFlfYqDKigWnJ4KEUTPQvU1A+qaOBloGFSjmqB5M
 PLip+liP6PQEiEdIsVw==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b04b8b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c-T1lRSgfK_BPOqrbiAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: s-it1VBQBcTuznFyyL46agkzKm6YlKAb
X-Proofpoint-ORIG-GUID: s-it1VBQBcTuznFyyL46agkzKm6YlKAb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX95ASN87qSo3J
 O5T8ADXG58EISfOSbLpbmndXqRyoRd8HWsQp7TJZ7KLjPxySFpVbYLos8IRRbIEMFyRo0oW3+nR
 TnJVYjxMpwIff85MySW3VBDHOEmsDaI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230088

On 23/11/2026 14:34, Shawn Guo wrote:
> On Sun, Nov 22, 2026 at 06:46:21PM +0100, Krzysztof Kozlowski wrote:
>> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
>> currently used only in the socinfo.c driver.  There should no and there
> 
> Same typo as in patch 1.
> 
>> is no in-tree DTS user of these, so none of these constants are really
>> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
>> that part matches the concept behind DT bindings.
>>
>> Driver have local copy of these defines, thus these can be dropped.
> 
> Nit: Drivers have local copies ...
> 

Thanks

Best regards,
Krzysztof
