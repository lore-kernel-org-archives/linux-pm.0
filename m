Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCB42EEBF
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379602; cv=none; b=W4cW2RBE9w+sYV2Hex27qIs5MVrtkrI3Euzgq6152qJRK78J7Y/QtYmPJIUrhWxVL90TlLr+XdUfnJakCoBWp+S8PZzaUzMzI8l/GJGAIq/HQS5w0rmEVNCOD5O+pksUTJaDwGsoKeUk+42eQxzGAWNEF/2RJogDk7qi/3WUb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379602; c=relaxed/simple;
	bh=EUSSJ1Q91B+Xx9zDjKC/yNPvbAc5HxjMoiAETTuP6HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/lZOk6Fb/+GW42Ooy4Dsw7gRwVcAX1ms7+TAGqpEwCAnURkmSeMYI6gQL21jvdyqFS3M7GqelD7HKpMy6nj6sjgov0ETHDpbftRC7rYqeYFzoa2/ax7JwBjwgRh+al34yzbnbiEGuOFGzBxm0mChF1H1NS4rQFF0uo0D23FRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=orEIIWdZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a68vZJLk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="orEIIWdZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a68vZJLk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7urcB3968052
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 12:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fylLG2wwQxPhuCjUzW2jU3hgZkUTYpwG6DpN0l0UY6o=; b=orEIIWdZySpVRhh5
	Cf+JGLisyug1Y3j9mI/t/kiROECrg7f4P3964rlz1aTuj+q+gEvx3U4GPhveIFUp
	LqPIpGZfdfQdP1Kq5eLbIJ1osgrsTLutwKkPedYmbaB/hddqgGBRBhICzdotGM54
	7F4qiv84RzxAZtAfToG33ZOHaQ6MXPGFyaXUV6fWL2F0ZHKXph0jnuLd2guXN5o/
	f3yMvhxGJAGU3xKZZGSLY68WEJoVrifNHqyF290JiPNWipRSfURd+TmmgVOs+6Pv
	hjHK88nSg0EDc0NxHbVR0L9cZrHw1ogztkj0/p+nXKfZ4HKxgYR7/hqkcTtKnZMG
	mmDobw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0h1dm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 12:33:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f780a13c9so8433974b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777379592; x=1777984392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fylLG2wwQxPhuCjUzW2jU3hgZkUTYpwG6DpN0l0UY6o=;
        b=a68vZJLkfH2vsvm8dHv0k4pGa8sfLHds//6bDAsQGgiTek/8Qs1LnkaDG/0bOIcaTL
         qPa+1rfMocxWYf5XCv85sw29GWtXcEh4uPPwMQe/A7kfJbNxH7a68va8GPru1kGsTezq
         l/JCz8eg8IplK4zlzt8qtqGO7kYMjPkOYcAWRcCbQOnlbEax1tXkMDCu/HLqLbt+doIc
         Uldz3ukeYZnC6xaiaY4sGmWrkj8z0K+x6QxC4O2M81BFwiHEodSEPoSpZHW1cFriaX+b
         GcdmZ5wpEwRdT80gGqCnxHiZDqgbeKu16zN8fyqkRkQq1td7ShEA1nitHjNed6iRCLPN
         rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379592; x=1777984392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fylLG2wwQxPhuCjUzW2jU3hgZkUTYpwG6DpN0l0UY6o=;
        b=S9wxdgz7TcFC+zl3Is5Vka8sGG/WkYIGAPhH+WvWU0AD+0O+BlSGEpLR5gVCyLNC9b
         wx7Z+XJ6nP3krJrKb3N6KRpV2oWUeKGMpV12kC1WbeoYPDrsoi3pTScrI6xwjLlBg6ca
         n/ZOOlVaxSsA+EVY05Ehs6gXKI3LL8mLmYFaSgm9zaNe6YnrmlGhOho0XxAZan2wWxni
         j3orL8OjkTfeauNDrNnJc3I3wzYdxuOr8CTG7X8C0ZYxK9d/N655FUEYUxxWekWaSWpn
         ytz8NtuYlu+C0j1I3veeevHo8otxYJTLDzbTM+fLHSPOEO9ITSZ2u3JTCxywIx7DQCp3
         EqxQ==
X-Gm-Message-State: AOJu0YzKraqLjQPXICwcT/D1R+q75j7/Mfgocxk7OY4/IkHq40L7lebJ
	Gp6FhyreaE+25BnDeRJhhr32Q4HWRdUwlq+VDKwnht3bnDuRFjHCH+1FhozNP1pjkkD4RQdTkkv
	q+Y+ugmTFvx1/i5uVyBbYfIocsS5iI2nmtlAWtX3h6C1UQcup7W9agVEMyYLrRQ==
X-Gm-Gg: AeBDieunDdleC/HZV+sJ+BR8CpLlAmIHBlRBLNnKEMRNoykJPLdAsJr5ZXCd/2hp+1d
	xTscW4RnPhekF5OMQd4xGoiJhVV82XNV6PrcKOtfVU2txZsr0JCCD7O4iYgHe6sllXli+ntjFpL
	3FgyjqFldGrhdJu+gyHlHQTzJTKE1kzy28olrzSRaZ/qoq4t7oK8oaunrRMebs58zfNnknTQBCe
	ueLwdV9gb6lBiTVajqvaoZz1nPLMV7FJ020uKtM2Sb3gA/oAefWQ+mDmNaAkNvV6puJmyGJMm40
	r77RaqYvQMce9ZFnDeFiYcLYl9p+oWN/6C6OV4ef5EhzvirBHJNYYWD3OPQx3I1DUVfAFw2sB8/
	cJrAfRHp4jLBrBCK/3trdiNgHAJvP3DtzCdqmYT7ylrjfBkhcRNxxAGhigRM2TyOID6c=
X-Received: by 2002:a05:6a00:80a:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-834dcdaf080mr2760982b3a.25.1777379591399;
        Tue, 28 Apr 2026 05:33:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:80a:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-834dcdaf080mr2760933b3a.25.1777379590888;
        Tue, 28 Apr 2026 05:33:10 -0700 (PDT)
Received: from [10.219.57.134] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae04e49sm3228694b3a.2.2026.04.28.05.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:33:10 -0700 (PDT)
Message-ID: <d0420528-cfab-4b43-8488-015755777194@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 18:03:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 07/13] power: reset: Add psci-reboot-mode driver
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Florian Fainelli
 <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-7-dcf937775e73@oss.qualcomm.com>
 <CAMRc=MdLTMX34DEhoMskMzjRqx+Cdpm3=P5QTZ8S6sUVJ3eTbg@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdLTMX34DEhoMskMzjRqx+Cdpm3=P5QTZ8S6sUVJ3eTbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f0a908 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xJRVJYJ9JtZugbA2SwUA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 66MWppYLcatiTwKKuPwL7Pl-8khxrls8
X-Proofpoint-ORIG-GUID: 66MWppYLcatiTwKKuPwL7Pl-8khxrls8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNiBTYWx0ZWRfX6gflCEEFw7Aq
 EYCB4jPm7Lz+oKCvMOm/1Pt8Ce1hjMOS2BFZIYiXMkd3Ccpk3YxNSAcAZJHTSTLe95u6PvGMbWL
 PzMs1XMUc3uox3ehxF73t/Ahb0Mni+d3FTkDFzcMajrCJS0XtyYnT7OV8Hstp7iDm2/A7wXA+8g
 jP3iZKrU4+5pdfFGk1N1C+1BiTBn6NAr31tLkTNasdIIe7Jh2SpNso5roFETdvi6Qx5PdvFSr+B
 1a2cTtsKBVS3XZOh7xmsCUZU6Bm4R84/8kgwN99iQqEgKb7fMeceygvxTCcpuu7oU/F4zBH5fhM
 vHb/XkZGbmDpk00zLSd+2M2gk5i1UVLyodHcz7t1X6CuIRHYoEmk42KWYrMAgMuRI0/LY0AHobl
 pnSYl2bKhSyjqPUvNwMKQQHa8sQVHKVIVvwZHM7f9/v6Wt+ByPBBvePI5W7MPTOVTVFLRD6tUIM
 oCIvvTTLgrr6WKpC+Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280116



On 28-04-2026 13:26, Bartosz Golaszewski wrote:
[SNIP..]

>> +
>> +	return psci_reboot_mode_add_predefined_mode(dev, reboot, &psci_resets[1]);
> Looking at this, I'd introduce a core reboot-mode helper for initializing the
> predefined_modes field and adding an array of modes and use it here and earlier
> in the series.

sure. thanks for review. Will expose a call from reboot-mode to init/add 
predefined_modes.

thanks,
Shivendra
