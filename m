Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572014;
	b=sYZs/8PY1vM2PP3E0NZbxsO3FAoa3OQdV4H7xZjkHJ7Uc3oCT2yygm9RsiGAbV3H/K3e
	 wBWHIXeECqVJwMu0nK4RA5PwbjddndolWdVH3BVXUNMjDr7u8eaqjhmIYbtU3R+dzsRzx
	 VvTE/LAngFeMVYhJ4eH8WfhSVnBqPq9jwLWmGzv2ukn5hVLOLrkmfjYJdk6lWu5MhHnJZ
	 n1OA/WyvRvQhG41F7XmHir0NLpTJ/oQ3ew6/Db5m0s/4WjjBjxtcPwKv4RxzmI723UNS6
	 hd6MhTNUAu3awOrL5KoExON8MBIgYwPG1ur88QlXv1YQNUfjE/eJXvKZ4Bk1b5eitxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/bsu92Px2Xzs3mzwAmuQ4TO9HLtINGRv6UJpIugcPNo=;
	b=W3f79EKcgynctbvM9+Sy4CGiv6KDXkFfE+LXOHY+PwblbVlzNUvf+I5aYtHZZuzFV3mB
	 JLyTG4Fy2Lyo999l28Rejwv6nqbMxfnkw8YNqcOV2NwZbT/FfTE2oriNGYKgU+LH55I5+
	 mmbHB7dOZx6lI1XqKfifta8kTtHehNfvzDcrOQ32EwjUZi48wZGbyNIhiPAiFZ44633t3
	 CpjLG5dfdUNLG52oghw0jZkI9XkyexgMbacGHOmO6W/44qNRJ4Dm9oWYqJpi71MtY2JeD
	 UMPv2k3QWroLsivHZAaC7iAPbGjE0NU+a/TaHiH/nm22QfmH8kZu66kWqQhH//vjXJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RT3DAxHs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="BX7/cPsp";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F5606A332
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71F5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RT3DAxHs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BX7/cPsp
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5jLAs2848640
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/bsu92Px2Xzs3mzwAmuQ4TO9
	HLtINGRv6UJpIugcPNo=; b=RT3DAxHsBuN15IMm0uOKOO6VloQUq5kLeZzhVcfV
	N6PTAxKu0uwP2EnKT/eb8iP19wxCD/ie69QtegI3Cu5wmKqxP2p2m6gx9fMERCwX
	I+QZFCsaN+U9bfJG7j046x2ro3ZDTE+hlz1rgVK0qA8MrvkqTDFDezV+QyR0IHoE
	p6VdGdRWWFbtHDTbCUHmeFIZlDQeRuuXtV+TIzv4vItdYGGLBZjvq/yvj7Bd9o6G
	KxKXUSI9Sg4HLCeosyKAHy7yIPTd1A2k7MpArJX2zUPFF4Nz/NtoPZHH/v9o/0Ex
	rsK3GAonS5zSQU7FWXqp+cboZHetaxuxQqHGES3Xzq1BwA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9ar1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:40:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso2473815eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792572011; x=1793176811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bsu92Px2Xzs3mzwAmuQ4TO9HLtINGRv6UJpIugcPNo=;
        b=BX7/cPsp6cjMuIqkRn5wHuROkTbTjD/z0i2jUH+Jt8aqEvBcK62tXb8UGaj3c5DjoI
         ewjnAeWprpvUMWeFpjuYDcLryDkyCyf2CgoPbwVg+hMxLWkEhd4ZEf6wkG17RifHFmhJ
         KClfiv4b9qVtD7lz++hxeziYFmJYOM72PXVnAHbDKRv1mLeRGM6K04tjkYNjo9yzEZrk
         2B1lX0uyEdpMwbCLFVyNuiasMn50Ri1qGSlhRwsiCRO0L7RighnWmSlOkMeLbeU1csz2
         7SKw07sCRPVIPz4vc3ctotoPxR7SvvukQRdO90KSKR9sIJgJecS8G5k3DbZtzfKLrpK6
         jM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572011; x=1793176811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bsu92Px2Xzs3mzwAmuQ4TO9HLtINGRv6UJpIugcPNo=;
        b=PkKdWSLS0WxGB/wKfufOkZ+CeVdMX8Z6skyWrjal4ahGldw+aOFxe82s2bOcWD7CJ5
         QSN3FdU3NsfBokp//CmNESJVQV/7lZxwNW3+l7AGsaMpbsmIrGe9Rkluq20gleWiiM7X
         2HsxBqxGDv9T5SdDtyxZbxtMiuNvHX0vnY/WeCcykRd9m8d4/iBEwOIohOvEqBIKvEWF
         90qYT+QkYUo/PEfZLXIm98A62cLqLuFFFLjJ29eoxAE7q3xz0USuohCEV1F+BNcTA3Tk
         g0PWrtBdVyv0xSsFS+VpCaSmn1/EofDAj2gh/SzZJlMsrVVKu+og53eVTDbTDjXM6Guc
         r/xA==
X-Forwarded-Encrypted: i=1; AKwUvBx5r9YTEaXZ3tbYg1e52h68768P2AtND/jJpVyjdkE1O/KtnAAZGaW0YZI/porHdWt9xJLzahnTOA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKBN9FNJaNKB5IYXYwLdmgTq3Hs5oJKZbZ4h3ShADgdBfOolJQn
	M8+aVCQhCM4pp4saAF7B6z4ODkKXlI/VyEFXoj6R/viROzEC0Whmk2yPiTWon3nHGLnasYcB0Gw
	6Fzj0MptgVxe0HQ+RB8GdtSVM3nsUgrSUD3Is/IZkgSIcrI8Ia7RneWRX877Bow==
X-Gm-Gg: AYBFou3nIv/3wYWy2YHfP7a7z+g3elVZmuC6gun+Zjpm4c6t0TvQrhYhXHspneWxNgT
	z3vMrJBfJwAkIycjqUedel9fwk84xeORkTgqOZ2yOH3jankE5h2NFrWuQl1Spets3EH8xTxwhQc
	XqB1MuUc8WEl5V2RARusq7Ng60iUryJXIm/9iUpMf37h3UqqDaPHr7+SotBRzTVIZ+ElBqFwlxL
	mRGtTTBzFnlo8nEgybgIhkG9uWbFSvNtizEgAaqeiHW5f7mqoVcHUFXYegSf+6ilUINI5mG6O06
	4RAUwdvJWq7cVzucaR6IkVRI5kz/blrqttcq4Xpm4BFfhnSVYFm2EaP734Z5B0jQfSXpnFDWKHV
	ecLoHvJdDj+ubl2K6x+w7pJFy75TbyuX2gKBSRYNgnAl3RrkuJHJWHiCUEvIgRi+tDiTm8ALA72
	SzrlSPC5NpCLtvcjOpDilObybNGzIo
X-Received: by 2002:a05:7022:ec07:b0:14a:6a66:f6e3 with SMTP id a92af1059eb24-18dc065e242mr6244536c88.20.1792572011220;
        Wed, 21 Oct 2026 01:40:11 -0700 (PDT)
X-Received: by 2002:a05:7022:ec07:b0:14a:6a66:f6e3 with SMTP id a92af1059eb24-18dc065e242mr6244485c88.20.1792572010671;
        Wed, 21 Oct 2026 01:40:10 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198e2d6sm4749009eec.22.2026.10.21.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:40:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:10:02 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP
 tables
Message-ID: <ath6Yrtq4HSGU5R6@hu-varada-blr.qualcomm.com>
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
 <20261017-calm-tangerine-marmot-2e8bfc@quoll>
 <athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com>
 <ecc66886-1989-4e61-86e7-fba6555c870a@kernel.org>
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
In-Reply-To: <ecc66886-1989-4e61-86e7-fba6555c870a@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX0MtFromeBl+0
 7R981D7NIm0mi/UhTuNkhN3s+Xb/jiS5eWgJy/PlfQwisZNGzg9H4CF6lR358ks80AK7Ia8Y8dB
 vc12acZ/bm+gUpZxhlLCdo/4QUv0f6s=
X-Proofpoint-GUID: 5_7q7D5yDSv0hIOrJd1lvj1AiUSr3Lkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXy8IXXZwvUFkU
 O4eMn2O+OkN3Rkg6IejOt7Z0vC6TnB5HUKMEEOybq3xS10oIEuHyXr7GgB8ct90+eDHENofJgn+
 alFYqMzL90UcWhex/7/167NeZmCNhnlvFtjHJ++str7Z5/28PAwJ4eGhOsVlEZ+LDJCexElgzhG
 EaHgze6kuoGzQL46FEELWH3YmSfiuxSb/R+SMorWzZb0V5K/QcqFuwFXJfujbNeQGiQrwik0GRU
 h3be6Iroz8e4j0CBgTY1i65xjCl8R49KS5ocpcNDCketl0HuNTuquTf22jOFfMI6Eg19yPPTM0c
 FPDq9iowzG0vvzgm9mfCiSfe/M167nmFHGX/PxGj0M4xW3YtG8Uyc3wGnSa13TtBclCfBXTWp57
 oeKONTV4qd0N5lpovq5/7cHGl+z8KxXHYIo+CZdMqXKGwvRjhlbjdhXu54nWFHn3cLvlxeZCpXo
 c2Qj4bcAhvF1Pvo5TzQ==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad87a6c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g1hkF5I6mjiIX44rm_4A:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 5_7q7D5yDSv0hIOrJd1lvj1AiUSr3Lkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034

On Wed, Oct 21, 2026 at 08:17:36AM +0200, Krzysztof Kozlowski wrote:
> On 21/10/2026 07:38, Varadarajan Narayanan wrote:
> > On Sat, Oct 17, 2026 at 06:45:53PM +0200, Krzysztof Kozlowski wrote:
> >> On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
> >>> The OPP table node-name pattern also matches peripheral OPP tables on
> >>> supported SoCs. However, it only handles Qualcomm CPU and level OPP
> >>> compatibles, causing unevaluatedProperties errors for generic
> >>> operating-points-v2 tables.
> >>
> >> But the select should not select them. How can I reproduce the issue?
> >
> > Sorry for the delay, it was a long weekend here.
> >
> > With the attached patch, I get the following error.
> >
> Does not apply,

Sorry. Have rebased to next-20261020 and attached, please see.

> but exactly that sort of opp-table is already all over the tree. Just
> check yourself.

From what I see, SoCs that don't use operating-points-v2-kryo-cpu for the
CPU's opp table don't face an issue. Since ipq5210's CPU opp table's
compatible is operating-points-v2-kryo-cpu, it is facing this unevaluated
properties error.

The qcom-cpufreq-nvmem.yaml change is approved in [1]. And the change to
ipq5210.dtsi is to address the feedback in [2].

Thanks
Varada

1 - https://lore.kernel.org/linux-arm-msm/20260703-lively-intelligent-raptor-5edfbf@quoll/
2 - https://lore.kernel.org/linux-arm-msm/06e6868a-c106-40b1-85fb-5ebbc01eff16@oss.qualcomm.com/
