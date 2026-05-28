Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94F305692
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946272; cv=none; b=nM0Ocb4Eudr+pB4FZLKGhiAOhcV/rc3UgE4GTiauSNmsZ8UbK8GJu1B8kxLHwxcJgqrDX5NLX3Kf5zSqvTI6FgRkgNSDApItALe5Vdyp4CMF/95WvoWKKDHrRCG2e4mySNIIn8/6dNB8HynIDW8eHoIeMIPIzFaYloENlMod4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946272; c=relaxed/simple;
	bh=PqyQv5lR4CSDal3C1K6XS5brllo/mkSEyVrmaA2Skw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnBwD+YUoQsAE5KikZkorSoRfemMcdX1cUzjxdR9p5x+eVmNjziqpkUDTF08gbo0A3zZAWDgHxeav8t3lBCSMQaiN27WSPXA8jD0X9zecO3vfAtqllpTfORu8hMUOjnJL+1S51a61b8eam73ZOBlUBxSN9WLuER950Z7Con3kyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMKNz5kP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EH3Ramm4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMKNz5kP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EH3Ramm4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKlwPw2621788
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bheMS1C3LAWE/VCtZ8G7QH4E
	3JfFT6z3QwuAGkiTibI=; b=CMKNz5kPSHCyOAQChseFIsRvkUlRhLTWbyB4gjyY
	Fd1oQz/kojOhEa/3/cLsGU6eGeOzd7nXsotl5FerwwFscC2WTOeEcnEalFH1SEFo
	Nu57TKntYQ96H9/KR3Rx4RZTBtcMXpEtJ9BPrWJcYmZBbXcvYLMGibUdJD27OLsx
	/bTzPBtWMem+WalwOI0M+KT/Q5JOcjkK1+M617SNAfrl6bPvZ23sss7Pr29zKZ7Z
	Fy7Lo3XPJ+BwPewD/1hFMyVeEocw3/GeAr4Y6MfBXNtfiwyIOkruNHWt1yZeRN2g
	NoAQYF6C3SYVI6MIm3d18U/8uQyR0YZyPNXt0Hhl0Ila3w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf1ed7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 05:31:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914c5911be1so893427585a.0
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779946269; x=1780551069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bheMS1C3LAWE/VCtZ8G7QH4E3JfFT6z3QwuAGkiTibI=;
        b=EH3Ramm4pqDy3kFtzHExrOK6gN7HoisG9vrPjobJVu6vg+FJ8Fokua4hA2iddGl8T/
         47U9BWlKMi6zUg5TiMb6FUhtMdjAihweH8uglnSVFAnSfdU+rj22P9FFa9x0FWBdzgi0
         PnKPo0kWMk0GqBcoJWzkP00TRBmoQ0AGqJMncPq99Szglc+bgwt28p0r+7w+3oZM2Gtv
         A2vnT5U/fqk3riTq5UJ80XCF0XKBmhw8a4OF4s2y8xstFmZj9UR+WCXl3QanFu+OmdKP
         U2tbAGkJex+tT+daTPy1/Bu2bGTl7jXWzMmqMo+8EFkmhBLUhYT2ep/fyls3ueweYGvy
         O/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946269; x=1780551069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bheMS1C3LAWE/VCtZ8G7QH4E3JfFT6z3QwuAGkiTibI=;
        b=LgXYfv9qywQNAtQ6mZ8rmiaddpN1iDtqRHW4S6dpMIIX/J5T5qFOPjlfJ+9uXs3bwY
         ME23C/hzagsk5OLTCBODzGHRcmO71PdjaIixJvKuiM4g9dBsoPW5yHJtwpcCOQAQLpmW
         qVlZMaWQF1UkwDAuDt7OuuhLtnpUR6pC9Aj6mhDN7HQ+pEpWaewGcm1i/TOC7wQwiE57
         sbBQS6SPf0OqLk8DNeA7vlPz+iSzVqHgHNx62WzW+BG0jZBJ9JhjhTttdlJXoUNN6GqO
         aSAdO1chjBGkucE9w5m6MEGr/nNwoE/dl4LoMLOs0/gFok+zTUrzT2hMKV96xMB7hE72
         TSVg==
X-Forwarded-Encrypted: i=1; AFNElJ95ZsuxVLsNHwjOLC2/ai2Io7LhfooCHbZnr+8c+agrVIe/jZZi2mJWXtTJizLKpXtiA7EnGTgiaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVYBClJ/rRsQbjyrEEhZofURYYThCi6cAngnbMr8V4EZNKfn1
	j7Bc3/dgg0SEIWmp08IbBaW+l4Z5pqqVCtqQSDizVEyuS95p2hen5A9M+uPT01cYe54oxGTogAA
	nikwf4BbWbpkZ4pE+AzR8UxaRQOZIBoTE/tO0qsjOIjEj3C/lOvuSBFLJ3f3RPQ==
X-Gm-Gg: Acq92OFDbQWMlQZrtJedDSlHxycIPWLTmngxyhKX2ycIVRcyzmAtm8r/Z/D/yajBP1o
	TZo7dWvlfYLnrt+JmXLo2gVCwVYbkJfCX40a9fbCVu9ntxagZQPNnIcyNCQyEY/JXO+LwgtJExc
	Lo68TU4TXJFV7kJw5JAY4BC2/uOyDw3HwQbq+8ItRimVE8h1r04qBA3j46hxJ4fgyQT0SSHbzoA
	vLqY9P9q5bX8ATCBDgV2vXHTFwJCWVIgxTS9Z1xptwRQYBrJXzf2fBl8PXMx4EnhIJ6D8rTjxE5
	Rq6g6jBxNGgz7fTrC5lI4NiA8jPeki/v3ngU8gJv5HkmnC2i1Rhi8a7vHfZPI0vxf5+whZry+Nh
	f6a6ogd0fxUjxzPHYZhtaRqjzrTeQNETzpWmXXoSFJ2EtS056gBGPZa+DcDQSs4IobcA0ulrVfG
	PKve640QdQD6rBmuNNCwO8FFuAoBKj6J1NJWk9Q6tHF35OEg==
X-Received: by 2002:a05:620a:4111:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-914b4a3daddmr3603194585a.58.1779946269556;
        Wed, 27 May 2026 22:31:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-914b4a3daddmr3603191885a.58.1779946269115;
        Wed, 27 May 2026 22:31:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa4632236asm1671483e87.47.2026.05.27.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:31:07 -0700 (PDT)
Date: Thu, 28 May 2026 08:31:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>, hbandi@qti.qualcomm.com,
        rahul.samana@oss.qualcomm.com
Subject: Re: [PATCH 14/16] arm64: dts: qcom: shikra: Enable BT support on EVK
 boards
Message-ID: <6lkpmjtpozsfrk6ljnzwek7q3kgj7t6cjzre7k5vijx4ta6apu@bdotfbblxpu3>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-14-f51a9838dbaa@oss.qualcomm.com>
 <rbu5oub4uc4rubdlfth7undrirlyfwbnst5clgyvm63fde3tcw@fulet3k3a4sf>
 <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
X-Proofpoint-GUID: mvsfKWk8XqBD7sxmJ2wm6rQ29YNFdaAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MSBTYWx0ZWRfX0s4R0eRExdpe
 HlKDnpFNxmxOshj+taHSH0+EYCgQZFmb2Qe61AFgGYT19sb/XJwMG65g6o68E4NLJrp9jk0bwNI
 Xkem4/wRhRmU+bZFPwwW1XCcmrncTfixWTCuR00PXPwlbf6X3cedZfsss2rhSx7EaPyE+1wGtCE
 iKXHNnaOZA/0YeMfynIScC/QdAuypShXWneEkD0CO5a9DkLG+lp1M5BVHTd4vSxtycyKSb7J9NL
 kgU3dengkPfs++82jOxjKEvNmH17SfPE584oYaaJs/O9nsJbZIsnAvKGDQ+vLrTQjTq6aA9BwKO
 yfsJCjTIdmRP6olBV1FYE31gJ3gRY0K/Da0tlVKtWjZZ6vMVn5HxpNuXsEfXFrlkLK6lckMTK2K
 Qo2algosIOwCdafrj46QC4g8oebx/O738eqm677tmD4rzC0l2wSAgWDSSAdohbki+HYyj59B86L
 kUfN03m9vSE5gnnfwrQ==
X-Proofpoint-ORIG-GUID: mvsfKWk8XqBD7sxmJ2wm6rQ29YNFdaAX
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a17d31e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=o6hecVIOLF8SStibk4YA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280051

On Wed, May 27, 2026 at 06:53:30PM +0530, Yepuri Siddu wrote:
> 
> 
> On 5/25/2026 3:01 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 01:19:18AM +0530, Komal Bajaj wrote:
> > > From: Yepuri Siddu <ysiddu@qti.qualcomm.com>
> > > 
> > > Enable uart8 and add WCN3988 Bluetooth node with board-specific regulator
> > > supplies across CQM, CQS and IQS Shikra EVK boards.
> > > 
> > > Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> > > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 12 ++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 12 ++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 20 ++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra.dtsi        |  7 +++++++
> > >   4 files changed, 51 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > index b112b21b1d79..259032bd20af 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > @@ -16,6 +16,7 @@ / {
> > >   	aliases {
> > >   		mmc0 = &sdhc_1;
> > >   		serial0 = &uart0;
> > > +		serial1 = &uart8;
> > >   	};
> > >   	chosen {
> > > @@ -57,3 +58,14 @@ &sdhc_1 {
> > >   	status = "okay";
> > >   };
> > > +
> > > +&uart8 {
> > > +	status = "okay";
> > > +
> > > +	bluetooth {
> > > +		vddio-supply = <&pm4125_l7>;
> > > +		vddxo-supply = <&pm4125_l13>;
> > > +		vddrf-supply = <&pm4125_l10>;
> > > +		vddch0-supply = <&pm4125_l22>;
> > 
> > Use the modern (PMU) bindings. Also please add WiFi.
> The modern PMU support for the WCN39xx family is currently not available in
> hci qca driver, that is why we have defined the regulators directly within
> the Bluetooth node.

Of course it is, see commit 9f168e4de5fd ("Bluetooth: qca: enable pwrseq
support for WCN39xx devices").


-- 
With best wishes
Dmitry
