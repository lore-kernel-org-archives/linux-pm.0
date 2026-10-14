Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600044A6CD8
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966487; cv=none; b=hfyNsGDJidQaqdi2Fz2wr9sZxIxycK2VFzyIwHF/zkPdsJxrK35Eb7HKZR118pTOcFy0XvDT6vu0t7SJ3DoelY+hQj9RYD3ubj1UAQpM4faA3te14uGNemnXGfbD8jg95g8zUfIKRfkbmzQDXhprIC0nJvWmHZIQalrUlKNMI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966487; c=relaxed/simple;
	bh=hA5Jep5pACbObsfPa/fLER2WRbYqlyN+IWuj26mmClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsjJN4Oc3ZFAqRuyIBVw+RD2t2KeB3Z+drp4PyTgk5QTr2EdvTiUquLITB3+0XPUKDhXx7oPSdB1FOIgVchKEDfBFr5MWKqSXetKmmae4Uddoz2x/wtFnNROEbV81RaBLz6pappAeOWj8q9GuuK7NWKU7uxKOfXYkFIOftABtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/Vb5+OT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FvWIGz+n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/Vb5+OT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvWIGz+n"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6lEf42088418
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X/S5SRmbTexKmsjmoZdpsnlp
	+I+xKbH89Xqk3Tt2TQo=; b=J/Vb5+OTiCuO5oBT1cUQpH44EzoDl8aMYiuwNo3U
	+8tMf8oJDgglHc10Mrm+/F253hakhKEnVDaQ59fs3VMpQiDqmKTcoFkuRVADPVV2
	tzvkl3rmFHz7Dw2k8sI4+zsHJZLhmnV22iPDG4DASih6k+VWTHPmXq6mSOMKdAIj
	dlW0GpP2mjZPDekHXKDsMWkaFR5QsAivJmAw98SVlY8fNpoZN3XcElodBtqYh1Zl
	j0/KliDizHtucSam3winuX6RTotlBTURlkaoxkUHG/MUQqJZjzO6WHV2MIa6Xcrg
	P0YjC6kv5HNALn/rccCW3IIypKp3wSBSd6A/QHAMx50Svw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49hufq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:28:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb93c874bso135985085a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791966483; x=1792571283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/S5SRmbTexKmsjmoZdpsnlp+I+xKbH89Xqk3Tt2TQo=;
        b=FvWIGz+nHpwrSCuY14FOJOH+7iJmTzlxGOp1T/12vtm/B83VgbHLwjVJVdLdvIiRMU
         LDjpADRfEuQnFbgOo3MY+LVNmOx+KqG/BU35x3kUFDBUAS69vsQHWfrL4sXk0MXBPaFl
         HE66pbR9eqV8zoXAviag9FVHITWzUH/3+dUIjScBnC7huJoikJbPLWOyo5491COpHVR1
         +dPPfDzYsNtQKApFAgqa0FrwL/ScqrEVNhqKs0NAwLmIKaGiPopJ4D9IsHe845xoqcxl
         /kyiMUgofOac5PELIWUGqoDtrhKsEcxakzEm4A/5uRL8vxwZcAbw5FyGnXI5dTw1wl9v
         KQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966483; x=1792571283;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/S5SRmbTexKmsjmoZdpsnlp+I+xKbH89Xqk3Tt2TQo=;
        b=rjjv2PpKQrxHFEwRxEOwQZC3Hk32FYXy/D95IgVnkx5a8MP2afZv6EGm6ZFUoT2/nI
         nNC6+/5dDdwxh1CoTskuotU6RKlOed5Y7kZ25EoKrHNXXYnxI1sbNp3fJ0nLReWbgT3l
         pcBDZtv39EUZWck8pGImMxzsPDrImafIOSxtzKcVcno9hMf5KBWPvnEsF+sGK0njWfye
         wRq9pQcW7uNf3FSSJFQYKeaAVEOp1P1et4xCvLw4xd9TZ3WiDRnieiO628aRr2X1L18H
         Wu93EaEos5hWrFBCdCgNJ6U5HCg6IEH1CJsGT0JwZlmFYIfz4WnEMqhIU5yUEqU0N/g6
         DVMw==
X-Forwarded-Encrypted: i=1; AKwUvBwFdeFgjQkBrp+dh0KdpCQ9CijJRjFdHBQBAvHM7kTZ0bju/OsWVbFh+URhmsrr3gjD7SLl2WSWJg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLo/q+PDqCx/jQmxgurRQgAE+hGQtkVwiBS3YbPyq238rY2qlt
	hhEsAepY3lWZqzXQKVNntcCpXSx+cr1F/Qi/BSspknZNvju9sfrCIsDaHe0SU2njxO3YJ/cYlot
	1hR3ck4XSJpTa3bio2fPE3YUaQST82QEKfaHoDoVc6fdJNeBdgTSQCCstD+KzAw==
X-Gm-Gg: AYBFou21cpjYa+dgR5VqLp0XESAsbVzwVqCJqVoeyzDFt2D7LIH6Q4DPL3ESKcEwJ2A
	4k1MTY41imWMMAYJhrOEhegUBGW30+DoN0oloXXswUqlKbcoU0AjRxXtMqpsUThCm4BS5Vy/IVb
	DZXsHODy0QYBZN0lempYjqL0HVnU8w/UhvFlKLDQKXLwXz8SSrgJvPFkCdmuzbzOzQE3TkB/jIf
	1+FtcwdIKol1QBD1XW2Vfe+3NpJ85QgHK0XPz2uCH0aNlCOKX9faefKa1Ii1fVXuJem/kIzSwr6
	+VYXjIZtVmA6HH+/kk1m1yLP5O6blWhci0GTmgw425jTy85+37Yu1IhY3bNY7tkthgmeBaMnnBN
	taJF0IKMP3dWWDKmi
X-Received: by 2002:a05:620a:4010:b0:93e:e1f9:4c2e with SMTP id af79cd13be357-93ee1f94f88mr1234645985a.5.1791966483489;
        Wed, 14 Oct 2026 01:28:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4010:b0:93e:e1f9:4c2e with SMTP id af79cd13be357-93ee1f94f88mr1234642685a.5.1791966482859;
        Wed, 14 Oct 2026 01:28:02 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm13464144f8f.0.2026.10.14.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:28:01 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:28:00 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: ipq5210: Enable interconnect
 capability to clock controller
Message-ID: <vhqpbhknc4p4syz3y7jyeesg2vqsrcakv3p6r3tnla7v2kr6c5@kpgsr3rmhjvx>
References: <20261013-icc-v2-0-196b219e25c1@oss.qualcomm.com>
 <20261013-icc-v2-3-196b219e25c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-icc-v2-3-196b219e25c1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf3d14 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=x4xV_kGm9pRGdifk3eoA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMyBTYWx0ZWRfX/l5TKaWCEaPo
 7aNolgK6THEDm5O/f2VEECMx8cVP8nQuOuaZI1xqKMLRJcXT05eTE7udYxIQvkeVN28SyKF2KMI
 kPe7MKXnnQkU3/N4g6oAJbIOoT3DoRTSHZowl+G3jxutgEHfOPRsoX2YE0yas+5mwk+SxWJ3j4D
 mxWP7TJs+DqDAKNhzgcA7xqEF1lZrgVBUQFo9Ve2gtnZcBDiJi1jhQts7Uu/i41Cq4FY4rXCOkV
 C0n6gEhJfHOpgWn99BPaHjKkglymOXB7qHqE89aTv+jIIVMgOdQlTaKcXgvR/iZS2FDfRuwsQFS
 7QRDHEcZQrinoKHJwAbptC/8OMtgQvgep311szX9TS6CILgd098AOFEy0K3sWyPYSMRA4vOYUfh
 fZ2o+yqG37rMY9SXprQXLSh4UosoiFt1svxJfi00Ev4YU9vbSsWe8hvo07SohKa5qrOotVVoNkH
 /YJBIoMZ6UGuHff/5IA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMyBTYWx0ZWRfXxvxkExi9NA1d
 nJNLe8rAhN3Q65/4ecvWog0iZSjd3tAGHSJIHvT6Pvc+iyodoykdsyeelI6LitJhfJWnul9WRMF
 VUndTTrWLK+b/XK/83i518+rbXQuihU=
X-Proofpoint-GUID: XlRcGWe4FmT45kW4EJlupxOR1OHi8wZF
X-Proofpoint-ORIG-GUID: XlRcGWe4FmT45kW4EJlupxOR1OHi8wZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140033

On 26-10-13 12:39:45, Varadarajan Narayanan wrote:
> Add 'interconnect-cells' to the clock controller node. This will be
> used for enabling NOC related clocks using icc-clk framework.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
