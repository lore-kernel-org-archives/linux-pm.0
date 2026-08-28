Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824B4657E0
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924539; cv=none; b=MjmbW1FEbgilhdCX4s0UqwfHdEq7I3BkEGU+xdnAhnaYl9q2wZEoWqF0X7+Pze4eYtYwHcqPzY8v4nbLNTHLlp8lmqM+NdaOdf4zfdcKAXDVQGBuLl/R7w09DuM3odzlXvH3md41Uss7CJkLn5CgnjJyAM2pJigHRJRwPtY5B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924539; c=relaxed/simple;
	bh=P9sorK3EnMx+N0zFoDx2cEg7M+adcYf81VKFyiOOUD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfCA//8FNZMPvz7vmN+FetU4O0gOOI8EUvnBe+35rJ496NQt45W8HxLK7DPaldkoi3J6m4VBeexw1a6riPjhQoK8C33UdtuZqdZ4LfvHfOlOaZDnhtnYF/fZ0eGxYxTydxC8pQsOkU8O26ihG/GuGrtmxJ3660o87qaZBgn9k5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bjIR71BW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g1R0KTlz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjIR71BW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g1R0KTlz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDRew62015365
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=; b=bjIR71BWu2jN0L1Q
	2i1gfAGclNEsmVZpWx+0aiEhHYb9x/QB5EWLrbxWoFON+2lCOntlsTL/rSliU5yu
	x+Korga1ywAKdsrK8/zcWWS3oqiTJnOG9Fxt89CsBUFH2AHI28RuU94b2lmmqwRr
	nyI/HQ7VfSAcUrmi1utj+zZPy48ylesDJganpz+8VulcjavQZXiN8SBeDjG1Rnre
	sS20ww6ZH7cHmhdrl8pHlvSnrDSqlWRwcOiq9xJlt9vK1kzM0PNMYDTPZwS5jesX
	RBREj9ovoo2DAzAghwSwF0RJ5GlUZRRUM8zH9Tl4CRReb4UgCZf3Cty533TqPbIb
	GSvtrQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9r7cx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:42:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d7ef17031so1103451cf.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924537; x=1788529337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=;
        b=g1R0KTlzQvKzX0R5je8vEyn/T3+oiWHHXxcw8J56xkx3Ac4kUycbs8D/MV5Evbf4uK
         ufah4ix24CCBy1IHdErbl5xWVveUsgwQfcLTH4PkDM877cJEYuLhsBuTxp+lRgR5ul6m
         56gkSjRG2+T03ufftJhiN1SRBUs2tE/ha47GQknXrsSOI+CzWd6Q5ovhX89ggXnM0jCP
         rLpPnvG3PgGsKCkI15D9PKguApiThCC402wmDZrkB2iqDylqgZH5w2iciUnnwydwGV1I
         Jif910ZcIDR42ZNNDscQlkCArqHzKYm3eYP3wGFmjQ8D5N2pkUCBMBKM2U2oyDw2W/fZ
         k69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924537; x=1788529337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=;
        b=EGNBqGHkYSPFkiIJfrLF/UTloT0t8M8JtzqNzAhPzfqmeBf9/JuV+p83RUMx9+vyMB
         +4seVDjDrDstyPad/WRuRWwRH3eprqxjAo5sNVqeCDLXrve9fek567WDFpnFsyLZTAKH
         32C8HpNYt/s5QfBFLzkcwnDWVQlV1Nm1bXLkFTUgGYYERwJDjSW5qruVTW2IPcr3Wt15
         U7SEhKpqrPbjfyV7tbKCPxx92U10Fxfx6jEHpYctiqscJWKsoDMlXcgfyg3GVWfOV3R6
         lxi6DqlBSjJ9o09IwuyByNVCzFAkQRTSoXmNUp2OnvZRJKG+iY0OZrrtYTkiutFPISsC
         CIRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9JgTEYEeQPe4UxNd8dMx+YVOJ/wMTNVXLPXOsoACTguLUMFY932hKQ5Ggya1u9bo1uVdzcEg2wQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kHqvlB7rQN5uyfPQV5eg5AEt1Yu7PDrUzQVHI23Z+HgQHYDrRX
	AjYR6B6cbp3UE/B516T+q9hGgreiIQd7XnYiHCzY22/0pufHtcXGLSC2NORWtIqZGbGqFq0wlUy
	0auFP7XQJvWJw2a0Wuni8Ggk29DROfjg6eXsl4L3Q+ozbnh7UEyzFe5B1wJOALA==
X-Gm-Gg: AR+sD13ZF2ow4wv2S7hn2Cs6qCljWTjm6KCBLTLhC+u+RjVrh38ltuMS6v71VoSE+e9
	B17cOe4BFsp4pQVjpwndL9VMOoHsIzOMeCjW8Lq+GG+HC0yoghjbXRdh4dn5pMR1BD/Ktlj20q6
	mCx7x9qnCAFzOejamojjA9bDR/ppTXgCOfGuzaqqbvTaG8R7OonIfK6bdcQbGxTaELJZ4wo6ycR
	cVrEotMgl/E4dyhVIAW5aKjerGEhw3PL6DLFzj02sLyCKvoE01FZ1EMGEyzHCsm8LHQUW2/E27N
	2noivfIzkzizdCdljrBs+Z0FQUGqQNfNbtOrqMw+ujs09sTML7RZA1sEXkR9btT9o2GdjyEST1m
	U84EQOTLlArUvF8vrXrAt/mE=
X-Received: by 2002:a05:622a:1348:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52fb961b8a4mr52111481cf.3.1787924536474;
        Fri, 28 Aug 2026 06:42:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1348:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52fb961b8a4mr52110911cf.3.1787924535956;
        Fri, 28 Aug 2026 06:42:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b5c572sm555948a12.4.2026.08.28.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:42:14 -0700 (PDT)
Message-ID: <b76cbc5f-fa84-4eef-a4de-c95ded152cc9@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
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
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-9-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-9-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a919039 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfXxwgUi2x8sM4i
 dsExSscxr0lGkKhsMZq6GtAZ1PqwM3N4jpkcTq7HCQdjlX/6JaLWiieWUCn/PIgchVImXIK3+rl
 Fq0hmblAgIFxudCtgjn2PlJ2o9h79oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX6dzZILH/pYKT
 Axc7LJmN31S6Ch5p/gBKkXlQGGUfMoevVbEjmQKq2fP9U0HLaftvn+pI/LwYm9RSIMiVab/xFmN
 bt2qfmKP/D4QvKxLruJyy7F7YVZ3d9xDLnNmm+sWX3BO0xYIfsb0blQj+SXR099y4HHFhP7xUHx
 7s+AxDtE38S2MEMOOggZF5BQ5dqbRDkbf1RAHpPXeC4tEMcKiGzmM9ZwPyG8GGx3SSpqn6cVd0k
 6jjcGpQ/8/DjZ2ZadtCHvwnQ8ca6FBAc9EBn73Ji2y+5LUUpDQz7oCUw3q9soQag8vmCVFkOdpn
 KR7A1C2pJxSqALVWPCSMqonukKPMmJ6qZ9yI9cXI/hcARnlB27yToyAMRC3cix4lDkbeLMyK3/p
 9NWs6oc1R2xDogwMsHmZQJScgRVacublPSbJuBYuaHkJl1WEnd34he/Ti8FTEtVbZP8mmtTnwcI
 gHRUaUh0qViaNOwVdrw==
X-Proofpoint-ORIG-GUID: UVRSpkoqvnieLM7SAq8RRIDvPHgMLgKF
X-Proofpoint-GUID: UVRSpkoqvnieLM7SAq8RRIDvPHgMLgKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280118

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Update the NSP passive trip thresholds to 105°C to align with the
> higher temperature specification for Hamoa IOT.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
