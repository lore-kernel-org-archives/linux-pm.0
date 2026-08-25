Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9B3E5EDB
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647924; cv=none; b=ou0or9v00ukRYtaY9qjVei3ouBbfv9eUPCegLJn8vqpAe86C1+H1rSdwWBIMixGSc6In0ravVSwsHRpuWyHCalHuIR41u4NdCUGdrJbj0cF2H4Irs4ikx4B+O6n5YGaVow1kh3bpwfrSA1mrGiryw232q5V+VC/84OEujGdEprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647924; c=relaxed/simple;
	bh=6l/ar6VtWuSOF5Ur5eLuXNtonfRhOglZF7BhKJeBwmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSAs2I2ZhhxkuoOtRiuotHRTSCSW4DdOmUzjC1TeRimlYSIdHjVZ8pPpkcbWGg3UNEHZbfrzZnOOFLkABTO+TtJcASUZIpq6DVAz2AhDHB88bfy/0bQ7uMfrSuWHrJiq2Mfscpiw7ZFEwZiZjQ8g5gIAJQyAi3LnCNK89z17nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9yAWvrm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BGvzUJez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9yAWvrm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGvzUJez"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88MPl2387935
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgB7yaSZtpbG5TGbfXcvFLBda9vt29tPo78UILrsgY8=; b=a9yAWvrmpdVOEnOu
	W5eTUgeDBg9NymrQev6vB843wQjdyPRfb1gpwVwT+WPnUM8ZTMQrFu+EaN2qXZWB
	UmbobmW3PR2Obx3BFqSWvMj8A0XlCWlRs0FGK9JWhovce0NQ9ZNFDF9odPwMoHxo
	Yy1LasQ6pIP6D9+ilYr18Qm7lGJfkOvHlY2BtFgrbHIQDbAbmpUDKc4E4dz0uhpv
	XcJ2qPt1dpHbRIjPmzs/MStFrzwqEjBamngtHXUqDhhjeBMtfy9bCkMCYNHq6y15
	Ui58DGOAMOzoUDP5f1TXPVp3yNDico/o1v+aBVRQ2puloL2KheqV2jQA3y0fFkVw
	wu22eg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8swrb4yg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:52:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c9d953b71so7958211cf.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787647921; x=1788252721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgB7yaSZtpbG5TGbfXcvFLBda9vt29tPo78UILrsgY8=;
        b=BGvzUJez+/oIh4Jtw6c5KE7hQMYJa8220NWbjSzWrDdy0fYT03MuZgjltzPJYUCPc+
         VF1eQr2wLYnKAs29RPtIu2I10ef+Eg6ddEDaMrT9ebIwjrob/I331F76TlsnPkTo2858
         8IRuCCgZu+gXdJ/fdnT8dHTOmZqvgVZCK5lgUjHIZIaH82niwX8Pbhvaa+N7WkXi5RiL
         xG2M0RJ6uiVv786O9zmQrprGyLHT7cKL+3lT9SwTXfVYCDwgUAGnuguAFuVM2ivqjYXD
         T1KHjRUHSCMnfyI/sadtB/8xzG4N7dqXUIwBHkOjXXsa6gA+w3Cwl7Z+NrJGRpWPEVhY
         jIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647921; x=1788252721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgB7yaSZtpbG5TGbfXcvFLBda9vt29tPo78UILrsgY8=;
        b=DAvGz952EGhxRfjMHebysNYg4ha6OUPA/FzMqWJqonyyVzooPu4+F8jo//ihMTFetb
         5hQ882AZ1WNxWaz7iOSycsiPBiQy0GU58T+agfDbb2ym5xi1HgMxWJiV+8QB1bMMs24T
         Es4an2pC22MLqaxgFvi7v8oJ2AMrV//oHdXJt5lj1JHkUBjzqPd6ywSmFCG3ibLh/Olt
         MvteFJ+xgqUYy0nirwVBM98yTYg2BLprJwvNVaZduomu7i2ZZ7KhjWfq53quPZsRHBJ2
         DsIEh4GU+UjhjBq2hwEH5D1T8LqVF6kvNH8MpdgbGDnXavpLjlgHCpDXDBq5YubyJv5V
         2zEA==
X-Forwarded-Encrypted: i=1; AHgh+RqUpSMQK1W/xocK8jhmI0KkggT5es3bqP3Czfo+3z56pkPxOoE+kz3HPz/pruj7l9c8v278a1RYMg==@vger.kernel.org
X-Gm-Message-State: AFuF++nMkA6euzaxWU7jwnr5GAKqde09A+ppL/5doKiUXjNXQoFGyjHn
	/AMcoyCQVtkLrfq1r9ftVGNASbbwmbNG+OgDP6kn79WLmTJp2GUci4inQQgOfB5t1m0g0WM6oJL
	6cHo82pJ5vkTzxF6GJKrGWognypNS3Fz9Vl0DX11Cb3ErTTohw/2bApqUxbg/gA==
X-Gm-Gg: AR+sD10srEBspnjUYbxVhB/HAF9TWicHaQrC5RP+7AZUsVx5w2watbg2j231cMZJJ9j
	X4LUpMoRiqIYDG5vGt4JBm8A1jo2nDjB7ortVoxMRjx7pHj2ot2u/u90hbWsij2V67clUCm70Tu
	uZMEiY+qt+qgBTLCTtbQ7QSjR5m/HWRiObV+WOm5ZjDPJwlMbB1Y+7Hx1eECwmRESoM42+QZwBt
	ejKEyPZDe3ULwWrsIT2RXGIV1qyhoikc+y6UKZC2LhewLUC40LeWg9i4trfzi6TZo9Dwiljcjqu
	9fNxZxgWDDfhPHay18aqHoPxSei3jco4QK9hSqnUKZbVdE5v3MS3kbAvuDeFjg5AOZJuF9utc3r
	fD6BWZhrAR1faoGT5DHgFhr5X
X-Received: by 2002:ac8:5a95:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52df565735dmr226226251cf.2.1787647921399;
        Tue, 25 Aug 2026 01:52:01 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52df565735dmr226226121cf.2.1787647921022;
        Tue, 25 Aug 2026 01:52:01 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm1723722266b.49.2026.08.25.01.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:52:00 -0700 (PDT)
Message-ID: <7bdbe740-365e-4a1b-95d7-23fc9bfe2cec@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6125: add TSENS and thermal zones
To: Roman Linev <admin@mswin.me>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821030325.1823829-1-admin@mswin.me>
 <20260821030325.1823829-3-admin@mswin.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821030325.1823829-3-admin@mswin.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y-W0phT-zLmFVBV0t0Tt9sfCoXZq8r9J
X-Proofpoint-GUID: Y-W0phT-zLmFVBV0t0Tt9sfCoXZq8r9J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3NSBTYWx0ZWRfX6Echnsm4OvpO
 zJ263nrjIW9mV3VDFsTO9Jw+GZNBJ+ciou1Br9cIROWvf8couxO2SBu0QVdAfrISTVNjxZ70ZH9
 5RgMDg3bPdRRoflmnNNJLAPxtnQAzvE=
X-Authority-Analysis: v=2.4 cv=TqPWQjXh c=1 sm=1 tr=0 ts=6a8d57b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6K-g0nQMaYBz6PROOyoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3NSBTYWx0ZWRfXxfeb7UWYMyBu
 nXawXt8F0XOGPLFeQc+Mq9vr70BdLnTcpUpKDRfaOVhA8tHTSDxyPe+N0+asg8iYG+82kvgAugn
 l6sny30vu++iw8KIy2FdJdB/GUYn7XVuwOYZ9R9MgXDHqTc+JDOU8fy3NVsq8LvL2s+Jb0sUpeG
 fO6Dh9OMdyKO6ENCgBIclBILR8+aPN8ETZ74ne1+AY1aKpCms2bd7iL3L3gmwZNHsYPqHMgiyyx
 U3iFIS4bwq1wpiExtWxjWYjNiMZnlHp2klsnr1FgHLZtzh2DmOdvGzWJbxNQZ5DWqT7mEx0nmCc
 Ho04TPuXW3DkrTBQIGbYjB/c1BmovWUtocHOu27+shi+l2QBznhdpconPKivRZYiXYLqLpb2aXb
 vwt0gygsZYIdlLxX/tHHzmDsGuTTfmQeoXrmYu1IpcX580ngQrH1yvvQiwx0ZD95mP68Msyj+B+
 djRnyrq5kS7BznwlApA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250075

On 8/21/26 5:03 AM, Roman Linev wrote:
> SM6125 has a TSENS v2 controller with 16 sensors, at 0x04411000 (TM) and
> 0x04410000 (SROT), with SPI 275 as "uplow" and SPI 190 as "critical".
> The register and interrupt layout is identical to SM6115's, and being v2
> the block self-calibrates, so it needs no qfprom nvmem cells and no new
> driver code: it binds through the existing qcom,tsens-v2 fallback.
> 
> Add the controller and thermal zones for the 15 sensors that are used.
> The sensor-to-zone mapping comes from the downstream device tree for
> Xiaomi Mi A3 (laurel_sprout), cross-checked against mainline sm6115.dtsi,
> which agrees on sensors 2, 3, 4, 13, 14 and 15. Sensor 5 is not
> referenced downstream and is left out.
> 
> No cooling devices are wired up: SM6125 has no GPU node upstream yet, so
> there is nothing to reference. The zones report temperature and carry
> passive and critical trips; cooling maps can be added alongside the
> consumers when those land.

CPUs are good candidates too

[...]

> +		tsens0: thermal-sensor@4411000 {
> +			compatible = "qcom,sm6125-tsens", "qcom,tsens-v2";
> +			reg = <0x0 0x04411000 0x0 0x1ff>, /* TM */
> +			      <0x0 0x04410000 0x0 0x8>; /* SROT */

Let's drop the comments and make the regions 0x1000-long

[...]

> +	thermal-zones {
> +		/*
> +		 * Sensor-to-zone mapping verified against the downstream
> +		 * laurel_sprout device tree (tsens@4410000, sensors 0..15) and

Very good

> +		 * cross-checked with mainline sm6115.dtsi, which agrees on

This is a different SoC, you shouldn't rely on that


> +		 * sensors 2, 3, 4, 13, 14 and 15. Sensor 5 is unused by the
> +		 * downstream tree and is therefore left out.

and the docs confirm that it's unused

I think this comment should be dropped, these details seem more fitting
for a commit message

Konrad
