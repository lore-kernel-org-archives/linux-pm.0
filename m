Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F145040F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924488; cv=none; b=PhKMK8o3x7zdADUa9uuJfVjJ9dHkuHjKM5AqaJvfRIBOu2oorYGFJjKS0EVBUIeaGl+Zg1int9KKybtFcNO8WnRM1rGp5T05eZs7hoXVXlqWz6Qxd29jaFRxF+j4U98iygq8+oiUyYChCHjFfuFerMPq8zkem7w0GGP7QGbyNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924488; c=relaxed/simple;
	bh=bDNekvoQ6EsvTgWcqctiw/kY1f4VrZJduk9j65q7Peg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBR1+/2HIz0Zcca/JPn6Ho2Wmsrzz6My0p/YaqdmcZPyGx6BdS7yXz7otUWmLo4mi2hQQVWIsniBAZCmg6dnZBbAlYe1CsfACqiQ9uZPKNWMo5cB6p8H/Lfmoq+RfDTl99kdmHevGAvuzOETdIkWVRQ8UilLBfjPFBVYmrqyAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzbakfeu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lni2AoCm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzbakfeu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lni2AoCm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDRduv2015327
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mq09nfYXa4hsmaBELAkkYMzQ/RytSt+u7hqsPGWH3WY=; b=mzbakfeu96WnXKyv
	YmK8A8WrAZ/0VYMsMxp5N91II4PY7XuHwGfHv042Gj7y/76N/BlMet0kzW8E2frj
	/1sycB+8TB8r+JOPK7PhZmMjVhIEinbouStOD4LG3Z2GKzGRaVUSLsNAa7BbSEQx
	h/PxNhLPDM5ln9jftCP8PqoOXzr1AgAfOehcQfURcKrWdVlgMu+QWP8QWsJe9cKn
	QwslOPeg8EvkxgOMXg7DYQf3FhSZKL85vJcczRE+HNHIfk/Mgu/JSe7udhgLzLbY
	7wwxOAbiwOZc1l6+C7AnkwGGXq49CQqhUcJ5tXoay9ztjeiXhgFd7+StLD8U+3ZE
	BX5o2Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9r78h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c65af4082aso18032e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924486; x=1788529286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mq09nfYXa4hsmaBELAkkYMzQ/RytSt+u7hqsPGWH3WY=;
        b=Lni2AoCmkrPCs/UTfqDk96mxjC0DLD16yghqsuVHE4b/KTOvh1Ejjrp19HXJW3hkt1
         W5QeLGJYw9Ot10lBZrjpp1w4AMDAGhGNcKFao0nEZgBKlRZsv3osG848rczLIntB/1W0
         r6ycbpN3ymiumNbZxdmHO51WVDUQiKlS2/4vHliEyj9g4ZIl8Q+oSCizmrCSKC5JB0iH
         rOafhL2p7p+hQh5J1oFYmHU63++HLhdszeZCdar9BD9T9Bw3p3oXhw61ExeZKpEUnAgZ
         9zmUTKcr7puBp3M/GbA3aSgTPTm7cAyQPe0GN9JEdU7pz0Nujgdv29B9p99LHLJqeo6f
         d6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924486; x=1788529286;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mq09nfYXa4hsmaBELAkkYMzQ/RytSt+u7hqsPGWH3WY=;
        b=LR4z+8FWZJ7xGCknRt7aEp6/+FFA/1kGiLviceapEmFsz+roqNPrB6AYs2CEzlmmzl
         L4DnmzmIW9gb38JAY0Wjmu6Y0+3ikmX8fCJJepK1j04r6Iu5XUu4R254FQFdP8GEQwzq
         mLa03I8Le1znMrs6V5fgJ6wvVN66lvghi9wKBNou2scNFwFVkWHdJ7OvWKE+XIhXkBm2
         dq8M+laH3IKg5o3MoOYjRRdtypfCbkWIDLsI6Aii+2JSE/RCgx0ifduF+7HTonSJNcdw
         5HGdKZC7K4QLpDocBs4Tx0UJ+Caj2hUFqnxV8FKg47RLFI8CaPcXrCZNfv0Zspyd6Cgk
         PoPA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1oARKMdj/zHtTps7peckZfuaGVWsQNNr947/yUl6I3GWykMNHoH+xyDn9JU3c65jg2nOKRJOjVQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kKMCc1WyWbYlt39DvpSLHh4yfGRTBTQfYgcpKS3m4lse9qsP+m
	yndbbpLGE5eDnv8lEMz/ttwKLJbRC8zlZ2jtzj+JPU7UAW9Sz6fvJfU90kCzWYpFgy+y/sbP6Ly
	ne+ZIBozbGC2KFqrRjzf8ms0HbKDFhH2e49XUDRprArU8hflmzMeVDjqxezaRNw==
X-Gm-Gg: AR+sD13QUFpdCnvGXo/LANFdm9+ExCuwvqzIeVmhNfMiG1FMwaCDaNvQsaQ51TvODT+
	EnyqcACPykR64kMH2oqeOSVDmVXFux8r9s/wlArDdHPw8CY4FRlPUK19PJjHgxx2QKIrDvVqIRk
	k6nLlt971CAoMU6aGT2zqMeJgSwdtK18QtsT4xbUUVS33W61hiI6yyBPHEQhv5BNvHnI0V+31Z0
	DbdEdEgQ6MbzVbOQ+ZvYbCLmwU6Me8OnfPXGGThXRH/vpfjhdRB7+j+zYSer10zbet1+3M5bpKD
	78v+a8ahTQELkNob64YqEkskJoIMVFoyx6p+zDGQCK27/K1s+hCX8JArdpDBQZsNzglOOfLoTcX
	/PtQqzjGmYbYeBaJxs6YouxY=
X-Received: by 2002:ac5:c89a:0:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c680ea208emr904059e0c.0.1787924485719;
        Fri, 28 Aug 2026 06:41:25 -0700 (PDT)
X-Received: by 2002:ac5:c89a:0:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c680ea208emr904033e0c.0.1787924485232;
        Fri, 28 Aug 2026 06:41:25 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a30559cfccsm3004681fa.40.2026.08.28.06.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:41:24 -0700 (PDT)
Message-ID: <7b751d60-e8f3-4e22-8495-16dbd5163add@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a919006 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX3eP+kxJQ3mKy
 wTYk5HDcDKpimo+wEQRDBKcWUMYDdvcC0f2fTY7bkrwgT/O7qgwcLO8rAGKmmGn7lcLyajW2sQl
 OGBq5nlKIY7nLHdc+PS9HFlvzVJr+s0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfXw1NQyPl41eb7
 0vxXLy6pRS4rOHYGPYBFbiHjgVZHBgYe/Wr22h84VV9K6rU++okUNKDOknRmURKhRLL4SZ0c9q/
 6BPZg9uJ1SjtPOqRdFLEnd9ZlefD5Isew8pS4PirLds0yMlkzCqHbo4ez0CUCKeB40k6pExQwuO
 r8657TvU5DfBEtmZJRwRXs5YdojDKIaXNPgJ2IWL9pOnxBtdEF2UwKCDBzmUhk4Tf0W2soZ8rw1
 OmiXmSSKLIovzAKnmwME30pIvOobVljIU447vBmHJykErKCvmWPCNLwqOfIIOMznyte3V4vXjvD
 94tNqMKZllgdE0hLte8J6tGDPfu5ggiI0BrXhyNAW9GErEEPnIlLC+9JEViBui13p+LVDItlapr
 PwhUuWoXNHWhwheQxFK9VdZ4kzED1vt7ronLPSIKxlHiN9eaLW7ji0LZgKdowDKl3qb5NzDPk7C
 Oe9TtQagoF5iBzvuFrw==
X-Proofpoint-ORIG-GUID: H4aCRKb4OpXRNIXoCtFKwHUL0UPiDvFw
X-Proofpoint-GUID: H4aCRKb4OpXRNIXoCtFKwHUL0UPiDvFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280118

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in talos.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
