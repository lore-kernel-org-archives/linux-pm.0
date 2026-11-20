Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170078;
	b=XAgxWS8JXLdLkX5IHf8dK3MqocEp3JVfb6vT2rOmsCrTjp+EM74lVysL2LBm0aqHyD4b
	 FIXxTGPUKWK5oGxnbAtGpc+xwYupR5pOAZPtvRKCPb4Yv7MHueuH0n04+dKXR7o/0je0B
	 M0VaJKZO3Uw26TqojHelthGPA2IbAy8A8x89CFT7DynDm4kOapZPS/pjnwzAl31KMGNXO
	 JAYpLmNdyrjwHXamVfxQc5BsyR7Z1tsP6W1xwm4+W+FzVYe8bblODKMCOoFTi3jDr7GFK
	 BHUfHQREcMcXnLGy73xvuUrTMOKQO2k/0i5fudKLgh939bVoCoK7zx5dMuboV10b82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170078;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=n6xNjiXLI4ldZMgm9vuyivlFeIPVFifPb1EDl7UJecI=;
	b=x6l4EEG6XHA2bGS8+6yyNrJDeccajYGYCBlrfhUSN23mUFjZ0uu7EExzMRTEBG/xLGjZ
	 B1OIZDk2eKzbdBLpT8rDR5reeb7XU17Shoxsu/Q3NcZqoIpecl84MkCua6Xt9lOzvHnZs
	 Fg/5KIJ3h7tVHJ3NrFw52sDUqyOQ8O+g8RbIYE7uDv5U+2T95xrGRMoOOcS6/+YddvIST
	 v2biTpXto2q1GY1Tnj9MZhci0JGfVWiU+srmefwz+B6l/rZYO+u1sl/B5H6/Vtf32DNpI
	 /1bJ0nS7YYXGYtXGQH3QfuU/Y3VIcDclLMCvuU0YZ7moazb4dGnTIw0sww/E/jzfRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiQQmnZP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NFgi5Vhs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E5606A331
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 949E5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiQQmnZP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NFgi5Vhs
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fBIs3576079
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n6xNjiXLI4ldZMgm9vuyivlF
	eIPVFifPb1EDl7UJecI=; b=CiQQmnZPTzu9L41uX++xGZzjLXHOfK8Pbf6a9gvv
	1b3ZmL84IQyGNMUUyQXpRlOPbv7v23GfD3cD4qderzPHqcNp0Sc/RelCW7K0YnFX
	/qBmQ19QNwi50g8JyAhmj4ClBHBEIfm2trb5SjhaSsUNBbjYrMHa1AY8TIuAAnM5
	dGgwM3Iqw4Wul05TOvDuZvhfKvgPydFUmoi4yje0wedMFLLGtlkH/UpG3rOu/kNA
	qSS57tfItpUDX1QVfovE3k692uv15pkjeWBQ5R8C0Eb8t3Jpk2ENdS37v8opHbTP
	5BuRybzmncizaSw8fbTOiIO6biDIp4A8WMvpC9+Bs3Wupg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu80xm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:21:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so199007985a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170075; x=1795774875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n6xNjiXLI4ldZMgm9vuyivlFeIPVFifPb1EDl7UJecI=;
        b=NFgi5Vhsn4vUb/dJrGBKsAI3iD6JYIgFx6PlTkCMFzalQnnNOBBws3Tt49vqVsO5uJ
         nuIGID8R+E8jWn5uqdILU4PsoLD4aGeJwqza5txtBrIFLzJRR9M74vfx5TvqodL3Jecj
         iB9SSLFMi36yt9yfyIgUVD5jddTPnfXcUNAEnsAcj3m//rh0ghlGbGRFLgZyRwX3f3al
         SwRgGD69gl0PSsvDmH2Z+BzB991hQBtpYLPhkJg+grUSSdc2QpxOQgto1/exSveWfuKR
         uSyIHHCEUJpVrl4MnDCywRouZUdekQkzz8L36KrEa6eFiK1hTZQmQpu0Uak0YwG+BPnw
         p1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170075; x=1795774875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6xNjiXLI4ldZMgm9vuyivlFeIPVFifPb1EDl7UJecI=;
        b=Dz2WYXv/eZgLe9htaBq2GpsJ58DAySaUZQgg96RTqdODs30UZlClrWaIBDSHZZtO8g
         fKGL6vstlSEpJvUTY+fxRr7N3OU6IOteC9dxsD/iG7YbpF+cPLhDEeA8p0JS2BWJBIts
         V42fYf5uQNKf5CqMTqx+uEjWW0WJ9f2tAa0du8WBxM1AEcUA1zmA67vVAciPzloWxPMz
         uIRWLBJwFpq8A9WMArI6s2Nwq8lidKX8lvDLXoR9sP1AMNSj+OVHEJDo9syyvDHNaJzf
         XUnsrkvES/Viek9bA5LkAsYgmBT5Wbci5KodMyfaEab6hHvVzATOj1CIKdngQvg1fdAB
         VPww==
X-Forwarded-Encrypted: i=1; AL+hErHuzkQVTlT3i/7MiTe+Kmes8akfGlNLXHx9M33Mrh8zwbsyBW0GE0XEqjSW30b2S4qV+OGClX2RMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nkRI7kDx2t/H0C6vvG0nryGaTg7ZqwyeGouWwKjDCg7Q+jtTO
	5ZBXR++62rvIl8cB0g/zrkhixFJTmkgjZHHF5FHVcK2vJkeLq2/Ilv13dLI/nWhOpCINxc0m0Aj
	tjkWDrpCmTF5265rqVo6ggU/gWQTUsQOgIXxrYhlS/IKRk9kpCmBle0W+D6XuAQ==
X-Gm-Gg: AYBFou33+P+DQtajAvlZjaMutWfC318mJ2o3u9SXaqXrLpY0Uh6vwvmJq/BBD7eA3nN
	dedeZ8ckOr1+toqlO9wcfnC/1bNEqzj1mM8BrB0lqYAfLL7pSu3k/GeJD+2c+XLRkaaVuPvrvBV
	MPLh3KOpsEYHIhJe1EXgSvYBKphNEtQWdzw647vv+QcL8Y67/D77ipEHjjLibilLOuu5V5/weZN
	qFXwS5uQqaf1U6UdiWbJBGVBROwnjqzQ1WC7JfZT8PH18eRxng16f+axMm1eepSJ9VzO1ffpQii
	Mr0DWWrY4qQLNT+EsY7ffSZ3ZJZSHq5eBT54itoy6j9sdLJLgj9N3ZMcEyhdQZiDKessiEBGJyP
	2n5wLYOHsFwit60UBhr8171aXR7IsTcZWkS4GdV4poBz0yoTpB6TJ25aD8G4YJlus
X-Received: by 2002:a05:620a:4142:b0:943:faab:a149 with SMTP id af79cd13be357-949bab1e48dmr406231485a.63.1795170074917;
        Fri, 20 Nov 2026 02:21:14 -0800 (PST)
X-Received: by 2002:a05:620a:4142:b0:943:faab:a149 with SMTP id af79cd13be357-949bab1e48dmr406225985a.63.1795170074176;
        Fri, 20 Nov 2026 02:21:14 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f643adsm29150615e9.1.2026.11.20.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:21:13 -0800 (PST)
Date: Fri, 20 Nov 2026 12:21:11 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: ipq5210: Add NSS clock
 controller node
Message-ID: <m77xx44vjdg7e5myewy63j6nhdkgqnvvdyhqnohmylnbputjwm@2ymesyhjurov>
References: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
 <20261116-qcom_ipq5210_nsscc-v3-4-1eaf92698379@oss.qualcomm.com>
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
In-Reply-To: <20261116-qcom_ipq5210_nsscc-v3-4-1eaf92698379@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX0siitlfkXHVq
 3qW91w/quzfzqirIov+56k4/yPHdWeTQ0WIHgNOUVMOpKMFOnNFSfBz86wdOfOu3UX/Vqny0THl
 9Y89NvhzzlkpEOsStZ0LLAio7deALaOFSBlNg5PLdBg7ux0TEFkfASy6Ez9fxx5Cgr/8yB0knyY
 oeStIWUjb65gKIIG7rH3vaUVp3TMjQEwpzXO5/cBKhoohW0irewGZ54KsXHObD3RII+9rzqKaJh
 8EAbWAEbCFqzfcjnRpgMsSI3czNbMMIUMAMj2MXnjNsMmQQ7/+lhq178pvZ+BZimy3jz0EaVE8Q
 W21rNJ08wRiMK6kpK6TbLUO80loqj61a4+JR6ygqfUC38QPz+IgRXFE9bZQAcNY/rG9TbCQGnFG
 2TouplEis81Cms+N3Sw7pd8QpN1ePXPMwrrFWcttlwGcEve9xOhfF5WaaBCZIA6bFyb7biV2TiF
 iCNz3ZFq0d9N3xfEeDQ==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b001f1d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=B4M9V4KaqHGFCjQwF8YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: vig0ZoiiE4Ycq9RKy4VwpBpbbW3G5YAe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX5gUukgkL4v4M
 efuZD10Xjx/gGK3CCwL6n88CYCYi6f+HVuw3bAWCnFApz+02iemrJzHiM1IMSZA0WDDhjxdIzLW
 sH3iHdz1dBkgrjaOR+KtqxaDNn9Py50=
X-Proofpoint-GUID: vig0ZoiiE4Ycq9RKy4VwpBpbbW3G5YAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200041

On 26-11-16 02:19:51, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> hardware blocks on the IPQ5210, such as PPE (Packet Process Engine) and
> the integrated EPHY.
> 
> Note that the CMN PLL output clock names are reversed with respect to the
> hardware block they actually feed: IPQ5210_PPE_CLK is wired to the NSS
> hardware block, and IPQ5210_NSS_CLK is wired to the PPE hardware block.
> Documentation is added in the DTS file to call this out and avoid
> confusion.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
