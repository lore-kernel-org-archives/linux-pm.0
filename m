Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269405;
	b=Qy6ZpMBgO4MdAW1VH/BGMpH5Ij2MdEt5LaVDJoEMAmCPoLC4gyaU0EXYoXCn7zhGlD7w
	 qi+7KMMwv7aitR7/e2tjd8aUnC42DuQKhYiaKIf1Tc3x9Yr7772RZ5tHEL64kHRY+q6fV
	 xbkfuqrK7vVXSAXWNRttTM9oIColy+0wcb8bieHsVX2V+b1Dw+1RM/PffzgABfEHdFXDd
	 fUidEwk0R6JRh7pJRC3tX5T0eyFB7NdHFiUheLaf3sbWVUODaj0tw/09yXP6pbopif5QQ
	 SMxeT3EIUT8v3uzu1+QvNyp6jXOCg0zaHwAHxhpCb8f18VVxOPtJpWUjRntWVnF26ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ha3fj/COMHQz5CNWaubKxJEoCG8ElfvHahMKU0w0GYA=;
	b=qM4ws0vlaAaLOLHkDBKgDAWeKbYtMLcwltVom0rQQziJmEw1x9GgIaMwdRmYkLpX+MDv
	 jYiR9yeH76PelUfM76ddKKiiTvaYbJCplZdeJ1978F4ng4M1Rjr7KPBQfpNzexwfr5ITk
	 OwE71CaMCl/6zkVQosnt+RtuHPjv91YIaNAnmFiM2zfj6yshWBAQnrNqopZ0kWI+93QEi
	 gVpKpN0LHfGo3y/+usWzJhM9ndVU/5yzwS0FpgR+1/fP85lU4T2UXljYMppjl60fVZqpm
	 1EFK1TuyjH579i5cFidolcdU8/4+n9jPANpUR0Q0GCO8JZtJkaBzLNSvDKb/rpzxj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zm32Ublw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGMZJ8OU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125C606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B125C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zm32Ublw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGMZJ8OU
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8v8aE2725035
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ha3fj/COMHQz5CNWaubKxJEo
	CG8ElfvHahMKU0w0GYA=; b=Zm32UblwrpFNdJzdB69DOZIKQdTau7hMM+lmAp8N
	cJqczZeK3MXWDjsMs/sjcArdqDErxtMVpFRxP+RvIb8k/EwuKejzg1JVOM66N0nj
	cbnGQqPEh6cTy3RutZq3HJdxyd+Z6MyB0+C5FirG89nUuSym1y8msLtvUFlKnr27
	kaVSncyxq4GMcY6K+Qyw4PXer81E7AMnLo5sMM2e4XYzGAbKm1TlYqCJbUr0v6MJ
	pIK48p5sEVR+Q67V2+qmy2uEC0m+JQwe9lHbm7E5AnReEJugdazjtXaUgkLyYtpE
	9E1oZWtf/KqWF6O30IIaDZyh4q0snx72PcIhxhE4IUbvzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s97re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:23:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2c0e6653so151136485a.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269403; x=1793874203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ha3fj/COMHQz5CNWaubKxJEoCG8ElfvHahMKU0w0GYA=;
        b=YGMZJ8OUFPxKCWqSPM0Oyxm9UjjArWy63XAPVkrOzX4bSG8GiVGSbw7ebueswqP0xG
         yHVUv4zlCrVaPZ7ke/uTcBzS6/5g3ww3Z4vbx4u4cdrV7dE2/fdDd3l6ZlT3l14gkfZi
         IZqAuo9Vmao1eN2zdiFJlO49qjV3G8szocpTzRqrmlhgZGvGhmpJ6yrABHLQbYWQpFPw
         BtHUV5GvWXhYe1JEvzH+obREWd9X9UD8b+D2VLK9PF3pIzieVDipY8DeCglLRWGVKOig
         tlBS851tPk4E76f9TyXbYNkOqtxGePGqmVqpPPq2uisBUM62F37ePQKQ9ueA8AA/IxRi
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269403; x=1793874203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ha3fj/COMHQz5CNWaubKxJEoCG8ElfvHahMKU0w0GYA=;
        b=Vybi4xWsYOGzBUVZqaDUMVrCPh7252JzDtueS1pYJn7fBIKFwcrwlj2PIoluMbmNci
         JD1AodiuYcrTPR2IlgmSayhak/AzAFmMm3qPh+7Ojb1Y+Cuw2kyU/KdejOwnigihWJr3
         t9/ehjrXInLcnYQpPoFQrx4/9S3+REIFiPduPyvnvu0AGz5VDBLCGa0fPvLVGyLYeOHk
         wsiBlf809zwFvxTcyt/2cSKyCdOsJVq1bk4tNZH6lCFwH2hJz6fkn4DCQlVnCs/rvTRn
         MNFDus810iIrFHSfUPRRr64thbpxWMAe2iN+Xe2SyK+TH83Iog9K7+g8hE4asXhWg6Aq
         bOrw==
X-Forwarded-Encrypted: i=1; AKwUvBwyo/2mIBYsWsWWNDUPsAZWW8HkMCn2N30i85GCzEjMztnDQnL+HVGJ3BTL7W2Hw8kN1nWEnSRvOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIKjLvMSEoeBMk90mlasbX79WOFOJ3KuDGZv5LydudIAbGXUU6
	bOTHM+ps2ELdcwVATpPvnbB8kRlQXWscwmkFls7pdtVHEquIWEGyQ6LDG2VPbIYQOrNbYnFSpBi
	S59jVchE0Uwrtg0w3jdkPO1JTeOC+8nJK0IFGzRFw9GbmfP18V2BLXWuvk+Fm3g==
X-Gm-Gg: AYBFou153fQgVDymG17QUaxdWHBKk2m32tjxyXUJS++aaqrAKiDdnIgPAh4vp29pJ6n
	SnpGtw36zjrIPMJs6gZy6vukB0nHYUKjKmqAM94Xl2D0WL7MVDq3A0OoiK8mRauXoFXcQykGTs5
	OLyZ8qrqndBIgFtemILnMMsb5+1Jjw7cHaKMisQ00rejoGfSXL2c+2wPCu6AC6DDK3gFSAYSPkC
	iEW2/p1ZhQN4ysyKFlp0t56J8PXkdCmff7Z/azVzQ/nBvIpwdDDUTJAT6oxYSA7XJNFz/tcFkfq
	4wC0J6MnGt66lnQ4a940XkOtJc07WZK3bBojsHAKaS4iMN9IzP47CU5KjzLRYqgLCoq2IrywQwB
	rhXvtQZt+1NvHNjxS8lOMDHX5GhEtHEEQ2XLWapfReMUPJabDk27H6dvDIvGLnklV
X-Received: by 2002:a05:620a:2616:b0:93f:23ef:d6ad with SMTP id af79cd13be357-94408899f84mr736628885a.0.1793269402873;
        Thu, 29 Oct 2026 03:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:93f:23ef:d6ad with SMTP id af79cd13be357-94408899f84mr736624485a.0.1793269402246;
        Thu, 29 Oct 2026 03:23:22 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33494130f8f.54.2026.10.29.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:23:21 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:23:18 +0200
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
Subject: Re: [PATCH v27 07/10] arm64: dts: qcom: Add psci reboot-modes for
 kodiak boards
Message-ID: <sh3b7m43aw5wtrolooxsib3rus6br4rao6wtnc267rczqysyis@75voym3v7emf>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-7-fa4b3ff1359b@oss.qualcomm.com>
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
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-7-fa4b3ff1359b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX+xtVsvpPUVed
 f5sZ4w6dqgsgFh9QoGjj0d/5GYau+iQtJyg4UfdtHGbrSU8qRxsvI6DxogfK3Z2H3Zgj5aa54Sc
 Pvno40jgWhMxfveWupCwJnkwBeJm8EmzBD2GUa2VrFLbsNmbGcmZFZP1Z43eKYy/S3dv5Qtp3wx
 WlX4eG8q/Y08lQcsuaSkyKJkqyEoL3UT8Ko9FkI0TLiwj3etQBeAbbnxEOC2dwdNjm4GttMlbWO
 AIqs9Lo0Jvv8UgKVVg4WX5lMeVktIdrLLfsep7bJXwAOBx+GrB2YdCJS5BYVKClkVcr/B706Rh6
 iLo78HOgJn0QI6qIwPd2X+wIoTcl4n+SkkT313EA1JSy36VGMmE4pul157zzV7H9pymwm5kHcUk
 aM1K+eiiEiDBcIXfW2+wTyb9uMXq/3K9NHwY9gBqEqiWZuNuXW+Q2073PjZsRI057keCD6KYNwT
 EVT0Spzrh7HjIA4jEug==
X-Proofpoint-ORIG-GUID: o2l_Kd8IoPdEQcC-S7y_2835iuAc1YJv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX1pD9/ee2bx04
 gGU2p4rQn907D0hjM2IrbJoVhHvl3EwbeV1dndTfbyfMMSLiGDkx4/IN7/g5Wwe1X8qp85HX+pB
 RM5sYtRpqc4pg8GpDS1Zdvzm8ypfuVo=
X-Proofpoint-GUID: o2l_Kd8IoPdEQcC-S7y_2835iuAc1YJv
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae31e9b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XpayGGiaTZdiRO3YngYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290040

On 26-10-29 14:31:01, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
> for use by the psci-reboot-mode driver.
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
> 
> Support for these modes is firmware dependent and not available across
> all kodiak based boards.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
