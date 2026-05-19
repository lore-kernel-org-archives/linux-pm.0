Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD263F1ADA
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188297; cv=none; b=hKdQr+fIx3Ng17rC8RFgPBGbkTsb0P5Ot+T6LS3Cz6HcQnVvVjYvpSDk3uBvSmJWCh2jpMYc9UqrRvbZV0UeB3upMb+gaMC2PxV8OgrwKp4qN3aJ+v4I3sKX/hvnKwM859jLfgVi+KqKeJrhAGbyOljpTYqY2C4h6Frcyue2xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188297; c=relaxed/simple;
	bh=ivr9ipTg24AkNx0uhFxVMcVmRDcV9XkgIZgCptTgJn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWtB1SFyVfZEAYeB531sP2hGXqOlg/xsqsf/aTsC1lVvLWJgL8po/5KhkjEjHMut3/tmEgT2iudyAfnjrIrEgZsHv2zvlbhSgf7s2iNSfN70l2UQa8EnOJaYj2eaS/7bhyOHQV3K4xguQC4BuP3lyu54KZtEEBn7EmU10oeqSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHWGZnTg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jw9DeTNx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHWGZnTg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jw9DeTNx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9kvjV1257084
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ivr9ipTg24AkNx0uhFxVMcVmRDcV9XkgIZgCptTgJn0=; b=kHWGZnTgt24P1dYQ
	5rF3LkhUQ9IFOSwjG/8+t8ftWHWM4LDIf+YfR3hWDbCEjgdevrqxRnB2DR8K++Ye
	1YHDAotxK/QOD8mfCgTb9ImQ5MeVNGwnohyb8i4u6UBkTGCFP4lEhssoaAg18mwQ
	LlTm+zgBWMpzRMfDyggWgL8FGjvyRE3DIb8KR2gi1GngK/OTymSrgUH6PrWe6FX7
	rRLNGPnXucuCYdK1BrxGeDJvg5npJdemhw4V3P9PsFTt5sizMyPO2lRRFqPAOWDr
	2nn+6DAlpqzQy463XYu4w5WWqeoNQraEMZqXFABAlunpQtkdBTTx9ZOmtF9S+u4R
	d0O3Fw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj888k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:58:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d9f1bccd7so9815521cf.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779188290; x=1779793090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivr9ipTg24AkNx0uhFxVMcVmRDcV9XkgIZgCptTgJn0=;
        b=Jw9DeTNx+4abzzqkJTHN+pZkvcY9pkc74udPPrP0LjIYZo7HmoeNXd2XrzOMo9bZED
         aRwavwEIZqcOc1NHCKl37zUfFLsW5RKbaB43SiQSPArYcvLJO0YjYADUhvBNYQoSzp6P
         auM0+BJiWgNekrD72eZZcCyVZBXrVhUn7ktpendLhr5bw5WmSC60WINnr6HsZGtmwkTF
         any+lQ036Mgm4bMI3cEmVshwWtBjyxoyT5sY68rIgNvaOFcKLIw+CmxMSedOW5q2+Op8
         HBNHyysnlF2irXtIKwpBVwUhJVvLUSuqpbn4Bkl0947zk3ZQN2uAmiVeSXDN/Zt3f1mH
         ugIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188290; x=1779793090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivr9ipTg24AkNx0uhFxVMcVmRDcV9XkgIZgCptTgJn0=;
        b=KeWEUN3I0NqQtblLCuEFaQiBWP6ui5rOU/FXVoMKg+uoU/eAgWVt3ureaHfhO5Tk00
         KhrWm+py+qxH8/sm9Yw3NohbmW256h0S4pOnDfJn36tKeHSQ9K/6pLiB40Ek8fBkIHrL
         F30DGQPAkkomrt5ZBx9gxap+GQhLRPoBLqKpNYTo79wFa5mhMN/+IfrJ1LGRHJ5MLEt3
         Y9Hrcosm5uyBWOsNIBs7fBfobEkvIWY7qJGdGovSE9Cudv1iYNmByDnr2g1Q5ilMqZlM
         8Hbwnqpkgmd7Lw2f3CItbMYs5NpMe+8KtY+sLcHBUwydgkhTFsAXcpkfNcIixmDBpKpH
         1yqw==
X-Forwarded-Encrypted: i=1; AFNElJ98iSs4/sb02v/58VUzRKZWD+8lbkiXI0tQy16C3oMHv+f3jS4oyfCl7zfzOnqm8aH6uKRk5ee+HA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1u0/c1KFPYfs996oXUGyc99ROe5ocUM0YuGwa6ITDpT9TLNSb
	p7CK7VgDYIFy3eNGlXJBZjAvvSyo29FIkBSMjKtBK26JGSt06IAw6nmdQ1bnbyWa1Sm58jzhJjI
	N4ZQa7t9NBLF33TC8n9/vsk7MmYgY2trCb/3WibIwyraWPAWXgSZbnXPqkHYQMQ==
X-Gm-Gg: Acq92OEU1frg3kvgyYpmTUtwWdt/32dbRJQgY9cwrSRvkVUv1Uu2Nyo/fALiRvdkRyf
	GG6IXtJpbaVGITORASetij0XFBvtWwCUMLIJJLyVbodcphk9xxL4MEAC74p/HEW6LF4JQmCWhmy
	xq3g9bZMIuHDqz6a9CVXOE1KPJefMqOri2nrVXQwDlUtD2LEyLaOLJyPnsFqp+fAtaPP+em9+/a
	RBAJpHF5syISDiISIcM7DLT8lS6hEQLTV5yxPchiPVmsb6k5CRsiz0UBcVN5gzsba4drHYs7Ncx
	UuMbYlz1hosQBxa29AOg3uUqzceb3O+tht4gfmks0TgK6+d6ODBwjD6kj3IZkxrowL/UxscujqG
	Z+upQ/LficpIxrxYqSUsXSVUp2N2Tm7iUA8Hm1RNcoP+S8dVsB0nRxM1+3bahdlZXUYRUTiw/OW
	TQiLk=
X-Received: by 2002:ac8:58d5:0:b0:50b:5286:f757 with SMTP id d75a77b69052e-5165a0dc373mr190342911cf.4.1779188290580;
        Tue, 19 May 2026 03:58:10 -0700 (PDT)
X-Received: by 2002:ac8:58d5:0:b0:50b:5286:f757 with SMTP id d75a77b69052e-5165a0dc373mr190342661cf.4.1779188290176;
        Tue, 19 May 2026 03:58:10 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c2a68dsm701110166b.18.2026.05.19.03.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:58:09 -0700 (PDT)
Message-ID: <91832aec-22f0-4244-9989-39bbd8defb24@oss.qualcomm.com>
Date: Tue, 19 May 2026 12:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jishnu.prakash@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZqZRwBYKJp77HwzFjOyAII7ZWt1AgHrO
X-Proofpoint-ORIG-GUID: ZqZRwBYKJp77HwzFjOyAII7ZWt1AgHrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOCBTYWx0ZWRfXyn4hjeJ3vqi2
 T0S7eSmoJLjtTSkxO8lJT7okVPv41988426iESBqVyJoqK6rMuoJMA1pGxUi4oU93GJBK/Q+twB
 qHUYfXbBIKLiKrEWx+iC9EEQmt/HkTQOHNLWx+vLFqEd7uSY6ddTD76ZVBRJFlu8oP+64Qns1a5
 DGcKS7nzW2P3dMG5uSVMZZNSTloFztQwEzYGtPz/nzWafUyRQhIw6d/y8rHDbB5ziHfqD/nh6fK
 nlTSrEPkvHdgllQrLqW/oec+gIakBZ3MeQ02Qla2rDK/31kNHgeJU1MgOoqQjk7ghcOiG71g3zy
 JbOqHz6wiC+huTxVir95q282YxTlvMvyLoTpKZCXD7/UOwifsxKt5V/hZejimcUbxdaByl57SCt
 vANGjImI4pTqiiHXZcw0KnEpGxNknSGtqsA5+cvnp4oB95xaAXbgeX3DufHon/EhiH2lrnLpEdw
 sXSkh3g5icAhrcWguvg==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c4243 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=WGUvbcDy2-o6vtexG74A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190108

On 5/19/26 8:59 AM, Rakesh Kota wrote:
> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
>> On 5/18/26 3:49 PM, Rakesh Kota wrote:
>>> On batteryless boards powered by 12V DC adapters, registering the
>>> power supply as BATTERY causes userspace to incorrectly trigger
>>> battery power-saving sequences.
>>
>> Does battman really offer no way of differentiating whether a battery
>> is *actually* present in such cases?
>>
>> What boards are affected?
>>
> Currently, batteryless support is only implemented for the
> qcs6490-rb3gen2(Kodiak) board.

Does the firmware report anything obvious that would point to this not
being a battery, e.g. design_capacity = 0?

Konrad
