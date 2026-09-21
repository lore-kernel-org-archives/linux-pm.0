Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F7494817
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992255; cv=none; b=c5lQhHC7LXxJPzq8M+gp0W5MTvbZ5ox4Y4tbtU/35If3qDi7O3wmEV+OjwfQ8Vbe4qzYkNfdyeyAYYkoi5OBabyDd46r4AC42Kp/ec/T7Ebl7tYnVG4Q6AQCvBi7vxhiiG2+WJWaYg4wNCy+hYVi5L0grT2S16ZQfFSm1OPRbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992255; c=relaxed/simple;
	bh=XRcFq7IuXH9kC8tr1NldVZmFxCs4PttO+0bLD5IWDAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6AnH20A/ngcWuU913PkDJwakGdEo51m4kQn+5HloCmaYQUxx7WJImOAa6tLK7h3nsiFERrJU3bwpMoU7QfMKz/tl8swap25nC1us1aBMFKsrDUmlH9l8WQes2WZ+bFZWUIbsjLV6t0sT/awWDL4DxpSf8NAc721NDpOuKwhbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U6isgjoZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C03+e1qc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U6isgjoZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C03+e1qc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeDmP838010
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=enveY9jv1nThYF2kaQKkUFzj
	DWdSqrtaseNwSFGaCr4=; b=U6isgjoZweeTIfcGZSSS8o3qu5QGVnoDKVHcKiWU
	u8kwH7nSD18DNNuBZqbCiGyq6/lTRhZa4Wu+O3Fo7ECF3BWs4PvTBBTmzSAIOGVN
	bTZ6AFddbVXCejQnGWxk7RkPrOJ+fL4Nd8Iaaqi7yKylPY7m7fJpOzyouMfzQwi7
	7ujrCc1SgVZ+pmZa01znPs3/bM+nko9Wrwi0YBMSxAqw15RpSu2kV4GbJr8IChQX
	t4GcNBE8oaxeF4RqGXkFPt2YF/9ydAnLQzA7QN1McnpSBw8yUo7M0nNSm+CeeQ0p
	Gq0CL5pyEFJTdBobBRSZvzpb18Zy29W0+zbTC4rvEJL0Ew==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hpw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:04:11 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78f4d6af128so867070137.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992251; x=1790597051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enveY9jv1nThYF2kaQKkUFzjDWdSqrtaseNwSFGaCr4=;
        b=C03+e1qcPnnSqqxLOANSQaQhtikgxGMka6/FfHPvbCpWzObc1nWOBmWU0d3LkbpTSk
         8p0d4ceparkYAT7PX3hbNnTA0npLddQNBwTf+xtvs7CSjAIUV0Lq9V5g61lWHgz/FThr
         /NwdBCd9Cd/PODWypGLDrtZ/zDeo34LLd+7GpYsTUzEqVagcAqRU8R+DswYUog7kwhJU
         LY3XOBzEWPFNvo1822Hnkg/PRFKffBqykURn71YSemceNaX03OqsiPajmCZBnNoZHxVF
         J2+VEHipXKNHryU2CaZ8/Nclt1kDiwfZMba+cJCLUKYBENcWlqc1vB58naB7hN1ceuSW
         ftFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992251; x=1790597051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enveY9jv1nThYF2kaQKkUFzjDWdSqrtaseNwSFGaCr4=;
        b=mNW4i8Tex6HTssLPJlNQxVsHW31lfo+gKdP4npJnO2+cm+GSwwaglxiKwLIxHraK+t
         0tcd0V39Ejl2G+pYwoKIFUzrRAE0pAT6TYjosRPtiBFjCD+VYFgf4cZJCD7r6mvEgWEH
         1yVZlFk1WSau2GIxSHV5Dwyr1wuahGbhQSwmkefKsatsw66QfxbhhZrlNGmVDOOuiBFk
         z0mBkxy9/nW1sQ1sh+iSpnXPOR1LLVUOpAmGcBMGssJbDfZqqpOtLSTqyfp2xsCuMEB9
         HUpnZkSkSF/bNQO/19uEXO3p/ZlMNP3wMPclV+Pj880T4IuLmv4i/BpX9ko5gCtnMuzt
         YcYA==
X-Forwarded-Encrypted: i=1; AKwUvBxHRxtoqOotS3GJIoxEOdu8HaxrIfi/Ht0gui4N2TR9iW9gATSjmpYxsxofg2cMjgg+KI+GmMJjzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lEQ2BB6DjQM6ZS9lz4aWz1Zn2l2MSP630Cd+psRtkwME6Qcccy
	LMYp9QJTAC588vl5wZKrYO8fazis0nIgkigGQavVno2tsVcEjmFP6cv12/m9L9iqkIV7XeofKe/
	OBx8wuVYEpc8RhNmdhLEmDteKOUElPRC3KeIgMO3rRKPDtl3EI7E0xKJtGIsPig==
X-Gm-Gg: AYBFou36lUFtkbu89cLQ44YJzD3FZS5b+nHGXqWZecEm7lO+z2HUXacCoCEypgl9p2l
	Uj2W3PLyxejZiiBYo82fv7lylVBfbfBhTdu8xNxkDsCDeFCrnA4mTtKBtUDWHhqiG1evz7a1V1G
	6MfRP5va2mVfxrGsa07zaITBmaqoQMWfrSUvvrS2n/lf5MltND0gq5YDrdR/ey90kEku3w9gEj7
	K8JKzeCt+sRfGRfWMXf4COJ7zD34B2npRChVbAl4qZUFDv+LKVYprdKKHSRr9jPhZfZEXKMbqjf
	r/rvwIJWFYNzxm8BHAuhkstsawWeycDhdngWjYMkk2Cac3xoRINzjS/XDhOUKsJxG4wfJTgDJQ5
	k5311B8kkka3V9J0=
X-Received: by 2002:a05:6102:4244:b0:7a7:19aa:f0d0 with SMTP id ada2fe7eead31-7a719aaf7abmr1670589137.29.1789992251036;
        Mon, 21 Sep 2026 05:04:11 -0700 (PDT)
X-Received: by 2002:a05:6102:4244:b0:7a7:19aa:f0d0 with SMTP id ada2fe7eead31-7a719aaf7abmr1670527137.29.1789992250513;
        Mon, 21 Sep 2026 05:04:10 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eab91sm245354285e9.1.2026.09.21.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:04:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:04:07 +0300
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
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 06/11] arm64: dts: qcom: ipq5424: Wire up USB3 PHY PIPE
 clock to GCC
Message-ID: <gafrnwlti6ojl3nrifhejf76voamomuthwuikfmbkcot26fe6o@5uzaftq2y5mo>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-6-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-6-d242e3d49648@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab11d3b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KhyLHX4QOuxJUOlieskA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 5lCxhuAMoKGyG9OftQN03uUAnVA6ioDg
X-Proofpoint-ORIG-GUID: 5lCxhuAMoKGyG9OftQN03uUAnVA6ioDg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX/JyA/wTKIsE+
 VJMGQTiITPmG20n+A2OxWROGamKnPmkDHC3YHHrSvK2PSFm2ZW655dr6YdS6n5GlVdpkWtMbKgQ
 ctiKmfBht3/3DjF1eFkVLNOEg99Qa+Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX2FuAcmYBAaNc
 Hxz44cGX66BKYk/ZFXL5MqMNmUpCGJE2/0lCRm4aZJTJ9kRNifD6Fgj4fvAUoKcP7IY9V86hDrt
 q45l+eqYw/NIVp3Yat+9sbh+4WXwhIIQQxVtLi0RJqkokEPEu55iipT3VEXeoxzEPIunj3iyJV6
 qItr4P0551+/MeTqTIvwM29cJkS4qTwJrtxj7KSg8S3u1p2JDs4XhTDgAmomvAGon6n+7+TCp/u
 SXcpVYvnbat/wC1+DJoDNttPh4idgaksu/BqOZZka4f6u8B3JWPYJ+UQuh38QrKRh3NAhJOyNxT
 SDQWYE4FbxQP5dDudmX8ppIVUY1zJ9xctAaueAVreegqWPM++GCbd0eI4aSosdkRQtkvOWndf8N
 yV+yk7wBUqBOvqhLPKFU0cpXcChUDVRfzG3AsaDgFKzi8y1CBhgWpIEyirAi1WvYBj/XsWvE8I/
 RS85Ll6XPhgI6KH6+og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210175

On 26-09-21 11:49:39, Kathiravan Thirumoorthy wrote:
> Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock
> can propagate to the USB controller.
> 
> Cc: stable@vger.kernel.org
> Fixes: 113d52bdc820 ("arm64: dts: qcom: ipq5424: Add USB controller and phy nodes")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
