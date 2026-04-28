Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C83033F5
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393682; cv=none; b=HoGxSSPCzjia9g6kUGIZlbqNDmOZVJuQS8UO99oALFH+GpnnJQ3+v1lMuU0I6DNWjgGfWdEgFmRTVi+ATJHttE781Hk+rZHq6qJQUaGoST1y4+W2jmIUndeT1kAkHuL6U9+jETvV/XLTJEODPyVOfj8oEfgQKbe33gJBB0sMAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393682; c=relaxed/simple;
	bh=7o7xPybo0e/XAw1Dyb/YPRrdJEhxYOVGMyv9+c+tQ+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbBAbh1TXRBoRJ6dU98LM4MfPDTmuGr933ZVrOJ0sQ912H9WD2SQSDXuUID1Yv7MVyzSzEivgGTXKZAGjuAt2LlCJxl6hfsspHy4D2YGpPo4ZbRN4ky+cHRMNax4CkkaVlBbxfpM/0Dxqm0IM4tlV0CbeKoadLLmXfQXd/Xmtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=deOiAsRS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4fPpaHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="deOiAsRS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4fPpaHF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SFsTdZ1796712
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 16:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0zYoXgcN5YmYoiapw5cl2FOxLA24GcaGELbu3+TT+7I=; b=deOiAsRSWPgxHeMc
	bY5h+d++hfvjFrQZVAHuEzfsF2GppwuUNK1ra9pnFULXPsOebAWenv78v/piTnrY
	cf7pbq1ReqIjRQ4MsuombIJoYgXWnC5sp1wZjuQ6Ek+azMQh0lArmZP4mb8WqD/+
	l6Kxm5kCXhOO6yLFvy5/+E2cu53VH6F5Az+QJUSvUj6uiNLlfdLO0ovAQDmKfKyb
	BnTnb9hkIFPRdxXTUFZRwjIqrHI9IfyzbIwRHekb8TvbMQWypx/Y1refLpo3HTda
	a0+QNgacip+8mLUzLAr6CUhPc6AW6mFpo7QX7f7sLrTeEWOv73yQkcR6ODjTcgZG
	ox0Z3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2sksm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 16:28:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f07078ff0so8022927b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777393680; x=1777998480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zYoXgcN5YmYoiapw5cl2FOxLA24GcaGELbu3+TT+7I=;
        b=R4fPpaHF786MJ6IGeMXdlx1/8dh+ptWArNIyPOqr09M21LynP7fC7WEIYk/QZKFsSM
         uOl0TPNuXdY4FX5zV2YPlshbqYv4e1UNwGgJv2zYXlc+SVTAyNml6fhn4ISHDSGWVAaM
         xB1Dj9A4QsIHjWPDPslYuP2BjzlWcpi+1zjbN0QTMiLI3YuzWgqgauqMWIeY36XJkIgL
         PgnrGvsG/WdoN7QjdhZkEkJtIUJ+55kmkli0XPVZzq5GmxQSO8aWcYlDetBf99NTX8Zx
         eBswwb7R7HfQoYuCwy2QJd5XR9a5CBCyyOadP1gpz+M3YtfyFTmWh0Jdz4kEQXXL+RDW
         60DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393680; x=1777998480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zYoXgcN5YmYoiapw5cl2FOxLA24GcaGELbu3+TT+7I=;
        b=lMi2r9oud6fNzOoJ3Nc8f14GCmq3u2B09DdrFxaveoIwjMT/fH99h3evcVBIgs9DJC
         LCGvCnPV2wCnCQUUHSGOeUJaxpAOhgU4CW0cBddT47TbbWC0rd2+h2zjVbXW2UL1h8uG
         XlUsw3uem+MCM6WaFeoLMt9fjRllcQfLsfhs5A+wmaPe45fNsiy4EaLs7VPaGw52JWAb
         oL6P8N+okCff0w62Lvh521BhdJFFssiTMoG2chbyq6AcCCuWYHGAbqSGxJvi8YTzZPd/
         nWKBq3X8YRoTXQa8yijz1bof1xTTZ43gWCtSbawiLHhks1BfbbcH2oRpF7F6vYJI0MD0
         VRfA==
X-Gm-Message-State: AOJu0YytjbPqMZRKcOhboXSGzTUadC1sH5pqPoDWFohScooKeGsZ4un1
	I+RFu7EuzYQ0spGmKu+cY0AvxkxvHBGK/lHKHhGOAzn9UMfbqSS5rHY3bYCc7NZyb8JdStLAuxK
	qmM4lMeEztrpopAfnus09dvy3XGwe13eoiQjdmXRPTodYT7sZlORGltJ2RyiHuw==
X-Gm-Gg: AeBDieueeQp25FrRMjFgSLsJcQoDLNbCllGNGZloTziYWZJVyc+v1Eqv3+r5ubr5xN9
	Uhtq/5qTkJqqaetK83874UpoJ3RF73wHb/cPXpZx+pLTN/owIgmiAicJ8rOCFpNt+bOphTnKLIZ
	zT+Aom+gIO6xz7YSYzY1TZ5xiA7ohqN9UZ39L7oGPoRYyPFGkVYDEQ7HzMuAsyxsW2Z3aKxM7V5
	9ZufiEjYOW/G8iEwyGzQE0pHt3pNP1j9FeD407ahyThDDedkZ7NM8od6bSgVYwfH/UwfxKXN9JS
	xNeMwF3liHO3Rq0tbpQqP9C18Bn77QgZ9cSZtdYJz8MTkpEdH/vxy8uHs87DivR4TsCgivpbgmc
	sD9wjnsnyHUDhtMJqEPV/HZUg4Kmon/C6euIE9Jpfc+EzEq+64JrHNu8rtDw3YLxqNNQX
X-Received: by 2002:a05:6a00:4b0c:b0:82c:db50:ef77 with SMTP id d2e1a72fcca58-834ddc950c7mr3689729b3a.49.1777393679351;
        Tue, 28 Apr 2026 09:27:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0c:b0:82c:db50:ef77 with SMTP id d2e1a72fcca58-834ddc950c7mr3689676b3a.49.1777393678617;
        Tue, 28 Apr 2026 09:27:58 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.227.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf69297sm2893898b3a.47.2026.04.28.09.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:27:58 -0700 (PDT)
Message-ID: <b3c36404-64ae-4a10-b955-ee5b2321b7ed@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 21:57:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 04/13] firmware: psci: Introduce command-based with
 magic
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-4-dcf937775e73@oss.qualcomm.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-4-dcf937775e73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0e010 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Gpg95E5bJKK5C7oRfY2+2w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=219khkIK2FHepI9fHIMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: FaW9rO9KDJji4OXAAd1MDVGgmbL3WOnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1OCBTYWx0ZWRfX7+fEkXrGpK6A
 IPRHx/Cz2bkuYhEPp9aQoMjdYjHrr90tjnXK74vTideFBvG7b00tOvNT6QDb8m7uNXj0sgLOrNZ
 ikskcyJxReahriO05ukxeeqCICUiFaMogjbGhEFvayU81RUc9MtV/kwk1ATGuq6RzM4Munis2VT
 8t/MQl/AJGufSHEHXxbeAuYLR7q1+yvRqVULbZUdOaScB0I9FThv3TTm4YmCe3oSUnlAFVb/gYV
 Cvbdr2O5ciqxGqgdZNu2ehgAK/6XlL3ZcodliVtFUFVASJBw4ih0GFTC6lM1ruRmM/qgSpYt+ZM
 8qV0qQXqS+eA8SZeE+hCHfDDdb99ldPwN1IFyBpuaKSlz2sTx3ozOaqaLzoHMf1LWmlQ+Q9dTL5
 vyyG93KuaZctWa8SRZHDCTZXLx5zHteWYig5ul6c5MabtxSfKZqJH+eMavPTXLrpqipH3+uEvDn
 YZrYm5fwAY9eRh+jHvA==
X-Proofpoint-GUID: FaW9rO9KDJji4OXAAd1MDVGgmbL3WOnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280158

Correction in commit subject - firmware: psci: Introduce command-based 
resets

On 27-04-2026 23:04, Shivendra Pratap wrote:
> PSCI currently supports only two resets - SYSTEM_RESET and SYSTEM_RESET2
> ARCH WARM reset. The reset patch is selected based on the Linux
> reboot_mode variable. The PSCI specification now includes SYSTEM_RESET2
> for vendor-specific resets but there's no mechanism to issue these
> through psci_sys_reset().
> 
> Add a command-based reset mechanism that allows external drivers to set
> the psci reset command via a exported psci_set_reset_cmd() function.
> 
> Define predefined reset_types - PSCI_RESET_TYPE_SYSTEM_RESET to map to
> SYSTEM_RESET, and PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM to map to
> SYSTEM_RESET2 arch warm reset. Interpret zero cmd_reset_type, for
> predefined reset-command selection via cmd_cookie. For non-zero
> cmd_reset_type, check for valid vendor_reset_type and set the psci
> reset_command and cookie accordingly.
> 
> Disable PSCI command-based reset by default and treat invalid reset
> commands as no‑op. psci_sys_reset() follows its original flow based on
> reboot_mode until a reset command is explicitly set by
> psci_set_reset_cmd().  In the device reset flow, psci_set_reset_cmd() is
> called in reboot_notifier phase and the device reset happens in
> psci_sys_reset() which is called later in the restart_notifier phase. If
> a kernel panic occurs in between these two phases, the reboot should
> take its original flow based on the value of reboot_mode. Disable the
> command-based reset in such case.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>   drivers/firmware/psci/psci.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/psci.h         | 19 +++++++++++
>   2 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..cb37c39e2b4b1d99f0080f6a5cd6c92a070beda8 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -51,6 +51,16 @@ static int resident_cpu = -1;
>   struct psci_operations psci_ops;
>   static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>   
> +/*
> + * Encoded reset command:
> + * bits[63:32] = cookie
> + * bits[31:0]  = reset_type
> + */
> +static u64 reset_cmd;
> +
> +#define PSCI_RESET_TYPE(reset_cmd)	((u32)(reset_cmd))
> +#define PSCI_RESET_COOKIE(reset_cmd)	((u32)((reset_cmd) >> 32))
> +
>   bool psci_tos_resident_on(int cpu)
>   {
>   	return cpu == resident_cpu;
> @@ -80,6 +90,35 @@ static u32 psci_cpu_suspend_feature;
>   static bool psci_system_reset2_supported;
>   static bool psci_system_off2_hibernate_supported;
>   
> +static u32 psci_fn_from_cookie(u32 cookie)
> +{
> +	switch (cookie) {
> +	case PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM:
> +		if (psci_system_reset2_supported)
> +			return PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
> +		return 0;
> +	case PSCI_RESET_TYPE_SYSTEM_RESET:
> +		return PSCI_0_2_FN_SYSTEM_RESET;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/** psci_set_reset_cmd() - Configure reset request for psci_sys_reset()
> + * @psci_reset_cmd: reset command encoded as cookie[63:32] | reset_type[31:0]
> + *
> + * Save reset command.
> + */
> +void psci_set_reset_cmd(u64 psci_reset_cmd)
> +{
> +	reset_cmd = psci_reset_cmd;
> +}
> +
> +bool psci_has_system_reset2_support(void)
> +{
> +	return psci_system_reset2_supported;
> +}
> +
>   static inline bool psci_has_ext_power_state(void)
>   {
>   	return psci_cpu_suspend_feature &
> @@ -306,8 +345,24 @@ static int get_set_conduit_method(const struct device_node *np)
>   	return 0;
>   }
>   
> -static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> -			  void *data)
> +static void psci_handle_reset_cmd(void)
> +{
> +	u32 psci_sys_reset_fn;
> +
> +	if ((reset_cmd & BIT_ULL(31)) && psci_system_reset2_supported) {
> +		/* PSCI SYSTEM_RESET2 Vendor-specific reset */
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> +			       PSCI_RESET_TYPE(reset_cmd),
> +			       PSCI_RESET_COOKIE(reset_cmd), 0);
> +	} else {
> +		/* cookie part of the reset_cmd decides ARCH WARM RESET vs SYSTEM_RESET */
> +		psci_sys_reset_fn = psci_fn_from_cookie(PSCI_RESET_COOKIE(reset_cmd));
> +		if (!PSCI_RESET_TYPE(reset_cmd) && psci_sys_reset_fn)
> +			invoke_psci_fn(psci_sys_reset_fn, 0, 0, 0);
> +	}
> +}
> +
> +static void psci_handle_reboot_mode(void)
>   {
>   	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>   	    psci_system_reset2_supported) {
> @@ -320,6 +375,22 @@ static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>   	} else {
>   		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>   	}
> +}
> +
> +static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> +			  void *data)
> +{
> +	/*
> +	 * Command-based resets are configured at the reboot_notifier phase.
> +	 * If a kernel panic occurs between the reboot_notifier and this final
> +	 * reset, ignore the command-based reset and let reboot_mode drive the
> +	 * reset flow.
> +	 * If reset_cmd is zero, there is no command to handle.
> +	 */
> +	if (reset_cmd && !panic_in_progress())
> +		psci_handle_reset_cmd();
> +	else
> +		psci_handle_reboot_mode();
>   
>   	return NOTIFY_DONE;
>   }
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 4ca0060a3fc42ba1ca751c7862fb4ad8dda35a4c..c2458291a3faf5ac89b1528dae2c9b805a2dd075 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -21,6 +21,21 @@ bool psci_power_state_is_valid(u32 state);
>   int psci_set_osi_mode(bool enable);
>   bool psci_has_osi_support(void);
>   
> +/**
> + * enum psci_reset_type	-	PSCI_RESET_TYPE for SYSTEM_RESET.
> + * @PSCI_RESET_TYPE_SYSTEM_RESET: Standard SYSTEM_RESET command.
> + * @PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM: SYSTEM_RESET2 architectural warm reset.
> + *
> + * These enum values map PSCI_RESET_TYPE_SYSTEM_* constants to reset strings
> + * issued from user space. When user space requests a reset, the cookie
> + * carries one of these values, and the PSCI reset path translates it into
> + * the appropriate PSCI system reset call.
> + */
> +enum psci_reset_type {
> +	PSCI_RESET_TYPE_SYSTEM_RESET = 1,
> +	PSCI_RESET_TYPE_SYSTEM_RESET2_ARCH_WARM,
> +};
> +
>   struct psci_operations {
>   	u32 (*get_version)(void);
>   	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -45,8 +60,12 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
>   
>   #if defined(CONFIG_ARM_PSCI_FW)
>   int __init psci_dt_init(void);
> +void psci_set_reset_cmd(u64 psci_reset_cmd);
> +bool psci_has_system_reset2_support(void);
>   #else
>   static inline int psci_dt_init(void) { return 0; }
> +static inline void psci_set_reset_cmd(u64 psci_reset_cmd) { }
> +static inline bool psci_has_system_reset2_support(void) { return false; }
>   #endif
>   
>   #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
> 

