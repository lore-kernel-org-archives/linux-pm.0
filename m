Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F248F02C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992383; cv=none; b=pieWNjZ2KLq3TUbr1aoN2HgGuQqNNmcAf3mRlxhVQJ0b4NI0LpbmTwmQJbOiBxsZy8f+ydnKMRYGPafnD5MJDS9rZKMedqh7pONPJlsxXJa7auAN6Rl4LyTDZMfpVBBYC2gQgrEdi6gQFt2B6fCz39AfC2VAI8udmi0onDoPkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992383; c=relaxed/simple;
	bh=Rq9k78Hw50DGEQapoZ0Fu0uAEkGTaCUtUw4bB3S2jiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+TJa4CDKVtaW0V1zgzNNs/siQxsAH3piQ591ibhrvfUJ2yYZtUtAC6t6BgRSvHNv/fzCCwtRuJLoCp6PyCGN6X72sk//uBtjMm1Jt09/btE1JOtJ1+wO6QxT31sbglbCNijJ0F3//t6UlUV9CqiJD8/fRf5tt8oKVhtP3FdFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOF/aFdM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmAr+/VE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOF/aFdM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmAr+/VE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeBJh419379
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z/ovgnuW/wTtPaDP5nRj/+YS
	TMBMRF3XYoJTwvSFZTw=; b=nOF/aFdMwFB5tAlQ8DjnZNKmGJ3IjZXda4w8wBes
	UZpbUqpZ1oOxNq8aZb2HhwtmnpHZlFZzJQEOGQjhR+paXY2aXPGbYWw6nr87WVCW
	t8HtlCvHjepDf3z8Bkn9jU/8wqSlVuDDjWnVKNcr+QUVHQwvWhDJR+qIeFT3B+8U
	+xkvFK0UxSykzDUaR01GS31A8ceevGrcsCAsdbKPBqWOVthHP9VK1b4qPgR4hPDB
	K/NPb48v81P2wX4IADLt+61aPVZi9MjoUNCTiMDWOtcmpmDjY/z4G3maJ+inbcrH
	WlK+CyOoBE/uMHU80CHdZONS0AkXjUKMKTX4qmYAciJJTw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq9586-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806535f8ffso3167574241.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992380; x=1790597180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/ovgnuW/wTtPaDP5nRj/+YSTMBMRF3XYoJTwvSFZTw=;
        b=XmAr+/VEIYRiUcCdxkeG/E5tsd7HX4l6MSpU1/pKw0AKet7thz84kJAEUIG8y8MQA0
         Czso+BCZBZ9mG27tVuoQBBcVcjsSc4OLe0QfiPr3DpREjg6b0H326gH9qIBQyUI0WgVV
         AZj7V1E2dx0xLRG2maUFtIBqVXx8qntT5n25T2lxQOLTBnviPZ8yGjnC2hM21JI7TP0F
         6xwVyWye7E9APmp1vPuvGocOwYyW+QWurhRF3LOi/4AqlMGe1CYT0a+JfohxMJkqJrO2
         UFt20+ninhVKRpjT92CIxQP4odavkV0eqhBSjj2drLRB+5bbVrASC5+jEwjWq3RC0ND2
         1hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992380; x=1790597180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/ovgnuW/wTtPaDP5nRj/+YSTMBMRF3XYoJTwvSFZTw=;
        b=XtULfoyHDVzfa3AzR0aEtPJfRIvVxcU1FU4640MzDbB/ip+eJg/8ZXQ9kI+JM2CSaw
         ch3eYWqiMnwKZWD4wqM9m1EOX/+GYletQamS5z7uuTY6GgJcZsLdhX+z6T3TqHgauG4f
         J2QLd+FLFK4VegLutXtNcNEH8QIW4YJNsiUc+ubrkWz/EPkNZ7XB4VHPOmQLfU2diYBM
         Bf0Vy/ARyn4D3v+mAz7IXoVHahP4TauAtukZdXNOSs9VARSJdqOw4gZHRZy59j2zHfDo
         hTVTWvHqfHz7XseuqyvXsCJ+ekW+AO9sPaQq9D90QZMsFiDLa7WoFSbcY+mLtaaBKh5a
         qpcg==
X-Forwarded-Encrypted: i=1; AKwUvBx81TNRpkbChfqTea2cBG8FUDf5OIli9xBZTPWfJ+I9cMpTgc0IyHHKUUtE3sPLZ4XKy/Z98ThMdw==@vger.kernel.org
X-Gm-Message-State: AFuF++m52BGe58p1JY9M2/mZpMBRbtU6BPx8JOg9UxiS2QqZ+XaHM+W6
	kUKY1lxGEuiC6Z+iGfxd9GxUoKVk+siSCMTwSv1HcvKJfD/UYabNrb/igjK70aQVimqwnoTgCOH
	TFnBQsk3b4N6J9RUT8EjmtEfe/eIwQEQ3hB05lwDjY1zGeKXQfvVV24Sp6MuVeA==
X-Gm-Gg: AYBFou2ALg3I6JgsvLq48fa1tsl1o0MK0yS8kKp2+FrxeabYWPkndWDClwPhOd6ecxh
	U29HvqtrwNnsLO2BcX3bynyWa2Xthr/InRvxKU8S8iKiiTEeKsGhO7NxZiv6sHPdUx5HzEu7Sud
	j7A6Jo78l0WfsDGFs+4arDrybKfLvUd8gi0jVOpA+GAoU8nq4ZiCnbeIzbwFI3mDXBsfcqKuE9O
	oRH+9aqr1dwXphC7mchpXgpeSZepS+v+o3NxldzjUdRPeF8XJ7kVZjoNrPjgcqS5N0VnzhnXPjz
	LuvC9XFycxDIjv287Q95szd3NfuhjJtWSC8kVM3RpMYVeaT4KIaJ3TvKxasLCvLXE2zRRqFZwFE
	aaqZpbc90clICtpc=
X-Received: by 2002:a05:6122:6b1c:b0:5c9:c480:8910 with SMTP id 71dfb90a1353d-5c9c480c705mr2092281e0c.17.1789992379567;
        Mon, 21 Sep 2026 05:06:19 -0700 (PDT)
X-Received: by 2002:a05:6122:6b1c:b0:5c9:c480:8910 with SMTP id 71dfb90a1353d-5c9c480c705mr2092195e0c.17.1789992379090;
        Mon, 21 Sep 2026 05:06:19 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583250sm22170562f8f.22.2026.09.21.05.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:06:18 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:06:16 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 09/11] arm64: dts: qcom: ipq5424: Wire up PPE clock to GCC
Message-ID: <wjahb435ssk5wc5cdvrhhx2ac3t2imneqppevcqodonqt6zcp3@s3lxhumleoot>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-9-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-9-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-GUID: mVY4gpyPkELapU6X12hMdMfSdU82IhaS
X-Proofpoint-ORIG-GUID: mVY4gpyPkELapU6X12hMdMfSdU82IhaS
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab11dbc cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Ue0VUxZ6JbCSWW521nUA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX+NhaHUVVVCxV
 4IQ4f39Oo5NgiiCCdurwBp/YIVKL0SC4vYPlkwe2E9yDSMK/l7NcXCVK1GQunx+PhdZGpTK4tWV
 hzu925K+RlU5WObUiRQfVs74R7c+8Vs/6tpxFWmlexqiP/hC4NRjE1UXmgB+ckGrUg2fy4XvQcZ
 DvnU0bkDk5amFJOda6AFrxGt5HsDNaUCaqM4rBoC744w+0IVjbLTJ+c0pZsOL3lsym5u1PCr33n
 s/JNFw65RkvNG+R6Fqs2Vy+ycTU/V4RFcVVy1/jBwblnQfvKHd6UwGlT4EzYM4UcxWOtlEYnX4w
 HibzlSeF9wt7qQYJNpXcN4rZ5BBfOLB8n43GlfzAKH+pJ1Kv4OjctrTuMsQRRfJxELrI4sSqWdN
 2M78aPdt3STQUyNjpWluPgPZ0uh0oOJth1qw1vpmg3UuxOmGdp1C4JyCgWD/H2PBUf8KzCLj7D4
 w4yfy1Ua1dR5OEX76nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXyZx/TioRmHU5
 tglXaMKOtCOy+YBBDuad3p5xNmHD5VNMsaSSm6qxzxXiIvg/lMh/4fplz/DKMaxKB4oqZ7ryQCJ
 AlqHg6Gn+rB7PwVi8Gbfzq2ZdYKgRMo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

On 26-09-21 11:49:42, Kathiravan Thirumoorthy wrote:
> Add the PPE 375 MHz clock generated by the CMN PLL to the GCC clock
> controller inputs. GCC uses this clock as the source for the NSS
> MEMNOC clocks.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
