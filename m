Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395936;
	b=vIX24rm6XobYIw5K0Nwjy8D79AyoD65zFieODEUg17FRwVGYyiMqp+a5+mARjU6JkGn9
	 yXx4ySQiwUynscDEQQTXZuci9mLHGIXNHRWhOaoka1mfMjOab/HLVNZ8AEtlhty0oZU4L
	 +APy3FIHPE9X6qKHQve/RitIgdGXHJyqC+syvsV8zO171T/dGeGYLodiyWam++7KaRArG
	 Kn2F5cTG572JEQa0Y2nDZKMOvBW+2NyFTKuMnpZzIfKMa1Fo9DXMHuTTU25Dm1q04G556
	 8Wl6uXDBmOW7ozY8hHzQENtY6lXJZRcLhnCAZS49lqiBfyxCcikxsrEMGNpbmMiUfJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395936;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
	b=od12zum2Ug+FCmKJMH+6XRXPegEeItYoZVAbqhiwQKpVfzlzxMoxT9YZbFS4f0eh7Rug
	 OYwSKrY6hRqsahBcMCRVcbLq9eLr6Tor8wIVIC2hDJzI5rrwCx9T8xt/UcbnkY+hcUSfV
	 r5ti47yyWOxn7qfgW/ZcH1E+2E3rSsIjO4BWaImQIkkYbS53cWAPQiJbJDurBiV2z1Wjt
	 SZqN30Gvat/Dr2RX00GIPgnL2nrUcvWvEjMtvOQ4XJ1u8uHPJSLrjXVR8ADiccFW7CTE2
	 J55SXa2XUjgro6egebT4ZO6H2SlCdFLFy4WKo8ituLL4pqPqp9c1uKzB6u6AtxfiVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LJ+7Tr36;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6oD6PNd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4751606A888
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 11:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4751606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LJ+7Tr36;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6oD6PNd
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAmKJp2017713
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 11:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=; b=LJ+7Tr360xzcgazj
	DnFEggp3Cb+r85NfE1EkbRoNSOkShXoB5uwE0w9XJtBHd71O67NaElCK4UaQCMmE
	UaTjRRflWbTpZQXhBxtrpnQO7Xw3N3S7HR+5HEgNMqCnRBSjCsXK4O+y01dvHUNz
	r+IDB/8vlEm0O5d5JyJx5f5YwRLWSZTvLvj/kpc98cv7/+YfnSjlBOxh/OFoXfC4
	AIwQxiEbsbqzN8qZgShbxEB6ioL9JlZvu7dNjxjkSz1A4+u4ofVNdmnMqTEQRTWg
	Q+DrmHmbCrFBslaQHoHq0aTNJAm0D1ojCciOLoES87/nD/R44S8AIdcTLmFnWm4v
	RMg52A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cbfsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 11:18:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b647bbf87aso2782376b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395933; x=1795000733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
        b=L6oD6PNdtxAbOD257EnFCfYzStJhE755HDa2wYnEyRe2MTtcuwVr5rtYFQGCjV/clL
         Mg7p+HhBsaTRomsnwBb0zHKQvZ1usI51wXNn9/3baeQLPWR+VK68V0r0Sxd5I81e7xfR
         ClNKaD/2KBiYxgPNweIneQcndiJjYSRitWrAkh/v7ZbIw3nTQlb0Ad46NER+xOnvNLDq
         snCjBYMICGyf4IivH81t5VQDiddiE6X7xipHxqA8caq6XAqVYPhgfHKkJQoM/1YdfmPX
         IHRJqOOfv19g5ZMsIcGz1lGpyNJw2WZHyBwgsvwEgIsho9q1qH4zVCC7uS2GDbU0jWpk
         1prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395933; x=1795000733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPBAimFTxSZd3Y5OeVj6SECMmnSpH4mL0Rms57DrSHM=;
        b=O+lvmgpZJ5NsiZQOlsw+T5AfVmXQokw8IiD2dktBCwk0+mS56DiGr1JyfA0JDcq2vT
         sbBODGgdSGPc8L/7ajM/CaJvtTEJKBBN5+iGNzi6BkimGiaFZpi3Mtt7Qw3qLxSYEGaP
         62sZ0mIm9RjTTYouKnVjg4Lgrf9OsLxqQkXQYiC9sotI+B8Hk7hGsABAgnQ6yBne5Xl4
         z1Qpyj0rgsldZGIFC95TwYqqPWXqoJIUUcVjdB/xyJzY965AMDvTMEs7Ex17xeo3n+nx
         GfPkkgGQN/QSX1Y4dB38e62GZdGGrm8cjt6nvvt8k+ElgY72oS6ccLW03HCe7BRYBYTg
         wueg==
X-Forwarded-Encrypted: i=1; AL+hErHYLsSPaCoFeFrNQSe8UsU4Y8t/bNJEiv4E7qFizdf2mWmGTD0Fdrq48/vzkulplshBLA2M+O2uqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8b8MDoxO+E0M8jt5+un7bLaCDjvRQXw2jOXloqlaq1dUAd2ozo
	Shf15V1n7A+vdFG+JmVH/hWWipkBRqrNLq5+iBy2ZXoWQQVt6z+9VfIfVCUo1C/0z7x1HRR/hRg
	wnAZht0RW1F13WeoNED5Xax+qtEb2QmDvC/QZiN8Q61k2hl0IJZo3yUI4vNhgWw+b7jY0LMnN
X-Gm-Gg: AYBFou0L6xjvyIjOA3sUZcxchhe0qW+zDiUP0Ew9hnq+bUqZbgxcxNyM5wlVWVRz0Yj
	t1q8o3KbUBJYBp9SSx7Drb3byH0xsgrNsFP9QvwRoM+aH/CGAYJm6rVxyEZ5IpQ1ZpSPBxeDX+k
	KgexZlvXsvUChYQnhhiU0tN6VCE9BCc4YusHw+oi88CLbBQxyoO/eYtGyBqyHaa+OL0UuKsqNH/
	kBiXjl8WG0U+v7lPRNtMEFhg1+IumvkL/bJWsTZFhWMQknEheGV5/TUTgU31m/G51N9RLxRqNlT
	5j3SMhCKt8QL+eMFDzj+HXTYavBbgVCIC00/C6qaOj1eENKHBgmvXoMg1BntTVfxFkVmiUzt7tS
	zxMYVtU4F27PiBGk0YipJCXgZLuwbN00VzfBZdFLW+qcUnK80bgyJphN4TVx9m9xHVfTbwifgrQ
	w9C+8f+PiWPx6rdNNWyfuK4XbEKp7BziM8
X-Received: by 2002:a05:6a00:98b:b0:886:18b2:361c with SMTP id d2e1a72fcca58-8bc19dce039mr2367188b3a.7.1794395932680;
        Wed, 11 Nov 2026 03:18:52 -0800 (PST)
X-Received: by 2002:a05:6a00:98b:b0:886:18b2:361c with SMTP id d2e1a72fcca58-8bc19dce039mr2367170b3a.7.1794395932192;
        Wed, 11 Nov 2026 03:18:52 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bcc3d61dd1sm282366b3a.18.2026.11.11.03.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:18:51 -0800 (PST)
Message-ID: <32021bd4-e144-4674-a5ed-ef8b38950b7a@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:18:47 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of
 function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
To: kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <202611111143.CWKE7ewK-lkp@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <202611111143.CWKE7ewK-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX/l+TEhGQKJBK
 A6SjRJ5t5oIzRPr8YYC8NMCmuwrgKDH7IvtvGDGl1SP4MYX7GUYmYWqbpyqYqbkAcRD7R9nLu2H
 E7PHQu+d47vj/r8mcr1GJ4b4GBBgztfzfVxTjUz8HoiFVLv6rYefeR8s5zTMCHXcjfoQJXqjKUp
 gbyYgO5iNSUcWupBPQ5p906itnEeAZ76SAlkFa47W34blkQ3G03h9cjD/rxQntQTjrhXwYs4LXA
 wmHXL9zr3cb+X+PeDOD2saEVnkIaLYzCGMSnWzeYB71ETWsi396XsLBtwV88hU0F2oZDkF5GE7t
 ZZxj5z+xreJ+HpqzFfXFKLu6n7vRoSBJzrJwe/3x09ZLvEEvUP223rOd0sQvBeE9FO+/OJFuyNM
 Ys9GO/Gap3RcillkxQREPQfI9KWLQw+m3BjbQLEKHcMSnKcyvVrylxYfYsDU2at2m2sxllcMerU
 pld0ptNH6gJ7Jo48NHQ==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af44f1d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=NEAV23lmAAAA:8 a=pblzrQVLAAAA:8 a=txJK9vjdTDeU5cjP6X4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=mmqRlSCDY2ywfjPLJ4af:22
 a=zigF7KAJN4Oc2YRatsUt:22
X-Proofpoint-GUID: SVzt1iRxThHxd7bL3TNivaoU1jK4EMwu
X-Proofpoint-ORIG-GUID: SVzt1iRxThHxd7bL3TNivaoU1jK4EMwu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX6bpMuWpxpYJn
 DQJL9e6+rPwqh7+L2jdffMuyu2C6668s4icnqhV9w3XqvvZZYPNIP563CnjeYqX48uiJW8RFNf2
 idy3nd5WofcAq82fJRQkc43HUH84tyk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

On 11/11/2026 6:46 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
> commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'acpi-battery' into bleeding-edge
> config: x86_64-randconfig-2003-20261111 (https://download.01.org/0day-ci/archive/20261111/202611111143.CWKE7ewK-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111143.CWKE7ewK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611111143.CWKE7ewK-lkp@intel.com/
> 

Addressed the same issue on 
https://lore.kernel.org/all/cbd2aee7-95ae-4d30-8458-b7da2910867f@oss.qualcomm.com/


> All errors (new ones prefixed by >>):
> 
>     drivers/platform/x86/hp/hp-wmi.c: In function 'hp_wmi_charge_control_setup':
>>> drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_register'? [-Wimplicit-function-declaration]
>      1057 |         return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                acpi_battery_hook_register
> 
> 
> vim +1057 drivers/platform/x86/hp/hp-wmi.c
> 
> 929433336e0a6e Shang En Sim 2026-09-30  1033
> 929433336e0a6e Shang En Sim 2026-09-30  1034  static int __init hp_wmi_charge_control_setup(struct device *dev)
> 929433336e0a6e Shang En Sim 2026-09-30  1035  {
> 929433336e0a6e Shang En Sim 2026-09-30  1036  	enum power_supply_charge_behaviour behaviour;
> 929433336e0a6e Shang En Sim 2026-09-30  1037  	int ret;
> 929433336e0a6e Shang En Sim 2026-09-30  1038
> 929433336e0a6e Shang En Sim 2026-09-30  1039  	if (!dmi_check_system(hp_wmi_charge_control_quirks))
> 929433336e0a6e Shang En Sim 2026-09-30  1040  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1041
> 929433336e0a6e Shang En Sim 2026-09-30  1042  	/*
> 929433336e0a6e Shang En Sim 2026-09-30  1043  	 * Firmware retains inhibit across reboot, so seed from GBCO rather
> 929433336e0a6e Shang En Sim 2026-09-30  1044  	 * than assuming auto.
> 929433336e0a6e Shang En Sim 2026-09-30  1045  	 */
> 929433336e0a6e Shang En Sim 2026-09-30  1046  	ret = hp_wmi_charge_mode_read();
> 929433336e0a6e Shang En Sim 2026-09-30  1047  	if (ret < 0)
> 929433336e0a6e Shang En Sim 2026-09-30  1048  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1049
> 929433336e0a6e Shang En Sim 2026-09-30  1050  	ret = hp_wmi_charge_mode_to_behaviour(ret, &behaviour);
> 929433336e0a6e Shang En Sim 2026-09-30  1051  	if (ret)
> 929433336e0a6e Shang En Sim 2026-09-30  1052  		return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1053
> 929433336e0a6e Shang En Sim 2026-09-30  1054  	scoped_guard(mutex, &hp_wmi_charge_lock)
> 929433336e0a6e Shang En Sim 2026-09-30  1055  		hp_wmi_charge_behaviour = behaviour;
> 929433336e0a6e Shang En Sim 2026-09-30  1056
> 929433336e0a6e Shang En Sim 2026-09-30 @1057  	return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
> 929433336e0a6e Shang En Sim 2026-09-30  1058  }
> 929433336e0a6e Shang En Sim 2026-09-30  1059  #else
> 929433336e0a6e Shang En Sim 2026-09-30  1060  static int __init hp_wmi_charge_control_setup(struct device *dev)
> 929433336e0a6e Shang En Sim 2026-09-30  1061  {
> 929433336e0a6e Shang En Sim 2026-09-30  1062  	return 0;
> 929433336e0a6e Shang En Sim 2026-09-30  1063  }
> 929433336e0a6e Shang En Sim 2026-09-30  1064  #endif
> 929433336e0a6e Shang En Sim 2026-09-30  1065
> 
> :::::: The code at line 1057 was first introduced by commit
> :::::: 929433336e0a6e5014af7b8849f369712d2c8964 platform/x86: hp-wmi: add charge_behaviour support for Spectre 8C15/8C17
> 
> :::::: TO: Shang En Sim <sim@shangen.org>
> :::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Thx and BRs,
Zhongqiu Han
