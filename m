Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC15476E2
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987619; cv=none; b=tdazDQNXVQ8w6eFbzg0qtkbjNGSZxN2F48nNhGkk0XmTRDuOtXO0bAuqiHPtPRuFjH/oE+yp5a2TViWlVBitEjN9k/G0Y/CpKZo7akuYMjnB03JeCuGBNoJXtZPRysH2/EUvC9OjZIBaWxSkabZjJZX1925GjTkj2+1yfxLIzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987619; c=relaxed/simple;
	bh=j80kBhLRbRT7ilx/r64SHGFnzqerZq897S7NQ9XomzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/kNMcAk+f56ypIT2iCVe3eVg2VrA7GSZjL3XqH8hgw16vHEHDvyGFy2+vc4Gw5qcT74sfk74KEbxAEUF6N4s/yqw7fowAyb9unHrg+weFsIdWOAaL0WXgzos1okL19JdBP45ih0nPriNDh3tBHJ7uOt5i4IA4bBa7CyrlPFbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MyXGonpd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gsF1upJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyXGonpd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gsF1upJN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBXa2l2686071
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RH4UQDQQQqR9Z7YiIsMXW6iMHTA6XfoR0NTlbxmgtpU=; b=MyXGonpdVqxct8x2
	fRRYHn5afZ3HJXqg8GSmATfHiv9+UzILA5Tjh9Y5IERP/2KBniqWnkA0rfthwgvb
	3eGqKyZneCD9QqL679OU1ZMvirfsdXXTKMfkesLDAy8pFkvDmIKxi9KOZgETP4Cj
	SL0PB8NoXl2VNfZkmbzM3Px8mROeXfIiVjfCH6hGsUpxV+Dcr9XHECT43rVDLCMH
	pDyF21DrvJKybbdjPTD9ykXm8v0g/xl/OPFsqKopMxFZ13A23gRCDqIOHMzvwYoN
	efZG++hvTjLpBU+AJ22WP5+7HY9t2NBAMO6wYdqa1gX0eEhXBL3d0M/Sqv2oudP8
	VLAbnQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u1yrn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:20:17 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5d44237e2faso199626e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791987616; x=1792592416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RH4UQDQQQqR9Z7YiIsMXW6iMHTA6XfoR0NTlbxmgtpU=;
        b=gsF1upJNsoSsl110aJ7pyP3sVyqUZAlhdjT+vgrRCrqaO2n3SgfpufqTZfurHUGooG
         ErdcB0OiJzu+TIGpkVZAjFuRyDETqiayM3RUOG/2kO1LNRoxQGNWnD+e4pOM/jDF3kpt
         bucE3QUrvr2Cx6tTmEFPytw0zZR5vPQlOs0NrZoTsr+R1R5TA5A20tBwVl/P7FkYuRvT
         CvgrNJZ9y4s3ZR9qWXZY2bOdegScegIrfiLJEjEJ84cZZo8GQT8hGhU6D5f+KAHr88K7
         dw2uIT63kcva6Rfs723paT4ULohoaNKpZiolCwVYzO/1KIBpCiZr4LLXYFb9d7igAYx3
         XYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987616; x=1792592416;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RH4UQDQQQqR9Z7YiIsMXW6iMHTA6XfoR0NTlbxmgtpU=;
        b=Cm/GSxtLeTeNPJzQL6HaHcsflFD6eiwQLJQo+cmfywEBZqwIzhct6PLWPXoTpKiZnR
         DIe3lILEYEtwO2OV3rlP46tBNwsFNBX5V4ud4U6ZuO8lWWpEpRJog6JhlazRGBO3f31v
         1gfe6TEdeIn3NYJKYgK3B2RliWTdx88a3wbSr1osjd+ODNRk7HKbcRjcCP3x4yXCn34S
         GNDOwVOljjM9j3sK52JuVi7QscV/e14xf/pqSKCmGhMFrkk9seDSogIKW80EL0aKHD6X
         5WqUZDG2rb6/Tk9rpMyeFL0CDUOslfZ9q03L1CFPjDwEr2htD208O0sAPtZa5wgDyNB0
         miGA==
X-Forwarded-Encrypted: i=1; AKwUvBys5mBVR32VFqNBnNE+Wczsr/P/R+SyhJSpZpxCWcK0cKV8a+Yb/zrtxNkeFkvOh/5+D0EyPfce9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTIdY0kR6w6aqlwtNEyD8QqOFAU3VGFo0irsGZDecZAWQXGa/F
	SPxFkeGkoDjdCfvziL2zanqPBCOb6ycavFLu+dSgXmcYlsdQSS9/JNKgz/IFxrSExIPJF93BuGB
	qHZaCd4EUkn/YnVSKZQc1FdK0uTq0CUBoWQ/3Zu5BUUcTyEJ1Ipl7h2+0N0qZpg==
X-Gm-Gg: AYBFou0Z+CXOXO8zp1FgqzHCdzfiSP4Cqn3ldW/WeqWfkokUMhUwAfanoiJHneWYpXK
	oNCzwPXow8mO8MYyUY22tlUosooAp9uXgYTCOh6XCnia/7Um+jBc1sLQx3voVKevBWeyMfxRkXG
	gKCc6bNjKibOUYVzYUU41zF5e44CUo3b5V5ba8q0dJCPFwxRYKDwtIVY+cWaP13oFm23IMPPj68
	HZJUl9vHPy8GMPc6deeLyy2GSvFkV2aovHOID1mBU+CCnVYWCLc3aszfGGjK2qDvSWjM2XuiJBk
	tOnR8+eRqwBX6xLUHwOILIOvgWHF7bgdfHZ71YFO/wdm+r7k/oMzNqOF0GvVXGx4zQl60G9re1Q
	pBKDnp22F2LcggQwM+QYqpA==
X-Received: by 2002:a05:6122:4659:20b0:5c9:f6b0:e5e0 with SMTP id 71dfb90a1353d-5e91f45e3edmr3486336e0c.3.1791987615898;
        Wed, 14 Oct 2026 07:20:15 -0700 (PDT)
X-Received: by 2002:a05:6122:4659:20b0:5c9:f6b0:e5e0 with SMTP id 71dfb90a1353d-5e91f45e3edmr3486296e0c.3.1791987615096;
        Wed, 14 Oct 2026 07:20:15 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae6csm713353366b.17.2026.10.14.07.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:20:12 -0700 (PDT)
Message-ID: <2ce49c83-b861-4a0d-8412-e8b3ff33bdd5@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:20:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH DNM RFC 13/16] arm64: dts: qcom: sm8650: Describe clock
 controller power rails
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-13-3041b788e9f7@oss.qualcomm.com>
 <su6pmts36qj4hogxfthkrvjr2aod2r2u33onxifqanbarxk3tc@36qoces4rwor>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <su6pmts36qj4hogxfthkrvjr2aod2r2u33onxifqanbarxk3tc@36qoces4rwor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX453ktXPdapGJ
 Q5JHJ/4L+xgBCdqe1ubUFnWZtuV0n6aCjufY880PjjVbWWMVzGLPSNwqSIY7gWIDUhcAHsk1ITy
 OrX0Vyk3wkcyIilAjvOZhe2hOsekDVc=
X-Proofpoint-GUID: Jah7T6yjXYhU6gsHvxl-xvEPHmCwAHBe
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acf8fa1 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KR-LitqThD-uOATdN6EA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX+UvvjsoHybJf
 Pf1qn49JMR1D61NIpgDiguVvMl4Rb3dbF4d1SJ1ZPMDAGGjpNWC7TbMcwiLvm1CrSqD/LZ5XTSw
 3t/izftxx8gGaPQ2pb5Qhl5KuWgnr0UXXJFLzWVnmPfncDnYqDlQWxM49B0aBlQBO/U+CWREYHb
 wIQ/LPhcGCqGHYvG494YcM2tSXpT8nGlcqPptJHzjMuj16fOwI6iXkV/bdynt7HV39AFxG5UhFK
 YiSO9e9nUmPdLXM1rktH3dq42NkftVbi1FJmAJ8th/qYTaTgbJgwO+//eyoTyfjZm44OqMFYX7I
 8AzRHVpzra1pxBFThFOq7ibfi6y1zd5uNGbwbtUN+IiPNt+AGwCkkAGt8pAb1j035aKc15Zn607
 KBl+qwhR5OO3GGavxwyRNg6MDH3Pa9rcHh50oNjP6zjiJojvxfydb4hZW7jquUgAkNLNonsZ8pd
 okM96NbSltMlzzBpy/A==
X-Proofpoint-ORIG-GUID: Jah7T6yjXYhU6gsHvxl-xvEPHmCwAHBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140057

On 10/14/26 4:19 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 14, 2026 at 02:19:13PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The SM8650 clock-controller nodes omit rails needed by their clocks and
>> PLLs. Without those connections, the clock-owned DVFS implementation
>> cannot attach its voters to all required domains and controller probe
>> can fail before any clocks are registered.
>>
>> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
>> Assisted-by: LLM
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> @@ -6049,8 +6055,8 @@ dispcc: clock-controller@af00000 {
>>  				 <0>, /* dp3 */
>>  				 <0>;
>>  
>> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
>> -			required-opps = <&rpmhpd_opp_low_svs>;
> 
> I think this is neccessary (at least on some platforms) to keep MMCX out
> of retention. Even if we can drop it here, I don't think we can drop it
> for older platforms.

MMCX exists precisely to let you turn it off, the clock patches
retain a way to keep the clock on during the runtime-resume of
the clock controller driver

Konrad
