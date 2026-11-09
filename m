Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242216;
	b=ohiNBrrD8AXPOofcndYFdYlZVf0aXGNrcJEWyPP8rBBZotSMVrTnJKvjuExAafC42G9W
	 +kuATupaDTAxSBv8hDcG2anae29LpkHqRug4aAwmkRqXaB5NORY9DL8x5aHWeb7fcZjo0
	 U8vhAIJZ9Tu/wCZA56QiWFRGIbx9jk59M3cattAVMUjdW/dmsbi9PGR6Hyzyo+xVcDWe0
	 0Lfxdv5CgK6O7pCyszJmkGGxKxbnBUJCTcPFEh6aEddA1VCn7vle07S8c1nmh3x1zm32v
	 lpi6Pu/a5EUfgT0z0xQR9MdTPLLAVYY612S0F9O3gH52lHLT8iYvn8oleIMK/aLD9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
	b=H3iEkXsPmJVhe5c7FN5o9sDNdOow9LNgxODY+KlTH/nbzFGAWtQZ+XBnYR4My1fu1Hbx
	 0DX5pYIWPhlfpvV4W6hl+J4MhliMKWYsPN++YyMlvt0RaOzshTIAs64/yW+11Jfigyjdc
	 i28jPjSoi+JxM1bymjKSPZTc6nBnrp0eR7hyLcGy2usdLhuvWJP4ynLzjdI4bPx8xZHGv
	 oJ04RvqyCpa7eb7vb8DsvJTyXZZ9InM7CY3O5baD8vKtv7Z4v/X6MKtDGVGClGXujkf5k
	 80XgLdGgtaeAiwnEcNsSYaBEsAaYhHSkhbTt+j0T2iWHP3GMd0vOyvdrIWqUvZ19WiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=msfeHy88;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VmCTHo9P;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5660A6F72
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F5660A6F72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=msfeHy88;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VmCTHo9P
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFOQd335108
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=; b=msfeHy88415MBPwc
	L2uACbLQp0TEuRExtyxYzU291teu/v++InscGb4Aaa2Ur6ppwNzx450ymMgkJ6+T
	RsKi8GKr+ln9kS31RG1mwE7HLQ8zS9AkBTfrRvBIp8KaomUIGxjcbXLCcazMAs9t
	IQiA20uJJmBdCDwoT/mRRETRWRxdcF+cGqiUN7XjYq9Siu5kdnHVZgCVgIBcXc5P
	58qz5s4legHs7/U50tGU9KDu+NKv3Ldhtcbc68SZ+oTIE034fBt4Xb7K58F8UT/5
	3l8HcU9tCM+fn3FczPhTZAoOO0DYs/PpWqece//gUUofGWuBUeeGDlkKdyI0H3iv
	EyNxwg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf593ge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 16:36:54 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-990835cec5aso801519241.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794242213; x=1794847013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
        b=VmCTHo9P3nq14H22L2oDbfLfwhrGPkp6VEnMTESM3QmN9yZkISASKbnip1cDIwJmcc
         sjg76JJOpSNgENcm2bnxlgHCCYD17jZ8hSHQxbjWxfBOo3TGqvvWXmS58SXeicNUhL7x
         cebL495uTS+qGnYPwbRuMekpiBRWnM/L2Md8xhceG6lRu9FD7Jz5kiDhwN7me89cvu45
         b2E+P5y1RA7YjVF8ET8ehxXXsJU47tY57p3LWCWg/zgoOZIwGtdmJw/+8tfypegcOQqY
         fpRVYKeCuNFztub+JQ0Yw09CHcFFWWuCTxG7FUVK55zm7l0hVAZPvvfMb6rNdMut3c2C
         4VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242213; x=1794847013;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn9CEocg2zylizZLlU3oTB1VMEKBAaE2tCfugJNdHSQ=;
        b=aI74t/xFf5SmEBTyN2HRlMPjZFTXIYL0+X8daa4PqhIvuuwePsYk+JB8wUTXyzBE3G
         NZorp7jkQA2rk+30updfSoFgiD9HjnjuE1CO4rGTARiviQIhTZFkEpheFXuQO2mQRRiX
         lM+ZiEp6nzkWsOv3G9LuHe1XvX8M3uJHy5i9lh3sKCVdt8yVx3pS69/pPpVkSAIxo6IQ
         ciZ7xzSA0Yx4Wnwjg5Ur5OhJWRAlgjWCWfM5FMB4+d2L1imtaxaL8ItJ5gjBk47P/mZg
         OQrwJ9QDdOIlklhe/MwOLmm1fPVnninINpEPiuYOCklcoTlFBsHU2wInMZ7SgJM9oInM
         fRuA==
X-Forwarded-Encrypted: i=1; AL+hErHGC+vyIZdjUbZcC/z5n4+14bPdP1vxKHlhhkZKH0NG3OAef4kRhckpwGLJ7MSTCJE/GXLYIrynMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/c5eHddkLgGKJ1bo5jI6BwS9ifCaduk0bWOhj+7fkBZ7LdtVeB
	ayWPOwgSZEdDcqFCqXlb+ey9ekFHh+UMeycgzRPG87Y8qRn13SFGAdnuYfZHRCwOurQYBPeaJxq
	BYURIYfBNPweviJ4+CPSkEQocciDvP/sQ5O3K1ebXsm+9NrsVRZr+nagt8olG2g==
X-Gm-Gg: AYBFou0mBLnvs/zNSBmnk0vAz/Cawlhd4wHCKFJlTMd6yd+oQW1EpJMKgcnZD6DMMiI
	kzsznLa/LG6P5Nhq46OtHDQ4PsOZqJwpH+3yNcN/Mn3j/cQ27AL62SS/xeAHaRHQCJG5q19ZAfP
	8TU+FP9+J6llFjbfR7Llyxk+om5AZoAfwyCdIJGXvWF3Y6HCWj6yPBi40IsstNzhlIapxYPcEFe
	sBjmHN6JjfZeK7ZN7t7Txx5VNUeF8DB1oZRWo+jP/NU7/6Rx6+EXnf42bSetRCsSDZ/nmQ3qNDd
	xbLWItbZh0h9ALQxcT668ZcSqPFWCS0b3yQtiG7nag/PPWTm6owUOPlMPVw03HD/CEbHGQCtR89
	pWKI2Hyn9W9hTzf8hRD6Qg4zXQmxXF845iR/sWXer+EYXVHI5Vk3TiPTdYljD0mx0n9o3Df75Vz
	dxZGyraB/r1DkBjJO3XqvEm/MnjoUtyxmIBQ==
X-Received: by 2002:a05:6102:390d:b0:7d2:cdcb:6b4a with SMTP id ada2fe7eead31-7d301120897mr5322137.22.1794242213444;
        Mon, 09 Nov 2026 08:36:53 -0800 (PST)
X-Received: by 2002:a05:6102:390d:b0:7d2:cdcb:6b4a with SMTP id ada2fe7eead31-7d301120897mr5297137.22.1794242212750;
        Mon, 09 Nov 2026 08:36:52 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8ebe:809e:5980:89b4? ([2a05:6e02:1041:c10:8ebe:809e:5980:89b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9a9ffsm11476601f8f.30.2026.11.09.08.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:36:51 -0800 (PST)
Message-ID: <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:36:50 +0100
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
Subject: Re: [PATCH v3 0/4] Make platform profiles firmware independent
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)"
 <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ur-OwxJeY3Ir7Wul7xIio41WUk-9Z-1y
X-Proofpoint-GUID: ur-OwxJeY3Ir7Wul7xIio41WUk-9Z-1y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX18vP9DPkoQtw
 GtajzpZ6eqpybadR3MT84PakTCODo5WV0nIQFlfiCf+10gp4RoZLMol1y4jO2O2h4C7uMOx8PDC
 PTUAJfXErnpqfWsirX+pjssOMUXKsWw=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af1f6a6 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=I2DTqkVBWxGU35LqPC4A:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX8uKSBp1oQdSS
 7Ijbk4YuKdoSi9qR0jSKHsWgIB77EzZR1s7/XS1Oh2zxdPA61rLxoso315RCbmZb4J16/kndiUX
 XgbPrHkTaAahrVUxPT2J/WfTldsMJY3zMITsgNDi0gUIECzMiZzSljzfW6TxX2N43MmguG6Et0K
 yR/BrNuorbH7q7TR409r2P2NFe+fkJOL2PP27ZhPI+RZwpdcmrUnheDeoJMnNwLY95tGaMTNCHK
 TlxoaFtzZp/F+pnLAJDF8Hf3u4q6GvkurxPEChoIWOj0mgo4Uv8w2Uty5FmZmoa5QshiLzxUlvY
 3oioRxH/ilUV4u1HOlr0YoClTq9/DiROOkhFHqg8jS6nzQwDe5MA5h9p7fvITPOdQ3UGKYU4lzz
 lQb5r4egGxlElhs2H7ynLcLdPPwkyVI1epqDQY+tNeDNZgjpTNIS80ikmx4HQFIV2wkLOhS8UYa
 rGQTW/MmACgTMePrBTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066


Hi,

sashiko validated this series

Is there any other comments for these changes I should take care of ?


On 10/25/26 00:34, Daniel Lezcano wrote:
> Make platform profile selection independent of ACPI firmware.
> 
> The provider API already uses struct device, profile enums and callbacks;
> it does not require an ACPI handle or firmware node. However, the core is
> built under drivers/acpi/, its Kconfig symbol depends implicitly on ACPI,
> and initialization fails when ACPI is disabled, preventing non-ACPI
> providers from using the existing firmware-independent class interface.
> 
> This series moves the core to drivers/platform/profile/ and introduces
> CONFIG_PLATFORM_PROFILE, updating all existing provider selectors. It
> retains the tristate configuration and platform_profile module name.
> Firmware-specific discovery and profile operations remain with providers.
> The core can also be selected directly through its Kconfig prompt.
> 
> An optional ACPI adapter obtains the legacy sysfs kobject and is linked
> into the same module. The generic core contains no ACPI types or symbols
> and initializes without ACPI support or with ACPI disabled at boot.
> The existing /sys/firmware/acpi/platform_profile and
> /sys/firmware/acpi/platform_profile_choices attributes remain available
> on active ACPI systems.
> 
> CONFIG_PLATFORM_PROFILE_LEGACY controls the backwards-compatible aggregate
> sysfs interface. It defaults to enabled to preserve existing userspace.
> Disabling it omits the legacy sysfs callbacks and ACPI adapter while
> retaining class devices and kernel profile cycling. New userspace should
> discover and control individual class devices instead.
> The interface is deprecated, with removal intended after the 2028 LTS
> kernel once userspace migration is complete. A shared pr_notice_once()
> warns on legacy attribute access rather than on merely loading the core.
> The default remains enabled while userspace adopts released class-device
> support; this series does not claim that ecosystem migration is complete.
> 
> The existing firmware-independent interface remains:
> 
>    /sys/class/platform-profile/platform-profile-X/name
>    /sys/class/platform-profile/platform-profile-X/choices
>    /sys/class/platform-profile/platform-profile-X/profile
> 
> Non-ACPI userspace controls providers individually through these class
> devices. Aggregate selection remains available through the legacy ACPI
> attributes, and aggregate profile cycling remains available to kernel
> callers. No new sysfs directory or userspace ABI is introduced.
> 
> The original first patch, "Separate handler locking from sysfs lifetime",
> fixing the handler access race and sysfs teardown locking issue, has been
> sent separately as a standalone v3 fix. It is not included in this series.
> The base tree used here already contains that fix.
> 
> Patch 1 extracts the core and initializes it before built-in consumers.
> Patch 2 completes class-device notifications and registration cleanup.
> Patch 3 documents firmware-independent profile selection through class
> devices. Patch 4 makes the legacy ACPI aggregate sysfs interface optional
> and documents its deprecation.
> 
> Validation performed during development (before this rebase):
> 
>    - ARM64 built-in core with CONFIG_ACPI=n: W=1 build and sparse.
>    - x86 modular core with CONFIG_ACPI=y: W=1 object build and sparse.
>      Both CONFIG_PLATFORM_PROFILE_LEGACY=y and =n are covered.
>    - Full x86 kernel link and QEMU boot with lockdep and list debugging,
>      with active ACPI and with acpi=off.
>    - Firmware-less providers exercising common and hidden choices,
>      profile reads/writes, invalid input, mixed profiles, cycling,
>      partial callback failures and POLLPRI on the class and legacy ACPI
>      interfaces. With acpi=off, class get/set, notifications and kernel
>      cycling are exercised. Both runs check that no new aggregate sysfs
>      directory is created.
>    - Concurrent sysfs I/O with two persistent providers while a third
>      provider is registered and removed 200 times, last-provider attribute
>      removal and repeated provider module reloads.
>    - QEMU with active ACPI and CONFIG_PLATFORM_PROFILE_LEGACY=n: verify
>      the legacy attributes are absent, class get/set and notifications
>      work, and kernel cycling and registration/removal stress pass.
> 
> The provider API and profile names are unchanged. Aggregate writes retain
> their sequential, non-transactional behavior: a failing callback does not
> roll back providers already updated.
> 
> Changes in v3:
>    - Send the original first patch fixing the handler access race and
>      sysfs lifetime locking separately as a standalone v3 fix, including
>      the requested profile_lock protection comment and Fixes tag.
>    - Reduce this series to the four remaining patches and renumber them.
>    - Rebase the remaining changes onto the current base, which already
>      contains the separately submitted locking fix.
> 
> Changes in v2:
>    - Add the Fixes tag to patch 1 and explain how the mutex-guard conversion
>      reintroduced the teardown deadlock previously fixed in 041142d7d252,
>      and how class-device support subsequently extended the affected paths.
>    - Drop the proposed /sys/kernel/platform_profile/ aggregate interface
>      and its ABI documentation. Use the existing firmware-independent
>      /sys/class/platform-profile/platform-profile-X/ devices instead.
>    - Preserve aggregate selection through the legacy ACPI attributes and
>      retain internal aggregation for kernel profile cycling.
>    - Refocus patch 3 on class-device notifications for direct writes and
>      restoring aggregate visibility after failed registration.
>    - Update the Kconfig help and documentation to describe the existing
>      class interface and distinguish it from ACPI aggregate selection.
>    - Revalidate class controls and notifications with acpi=off, legacy
>      aggregation with ACPI active, and the absence of a new aggregate ABI.
>    - Add CONFIG_PLATFORM_PROFILE_LEGACY (default y) to make legacy aggregate
>      sysfs code optional, independently of class devices and kernel cycling.
>    - Mark the legacy ABI deprecated and describe removal after the 2028 LTS
>      kernel, conditional on userspace migration. Emit one shared notice on
>      legacy attribute access; retain the enabled default during migration.
>    - Move the legacy ACPI ABI documentation from testing/ to obsolete/,
>      document the replacement class attributes and update MAINTAINERS.
> 
> Changes in v1:
>    - Initial series extracting the core from ACPI, separating handler
>      locking from sysfs lifetime operations and retaining the legacy ABI.
>    - Proposed a firmware-neutral aggregate sysfs interface alongside the
>      existing per-provider class devices (removed in v2).
> 
> Daniel Lezcano (4):
>    platform profile: Extract the core from ACPI
>    platform profile: Complete class notifications and registration
>      cleanup
>    platform profile: Document firmware-independent profile selection
>    platform profile: Make legacy ACPI aggregate interface optional
> 
>   .../sysfs-platform_profile                    |  12 ++
>   .../ABI/testing/sysfs-class-platform-profile  |   2 +-
>   .../userspace-api/sysfs-platform_profile.rst  |  55 ++++++--
>   MAINTAINERS                                   |   5 +
>   drivers/acpi/Kconfig                          |   3 -
>   drivers/acpi/Makefile                         |   1 -
>   drivers/cpufreq/Kconfig.x86                   |   2 +-
>   drivers/platform/Kconfig                      |  35 +++++
>   drivers/platform/Makefile                     |   2 +
>   drivers/platform/profile/Makefile             |   5 +
>   drivers/platform/profile/acpi.c               |  15 +++
>   .../profile/core.c}                           | 122 ++++++++++++++----
>   drivers/platform/profile/profile.h            |  17 +++
>   drivers/platform/surface/Kconfig              |   6 +-
>   drivers/platform/x86/Kconfig                  |  10 +-
>   drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
>   drivers/platform/x86/dell/Kconfig             |   4 +-
>   drivers/platform/x86/hp/Kconfig               |   2 +-
>   drivers/platform/x86/lenovo/Kconfig           |   6 +-
>   drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
>   include/linux/platform_profile.h              |   3 +
>   21 files changed, 255 insertions(+), 56 deletions(-)
>   rename Documentation/ABI/{testing => obsolete}/sysfs-platform_profile (70%)
>   create mode 100644 drivers/platform/profile/Makefile
>   create mode 100644 drivers/platform/profile/acpi.c
>   rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (88%)
>   create mode 100644 drivers/platform/profile/profile.h
> 
> 
> base-commit: 8244dc8f69f0e73cb1789355260b7d68bf5494e7

