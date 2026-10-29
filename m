Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269441;
	b=Kk9iiljDmlZDvixBoH73MsVWgVY6eBAm0ikHD/Dm5BfW+8dc9u6A/sLX950r88hKN9yP
	 NgPFXyCSC+hcP0Gwm3chQwmGOiodVOHKP53Ax57kF57DI4KPEAQMks/Dr7y9j2jSGq181
	 IuXQLwCbFi9R7dwnRCIz1xyRy81IVFuKGojTRKE2uDNvv6I88mdqWPf1dYWP9LI9ZMPke
	 5NGCK4C9DVrRf/PMW5LHur6CktQZDIhTWPEebN7f49wM5EDALzKN2p0UAvQ/OfuOqSdhU
	 Fngsxe/eRFsspB1bHWiATVKFQw3wx95scdnNezK+7ui+hs9IKEm5dXzhBtnr97hT0ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269441;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3jMmmstpkrevEgYUZTyeGz93R6TCogBufcXjsgslU68=;
	b=W0W5M5IAZfK/KedALHpHQDJEY2j2EDejDd9H+ubXmUFt4wpXmT32KkjGQ+oDu4VfxAh2
	 k4EFFgTdpcL2FKTRyhbSHS1lPnMv6R5kIDs5ehSXjnCGv79RlmSbCCtud3HNOvruFCm/E
	 6NCKhgqSkksNUrUbc7yUDNICrAK2bc9ByCbGun2HHE1pwABo92XM9XuUt9iyy1DpbRI3s
	 NxGbgoIa4bOQNrqVW4I8t7VF59YlwKJxkO5JM0afm58zMdAUHpYVKvHedAIuCtAUiswBy
	 eU6zz86y7/1NMyC8hRLHPHK6ldXGB1APHFNMLajEt9+JskU0KonyR3KIws7MIGdIoiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CR+jw9IK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RsBvD7Ew;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8F606A31C
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CR+jw9IK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RsBvD7Ew
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TA3jFL3607069
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3jMmmstpkrevEgYUZTyeGz93
	R6TCogBufcXjsgslU68=; b=CR+jw9IKD8EvIIAOhBteoElscKIOWIfZ5np7FCjz
	ZwGrfTXKkp/KbFTepG/F/6pbw2dCYuUTenFxBavW/t0UqbI4DPzgpU08ITwpHE9I
	vtRCkDk77kqubMta6GOEN7sj0JIe1cAakJSzlv6JvvRf6LMToswOlJIJFPspJTF+
	i0X8O2OJvXKaqDwfOuPo+LSvqmZ+VLmiJOkDQ67bLLR+vs9ZpNVeGUJsk/5uxrpl
	bwRK/b50n1tObp7F2uba2Ce7P1K0aDQfw178cYRtmSLSVBHKjDd/wDZbPPYHHA4P
	aZzUeP9WcI/jal/eiFFP5VqvmegsiosLFlCf91WfczXnGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fg2b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:23:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c5ab5c136so298945885a.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269439; x=1793874239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3jMmmstpkrevEgYUZTyeGz93R6TCogBufcXjsgslU68=;
        b=RsBvD7EwzM3faihsTviiqWjI2Am0g1HHWB020McugFXvfdwJ3fvR2MbhsGf15mx3KV
         uXe36StxuIK7o3wXsNWHfUM307id8oeradrAuYRDZueVZPbngTKotdEI/oHhwHy68heU
         qTwD/3ToOsaIk2JeVzL5WiD0iEerPrqti78GlBiDUSnYyGxoq7ecsb/z4Zj4j4LGlXhZ
         q+iA4JnsiP54W8jrJOiG76AbuS62ztgcfPiYBUHnHdLS/X5DDX5h1d710GySDy3bQzKV
         rMr9ocqgGantr6CODiksUKsZMOjPZxf9pYmr1p3C1Gm3jhdKwUVCv7dg8N8hMHLdOaWO
         7pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269439; x=1793874239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jMmmstpkrevEgYUZTyeGz93R6TCogBufcXjsgslU68=;
        b=gOpAMQEjLpyQ8BKlw2roGEc4oXHOz7c+a64ULU71yIzX+F7cXYp1ZQaA0LxnqZ9+Ak
         Fes8MBC+Op32reIxy5lncS1eiZTV2XMAstbENtVXx4oEzWQKdPqVDvzpzEbIaZF9GYZt
         j4vYSEM+sORQ1M443JBu+vC+WMIhYYgHierPxMGypf39x50PAewAIzk5/Kqht9iaKsMu
         VKcsrHRQFt5NkUO4GnYjHMY7r8HzaA7pEdtxREi2RcqOw5thpLqx6+SqbTJnohjoJwpQ
         ixCTjDuE0DMdvJEOe0nHau/FK4Am9U3eRbq7Sbf+cRgbnFQ5EidNhTb0ry1GEShPU10b
         L09A==
X-Forwarded-Encrypted: i=1; AKwUvBxviYBtZzip2y3lk3hABTe1BUSQDaplstE3lE0NT23/JebyjYuJ22F15R1HRTYflm1J6odmI7LBdA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsUIzRJYikXvCIIIWdF4DfnW49bAbvDhUEH662zyD8Zgjmli/A
	o1jA6dx9AMb8KDDc4ijMWcWA53GJ+UzX6GI/tKYYli4qrmx2oQIMXJTiufvALVf6ukdt0/+jX1W
	IBgWWAwW2swicKE3Xzkg7gL2oZparXKITE4bOuMa0Ug2Yexegolr8dwy1In3CCw==
X-Gm-Gg: AYBFou2d0f6UNzvCKJ0zOiY9R6FlIKIiRh10Xo+GNBCG+nSm2H5spC1/oQtXNGl4TK3
	6l6CvF37oNBred8N/dWRCns1PZ2drJ/HjZVexHevREAjejz4zK3mx3mGBzzaLIUIyiWDcivly0B
	gZ5l1v3s8+xO9Bnq/kXel4QW47kTTSu5OleqkLNo5YaY1liPjyEdLSPOR3iy2q9eb7W9zABYOA0
	zU05gOsNSvvKAT6BkNyfZGNNP5PjFpxoXFNaKN9gavpWSZZkX1MVej9kppeOvG4Q3zveiqNGRvQ
	4unk4YeQMt5fIzxGPtFnDKcawwE7vAJCDwzOpbvKd6RlLNidBwpArQ7XP+XiXGauE2TTKHXeaL9
	VV7bCGrH41erDWSDfPe30R6cMDSbr4hE/7mJlm0xCz0EM7GUCeQMJLFrtpZehS12Q
X-Received: by 2002:a05:620a:28d0:b0:93f:2b65:f47 with SMTP id af79cd13be357-94408cb5c69mr730114685a.25.1793269438989;
        Thu, 29 Oct 2026 03:23:58 -0700 (PDT)
X-Received: by 2002:a05:620a:28d0:b0:93f:2b65:f47 with SMTP id af79cd13be357-94408cb5c69mr730109985a.25.1793269438371;
        Thu, 29 Oct 2026 03:23:58 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm12399755e9.12.2026.10.29.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:23:57 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:23:54 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v27 08/10] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
Message-ID: <337wsyqgnma3l6xi3xarj3ed5wwxweuf45vq3k64igjgufszlj@gnb4zg3j27ml>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-8-fa4b3ff1359b@oss.qualcomm.com>
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
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-8-fa4b3ff1359b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX0XuKIwdHdpBQ
 RIX64Eh+PiwhQhl+ple43NIh7TBZSRjcQc+Oz4FXdoo77Kqmb1llQUyG1vA4aiyakYY/+m4VT3M
 COe8YdYy8hpMAd03skL5CaPNIbT3ghQDpykgh2iCuS44eFKNh0bNjf4FNi0iPZMsD+vMkHm3xgb
 m25YrHe2pk41mQmDxfAXGRzmna4SkJyWeCsbALAs40/2bn38bnAvL6T/2hrjsy88jnT3EsKXUae
 mFQOFaW0EixuIjgkyUYd8QJWaEW2JZF8KNngmHbLsyBZ7Crp6WQur+cx6zsBNwJlqMEdkGNoOk8
 22Ohws89Df5VZYjvxplHzOE5M46t8jMyaoHgMBgSOvERdskTzhVAOV8lBIgVL2BlCbv+Lnt/VT4
 aNw4cK7yKIvuLfV5NupEIEabI9RqS9lbxTOftYkVL0BqQfKUx2wXkKimuzY3nVxWjE6Ur4WBI9L
 S7viHGxUoPdQ6vUurhg==
X-Proofpoint-GUID: pCT0Zieoe_-K7qRark_TdUCan7tNzocG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX5jy3TTFQMHLb
 tUKvE/PjN8Bkx8fpN0nCHr1RRS/Htfj9Hyos0xAMiW1vjgGDg2dH32q6LYJQ0qvA5wS2EWHnj4F
 n47CtMYYexkqYP5ME8WVSB0F4ksGMQs=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae31ebf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=shUxFSsEnBkLoNWfsCEA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: pCT0Zieoe_-K7qRark_TdUCan7tNzocG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290040

On 26-10-29 14:31:02, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for lemans-evk and
> lemans-ride-common(sa8775p-ride, sa8775p-ride-r3, qcs9100-ride,
> qcs9100-ride-r3) for use by the psci-reboot-mode driver.
> 
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
> 
> Support for these modes is firmware dependent.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
