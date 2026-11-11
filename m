Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371077;
	b=nW82AF9sGU4T8QwaxI5qvS+PdPInbdK4VBvkA23lQvu3qmL3EdSNPmisX74lMPM462XM
	 9TVJl9Z9kGnxFAnMG0t63xlrcBFzk1bcS+J3Me+BGZKjGLFUzlqzZPff1i2mawfWslzhS
	 ziwlP7cG3SKe8sKqUiwHY1AsYaSv3S8eUWYYFJeOJGJAMv4SZ2AShHza8fMpArE0tPBcQ
	 KRbad7ypwQpOAuXMi6UjBgbMzIZFwFlIB7mN9zoHbVrAXngmCtF8tDELv5xhj7f022zUr
	 lA6IY6suMDKx6WKAvXyofqrFtkIf+U8YoE+P/W3cZ31mWMLweJrE8ctwJ+Utu4ZfC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371077;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
	b=HumZ98oQefs0rUsX46x9KB0kbrazfjD770HIpa81Ea91O0VXnT19lW9X+8GRBqD8u27L
	 ApeI/1qhLgOljcQAC7uFh2DiuSvfVYrFaocNvEMULBgn5ELqnPXryhUyK3pEGl0XTbcO8
	 RUqzSG0wis7aIpl3s6CNiN6EeCNuQrDKto3+ZWDUvpPuWLIvSxfukh3iYFAC1F43rATDE
	 UHDexti4As0ytoURceBCnBJROz6Rd9JoahtuUmuvMdgpDG/QboFW7D/le85mUofx7e73F
	 p34j9XyGVAnMx1Lv4fZaCM2/Fe0g2A8RK4ManDJfydgexKXBCVnPo1I3WIRMX2kDnsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PWrhjmw6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="g53d/L4+";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E4606A32A
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726E4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PWrhjmw6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g53d/L4+
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1sx0r4167139
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=; b=PWrhjmw6cWiAIUOR
	nBxnNT8cuBsNpQspycxSw3FhkVArCWOtiHpP+9QEaHqPVqHRw70dmX8aqaQBfAU0
	iSZxnMb8TrjLC/4nDBbKGnK3AuWxMYxp/htIhqnJ0WPfiVKtiQmOeqdKPVdVIiG/
	xXFBynvSMycO/H+NV76X1knr0B/Z/bOoj5VbzxoDPswFl86HCta+EBWmnWRjdhFp
	5jbZ11CqvfgCOHpaScsXW1LiLxTyGMltVDkk0Z9uvbT3XvGaT2FhyhoroHACNgTP
	K19gk9CdvMLJ7fBQp7lQdwxkgTgoj1+MXoxYqPw8gxcaOxGxLbwI1+qxXcmwZoWF
	94PuSA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw4ca0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:24:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdd97f89731so636605a12.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 20:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794371075; x=1794975875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
        b=g53d/L4+RGl2Wb2GgCTc/4kf6IH79alfY7m7YcSOmGU/12MMQnQCZG8abz+p+IHPLd
         ZN+wph10O8FB97tlScX8BPIiUDBxA+4w8T50DINoRR3riumt147KmOZbHBcPvEcwSXEo
         KxJviEGhhLGgbkiOvoDE0HQOIkNSbOZGn2LIS7Yd0yp8ZvfS5MYV8qwzPBGWHylSrsqk
         ukek0/KNJtykyETChz/MFfFnpoyis5FI757ZMW3ZzLtvLNLeAf/evKlaeOfPlreos+de
         Bg9OqLUNp8acrCUumyBI/+GmzVFYi2730RnTBu594psuwRDMcRq/au2dRhnFghDSai34
         pxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794371075; x=1794975875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWUrzMN8nC3qw9C+l9CmsKFKxbiwV/1FiCWDbdTG840=;
        b=q6pLeyCLHNaS8DSaKM6EFO4BCmQxT0iu2cRTP9/uMTwwGKtuO9Lkg/luPuTD3S9Y/I
         YNJwK4nTiEczsp6u5z4SQLUNvCE8qMHVQNb6qgPgCA4kHCgqevRjQuqX1mwjjqYhf0AJ
         J1Hri/1sEWlGhXyACrWZDX3jQ5lW0crK7pqkPnZPHA9w/LO6TLCvJk0w/iw5e7PoWrxU
         BRCyx2+ZgX7CczK0Qo6G3h75SjWqWfxKp008YO5vplf/WC/wy3a26gtosexZuxTQgzKE
         J8a2vXCSTV+9Dqebf+I9MT3vCt30lRLQp8WR5aDOmIM4kgPxOlZPTGRk6C6WbQ0yzdCf
         TM3g==
X-Forwarded-Encrypted: i=1; AL+hErFl4TENJ5TIb69RRz+LWF4civxt4COx3rJpyv6jUbwP6Bp/x4mUp5rTMQh8wMYRBqkWIB2X3wZWFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dhM315ukB2Wx8NwRsce4j9pKSnnDjUx4r4HGIvuzx6JgB4Hpj
	6E/EZRXgd1IHdRiUihAhhQ0EiZEJICpwYJlYrO7HnXbhE27dR/J97nR0q1eFYX9YCFjdAJ4D4Km
	LYxcmgdGUr/MRc4e8rL+hFxOJ361aeveJqTaotynijHfNo7JtCmt8ywyM4j9x5A==
X-Gm-Gg: AYBFou37isQSMeMyIL1h5elUMRprsDSk6FtTQcIdfQCCnKnmjjH+3XcII0Upxw18m4+
	Q3WMk9WohRH2lqiiX9/L7VjO0EdcS/ijeda+fCzL9agtztew64OsmiXbt3TUrNz/5C/M6a/IkBg
	/D9/0Bzjylm0SKkCA5pK4QF3ed2mWWIRNVGu3lAbWzPzfE1ABUpxlW/WlY/7Qmw/ZqLxAN+ar1r
	5IfwyvrIJ0ZsQV1CRFBS1nNQy/X9ntrcphf+8o3Tdhh7ra+VqR/h2sz+EmIq+7i7Pu9KsANwRcB
	1PIPibzJOg7itV1vRFMfi9dFnHKDRc2F1+2KnYVScNOgWMMCI/GLJ8rS9uUn4jG94pDwQYJozVr
	MZFRyndFwM0+e8xJzeKA7cenMchjJ4/ilsClOtdIxt+vmLf2++6u+ZDWqFZ7Gl/sxbQx713f4/M
	0VL+dVXZm2eJji9LALsl8kVEuE37im/twg
X-Received: by 2002:a05:6a21:7010:b0:3e2:3392:53f4 with SMTP id adf61e73a8af0-3f2fda98bb2mr939339637.18.1794371074785;
        Tue, 10 Nov 2026 20:24:34 -0800 (PST)
X-Received: by 2002:a05:6a21:7010:b0:3e2:3392:53f4 with SMTP id adf61e73a8af0-3f2fda98bb2mr939310637.18.1794371074260;
        Tue, 10 Nov 2026 20:24:34 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaad41578sm1712051b3a.32.2026.11.10.20.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 20:24:33 -0800 (PST)
Message-ID: <cbd2aee7-95ae-4d30-8458-b7da2910867f@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:24:29 +0800
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
 drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration
 of function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
To: kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        jelle@vdwaa.nl,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <202611111027.YYwIlIDB-lkp@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <202611111027.YYwIlIDB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxNyBTYWx0ZWRfX+Fgp4XJcYOcP
 tYT+zOekNNmCX83CAVt3+d+1vST7JEAxvp8nFVLkl8Ly6Jh5IBz4p0DSb0FkE8m/J+ITJygTj0k
 kyEkXU4GHP5sEI7h6PIIL+8FHNsoKfRDlpgusrT2xR9+Rp3ESjGgGUBkKnfZGp0ENOoq+o0cp1D
 BtO+UsvkKPCQ7wOxDCXv4kS/1jxYUlSfyyfwpf0NTOHEHymyw4Ngsm+FQAWFQMwhnN5Bd7thJw6
 7/Np9KIOhXLmul229ADwsasAlrmVSoL6COVBAzBabIBDB0sQA2UJVkRVsFte3srnA14JogEqBTM
 iM3hXOFPJ6IeoiBSvOh5n5aikKMysE2EweNi3jcwn92/1cMGjewIe1nGVVEpQAQmvg2GpNk+gV/
 yt4j6H2jQm884ryTO198wbuTzuY5o3qzXZdhDmDo0kucmSIljn3T0I333k0W/y/V4Th0EHozONo
 gKjaTcv168Plpmwix1w==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af3ee03 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8
 a=Q1K4HTE4AAAA:8 a=O2upucybYjXuBVFjdQwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=v8M4KpxsNpHYtUgu9mhN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxNyBTYWx0ZWRfX7MxryTLF0DIK
 69+duSOnHH+jYkkRj244pCy1vAJsgTsXOIqhxMQyOcM7z08fol2SyTDAYO22twQ/v58metTb8FG
 xKDVm8y4KkYuwK7rTQCs9CgwFxcNi9w=
X-Proofpoint-GUID: Lq3sAZ0onPyYmgn6vVs-8kanuddOZt71
X-Proofpoint-ORIG-GUID: Lq3sAZ0onPyYmgn6vVs-8kanuddOZt71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110017

On 11/11/2026 10:33 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
> commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'acpi-battery' into bleeding-edge
> config: x86_64-randconfig-1011-20261111 (https://download.01.org/0day-ci/archive/20261111/202611111027.YYwIlIDB-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111027.YYwIlIDB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611111027.YYwIlIDB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/platform/x86/acer-wmi-battery.c: In function 'acer_wmi_battery_probe':
>>> drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration of function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_register'? [-Wimplicit-function-declaration]
>       292 |         return devm_battery_hook_register(&data->wdev->dev, &data->hook);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                acpi_battery_hook_register


I took a quick look at this merge-ordering problem:

devm_battery_hook_register() gained two new callers in v7.4-rc1 while
the rename was still pending:

Old API (devm_battery_hook_register) users:

   c72dd9994952 ("platform/x86: add Acer battery control driver")
     committed:  2026-09-18
     file:       drivers/platform/x86/acer-wmi-battery.c
     branch:     platform-drivers-x86 -> mainline v7.4-rc1

   929433336e0a ("platform/x86: hp-wmi: add charge_behaviour support for 
Spectre 8C15/8C17")
     committed:  2026-10-14
     file:       drivers/platform/x86/hp/hp-wmi.c
     branch:     platform-drivers-x86 -> mainline v7.4-rc1

New API (devm_acpi_battery_hook_register):

   c27a6fd6b403 ("ACPI: battery: add acpi_ prefix to the battery hook
API")
     committed:  2026-11-10
     branch:     linux-pm bleeding-edge (via the acpi-battery branch,
                 based on v7.3-rc2)

(Please note that the robot only reported acer-wmi-battery. The hp-wmi
should fail the same way when CONFIG_HP_WMI is enabled)


> 
> 
> vim +292 drivers/platform/x86/acer-wmi-battery.c
> 
> c72dd9994952eb Jelle van der Waa 2026-09-13  275
> c72dd9994952eb Jelle van der Waa 2026-09-13  276  static int acer_wmi_battery_probe(struct wmi_device *wdev, const void *context)
> c72dd9994952eb Jelle van der Waa 2026-09-13  277  {
> c72dd9994952eb Jelle van der Waa 2026-09-13  278  	struct acer_wmi_battery_data *data;
> c72dd9994952eb Jelle van der Waa 2026-09-13  279
> 4dd10fbbeb9c33 Kees Cook         2026-10-28  280  	data = devm_kzalloc_obj(&wdev->dev, *data);
> c72dd9994952eb Jelle van der Waa 2026-09-13  281  	if (!data)
> c72dd9994952eb Jelle van der Waa 2026-09-13  282  		return -ENOMEM;
> c72dd9994952eb Jelle van der Waa 2026-09-13  283
> c72dd9994952eb Jelle van der Waa 2026-09-13  284  	dev_set_drvdata(&wdev->dev, data);
> c72dd9994952eb Jelle van der Waa 2026-09-13  285  	data->wdev = wdev;
> c72dd9994952eb Jelle van der Waa 2026-09-13  286  	data->battery_ext = health_mode ? &acer_wmi_battery_extension_v2
> c72dd9994952eb Jelle van der Waa 2026-09-13  287  					: &acer_wmi_battery_extension_v1;
> c72dd9994952eb Jelle van der Waa 2026-09-13  288  	data->hook.name = "Acer Battery Extension";
> c72dd9994952eb Jelle van der Waa 2026-09-13  289  	data->hook.add_battery = acer_battery_add;
> c72dd9994952eb Jelle van der Waa 2026-09-13  290  	data->hook.remove_battery = acer_battery_remove;
> c72dd9994952eb Jelle van der Waa 2026-09-13  291
> c72dd9994952eb Jelle van der Waa 2026-09-13 @292  	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> c72dd9994952eb Jelle van der Waa 2026-09-13  293  }
> c72dd9994952eb Jelle van der Waa 2026-09-13  294
> 
> :::::: The code at line 292 was first introduced by commit
> :::::: c72dd9994952eb09442827caecb945474ae3072b platform/x86: add Acer battery control driver
> 
> :::::: TO: Jelle van der Waa <jelle@vdwaa.nl>
> :::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Thx and BRs,
Zhongqiu Han
