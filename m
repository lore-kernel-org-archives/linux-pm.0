Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C81A6836
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368509; cv=none; b=Bq49MhhMzP6sBLS0fhN1DXXRAV2iKYVhYOG+PKJ8MAtfOvi29Apq51f6rpT0r4uejXNKtOH4qLGOUvXexbFG1MT9t+Fw4bDsx8fNF1m1lkqiZOs7OIN30wL/BRR37xKJxWmU9BX0hJOJBf2kTb+sz3ULb1zPGIcgrl0Rsw2ANvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368509; c=relaxed/simple;
	bh=/FVPCvLu/Bseqi9fPAvsX2gRV0t1daG5mjpc0J6y8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxczBb/t8bV87Dk/qHN0M3ZHXsQbsCyNlMQ8Ro/m/F0Z66Ec1M1rg/18RCY8onKGB5u6Y5fO0Q3H42uuhKjyl5iEA1l++wBXRBEO5wFAvKyqb4l7f0R42RA6TtFoHkK/JU6ZWLDkGRvomR3Fs/GH0LbhL0Wf8VvLFxpe1rpybeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owlMCLhX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMV9MlvX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owlMCLhX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMV9MlvX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ILjZFV840139
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8250laV7NoHPv1ek4oGHhuKA
	b0fpGnJ3DhEPzSMYYSY=; b=owlMCLhXn1S3fR1fNukDBp8dTHHT2qBp9oKM0Od7
	BEDWcyqoU5lilYaK/XhCbIi7R2GX6TTlNtPTTfjeLxWvbVU+3QnGf/SRQx2flv7A
	EaI1rFtwCJTpEZGUnTBnmUaUPkaPYXWURffDvB5VJkbQOBJUSwbUYKdAZTkzsgnh
	lecdb/VRlmdBErGRK3vH2+Tuibyyk/eqwIwV5yJr/Qt02IEN0NWE9giheS0k04Ea
	t2LpsnxAV63+i75uvzUe/ul+WU951vuBfu8DBB5oysFq3qRwSDO4xTJn+7ZKwVFy
	jnstVfH7ctSH56T+IKPNE42XT2jmnCI6apPoSM6Ce/QA/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w188p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:08:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso139066285a.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792368506; x=1792973306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8250laV7NoHPv1ek4oGHhuKAb0fpGnJ3DhEPzSMYYSY=;
        b=HMV9MlvX5Dw7FleuRZYNac4WTtbxDV92SiF2WY+FAlChIo3G3BxaJtX8IPtfYO7An6
         18i8VV/cuRc5BIp2Fs8JXqs8B8k5sVMsXTaE29cCaMSQqjZ94a6KHH6VrUJomG4ZvuoF
         VGUBVAtACOBm2LEzOtnlkCh6k8EamseL23POC4znvlEjWzYZWqCowgEiDGeTZcLZ8nXE
         Hgp7CSxEzPKloazsZSJdCCT7p6LAw8ACcizg6EB1E09zhUD4uBYVIrRTVM+2+0cfIIsT
         bZ3aLVKIcRpZC/JD2L0upw+pq1G7Z2TAeV4kmhT7YXPLSNqMH/gCohjU1sYcubGPdbXS
         h/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368506; x=1792973306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8250laV7NoHPv1ek4oGHhuKAb0fpGnJ3DhEPzSMYYSY=;
        b=WqmlMGKeJ8UEJnZ0Hhq0Nuv0kG/jgriwlbc/Hkzv+UUfS92/0BtHAT6SmY5tFmXZBA
         iGao9QhMfAK7GAceTMP1+/8iqMFsTAjvSYMBnffljrFoeYt7GHopOjvf3jVB+LVqSJc5
         OD1QIlk7J+B4xv9iLkgwEl1fqtpDwx9mNIhu4gX7tWYlBjGFdGs5mahCUeFzmlrhV0Gj
         Mnl5WFTB4d7VHdKjRxQSA2jpOThMmAEmPrcIou1I9v5Qw9egr6LEyT40I7PXJjxGOgRz
         R0PBf03m6nA4F33aGXutO4DVZSaj0lGgoTxrnblbAj6DP2ha/DvNLU+CGMKJsczz0b93
         wWRw==
X-Forwarded-Encrypted: i=1; AKwUvByBmyqguJzdxcQ1RVePYfkYNQQubIPOV12zbAa5wmKgGdIaedqH2+MK4FyW9bvN48GACvAjsy6Skw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLVAn2qTZD1tb3hsPz43YJZ0N+B8GyIdwFKwFPhlro6d8EYFKOR
	8qBlQDkVFv4n753KqGFG4Ew2WiYYiNjYI6n8z+Ndq4kjNe3ETbQt8EpaaEoYcvu/XwHVFs0lNrs
	BbcYpdPuCJM5IgZnPxJaCOqJ3RLy2Y0WykQK7IfDrSaAQ6cEXo1ooEsO7+jSF5g==
X-Gm-Gg: AYBFou1ueWaTi9znvQnjAWsSv51nGdqGtWBKQrq3GFi3F6zXukPOoVpvi9f9IOWXabf
	FInCwrgaApU/BB21aLRM5IZU28syxLkIsPmGJzmjy9NrlIu01Zu0q/1bhFpJBeCIrsTFbYTC6QJ
	phEykGaeY+mS65eDZs2YD4YUuCV/nI6PyChRyRi6bXYAB0loFmx9zsmX7Ojhq70+vHMU/fMy7kV
	Sl4WFmM/oJswaa/SnFYLjeH1fDqrEIwWHTEarxF/Q0/rYAx1o9PAayPTpavc2xlqd1PB9yAWra0
	0+QCO0KVA6tLZcAOruJjzsfT8DhrYSDCVRmphX7tDF4XXAIoEwig1J5SLKJi6YOfzAf+3bn2bP7
	3gqyVZgqJia6Z2+fjmyPW0ymE5Sts9Dghlg3Znn3+SkHkM5Z/j1KB1b1yQK4zux7AYGWou8rHxT
	Wkm2MfPU0/g1fD
X-Received: by 2002:a05:620a:284b:b0:93c:7861:675 with SMTP id af79cd13be357-93f17d67161mr1577008185a.1.1792368506506;
        Sun, 18 Oct 2026 17:08:26 -0700 (PDT)
X-Received: by 2002:a05:620a:284b:b0:93c:7861:675 with SMTP id af79cd13be357-93f17d67161mr1577005585a.1.1792368505984;
        Sun, 18 Oct 2026 17:08:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a644621sm1653149e87.84.2026.10.18.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:08:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 03:08:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robin Snyders <robin@snyders.xyz>
Cc: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Selvaraj <foss@joelselvaraj.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: qcom_smbx: add SMB5 support
Message-ID: <nbdom5guixhijbbcrsj4jolk4bemh4ccbcqkrhe5ka2hf7naad@lxxiwac6g5on>
References: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
 <20260813-submit-qcom-smbx-send-v1-v3-2-27be0091d7c7@snyders.xyz>
 <hryxv7fl3alrhnekb7bqn5zgexdyv3p6ndug7kp3uqxsiiwmsv@wtvg3za3qspu>
 <7e5c96b8-e1ae-4819-874f-db818061be58@mail.infomaniak.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5c96b8-e1ae-4819-874f-db818061be58@mail.infomaniak.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAwMCBTYWx0ZWRfX7AZcY81hLDVk
 Vjzo7tw1hAxs4oYjFRiuSdrxYn7TeTho6+kh8OTBtN/Gb62ZyvB+nrttMGHOAVzrR16bm+4p+VQ
 W5WCma+jJK+WnThAl+7ILj8V7iZ8pqc=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad55f7b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=fC8HO9TX6ddmVSSzZu8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAwMCBTYWx0ZWRfX9+P1UhHW1IsH
 alEtfj84SCX8NXKXpVlQTmJc+EVTv6IJZdnLwh/dnRtsy66jHt+2icWslVnLxeBLnlsns1RTNlb
 yDRHdUwVwFymXk0ONBKRy9mJjLzKGjKJGDPkkizOztQNsXEKcika8E5eURHVK9YbBB3H5E9gRnK
 5V/YAW4p03qGTEIBX5iDYb1nWQ15Orn2q14qAIpkJIz1nGHi53gsgZd4PR0Wou6Cgm6AUhfuy9O
 0hV4QbZG9aKxVAm2lxEQxd+GGQdVrDxMBYRMWzD5nrzuZxbRMv/QPXPXx9giEyUDfoKTy8zixpu
 hZ+1bLmjYQDE0OWZ90l7ziGTNLsLOatMTmQgTFoP9QY9UuYPYdSMKTzE1O+LNhJeb8LRyY9q7cL
 RGqcDbPUaoraWJZqtQvEbIihn9RecMizDJP44QeoSiELzMsgoGLer6lAD2/luhVa8X9fRAVdWXZ
 13TdsqRtZlKlJV+fFZw==
X-Proofpoint-ORIG-GUID: s5NQjyyofx7F1pPfCoookFO6MezQKUVF
X-Proofpoint-GUID: s5NQjyyofx7F1pPfCoookFO6MezQKUVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190000

On Sun, Oct 18, 2026 at 08:44:59PM +0200, Robin Snyders wrote:
> Hi Dmitry,
> 
> Sorry for the long delay in getting back to you on this.
> 
> On Thu, Aug 13, 2026 at 06:52:24PM +0300, Dmitry Baryshkov wrote:
> > I remember that in SMB2 case the TCPM and charger drivers were
> > programming the registers from the same block. Is there no such conflict
> > on the SMB5 platforms?
> 
> On PM8150B the register sets are disjoint. The charger node sits at
> 0x1000, the dedicated Type-C port at 0x1500 and the PD PHY at 0x1700.
> With SMB5, qcom_smbx only writes the charger core (0x1042, 0x1061,
> 0x1070), DCDC (0x1108, 0x110b), USB input / BC1.2 (0x1340-0x1380) and
> the watchdog/AICL timer (0x1651-0x1661) blocks. qcom_pmic_typec writes
> are all in 0x1544-0x1560, and the PD PHY stays in its 0x1700 block.
> 
> The one name that looks like an overlap is TYPE_C_CFG, but on SMB5
> that is offset 0x358, i.e. 0x1358 in the USB input peripheral, and not
> the Type-C port register at 0x1544. The driver only clears
> APSD_START_ON_CC_BIT there, so that BC1.2 detection is not started
> directly from CC state while TCPM owns the port.
> 
> By design, the SMB5 path also leaves Type-C power role and VBUS control
> to TCPM and the qcom_usb_vbus regulator. It does not touch OTG/VBUS
> boost, and it only clears the HVDCP modes so stale firmware settings
> cannot raise VBUS.

This sounds good, but also a bit strange. As far as I remember, most of
the QuickCharge protocols require extra control during negotiation.
Basically, I'm afraid, that this way we can get the basic charging to
work, but not any of the quicker charging protocols.

> 
> > Have you tested that this doesn't break the USB-C
> > dongles being connected to the device?
> 
> - Powered dock: the phone became data host and power sink (USB PD,
>   usb_vbus disabled). The USB 2/3 hubs, an RTL8153 Ethernet adapter
>   and a mass storage device enumerated, and a 64 MiB read gave the
>   same hash every time. The charger stayed online, health Good.

Could you please check in the debugfs in TCPM log that you can actually
see USB-C negotiation happening over the wire? The same applies to the
next testing point, the unpowered dock.

> 
> - The same dock with its external power removed: the phone stayed
>   data host and switched to power source, with usb_vbus enabled. The
>   hubs, Ethernet adapter and storage re-enumerated and worked, and
>   the storage hash matched. The SMB5 charger correctly reported
>   offline/discharging.
> 
> - Then back to a PC cable without rebooting: device/sink roles
>   returned, usb_vbus was disabled, USB gadget networking and SSH
>   worked again, and the charger resumed charging at its 500 mA
>   limit.
> 
> None of these transitions produced an oops, lockdep splat, UVLO, OCP
> or OVP event. Ethernet traffic (no cable at hand) and visual
> DisplayPort output were not part of that run.
> 
> I'll repeat this on the exact v5 tree before sending it, and summarize
> the register ownership and these results in the v5 changelog.
> 
> Thanks,
> Robin

-- 
With best wishes
Dmitry
