Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456D2EAD15
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207550; cv=none; b=KVcrBsdmlfIXobRphzsLKrLw2lWdhyRy65bvEiz3G8T1WkWYFBP33xpw5ya993sn4k4oacjnAYN3yL7DRrFAwgUFx01oTQ4TRl6L8x77uSQrbUmhfCVlO/mgTq0qHFqfY927CeTFVsu5QQeVeF5YU8WtcDLS1hb4BYY2WCN7cco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207550; c=relaxed/simple;
	bh=Z/G5tA8+is41cOkLjE38QNDTd4NOwFeKP2pfQ9zPY5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gik/NT6AyCsSgSI4DpoPJLe0HDPWtTjyBiB3RbAD8tygdauILe058/7/kar1TpGaReE//DJ4FCHWk25ucHDL+U4X3D46Cp+U4OsgQdUkqUepSa7t3U2wQGdFJosVMEgN2iOw9hidlq9f/NBx2320mjqAUYMiUdEeYlNkDa8kABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c3rA4JMQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WpPoL/Bx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c3rA4JMQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WpPoL/Bx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6GM0t1006234
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 06:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//htdwkL/78TcjodbvcTISK7bM+zdIfRZiL5zVJBctc=; b=c3rA4JMQlt1ZJIJF
	CNgLku0oUte0SMby69XIjvXs80xdDbR8FSIabp8I68z0mmFCNufcTLt1S/XQeDsp
	xfhcBxjVgorQbyMVy0C9CVg5opdMnpaak2Hkh6BDkrHWUMxTcNTPiA49SKWYd55L
	qVGEqD5VUB0oOkqwkCLejs3Tkqg3aY7/i2toxSbN9Lt8sb/ZGCtmjwHk6WybaKIi
	RbkrDd3yqjbHoNAmwhJOrwlRlAY0r5JFb7rtMKbxTgJH+WiS2O2O7LgGKW9/eJA0
	/yWrbepP53ohLxBts6daiq/zn7pkjas89fVZHJodjk4sgxG/ws44qTTHONRfgTAj
	sjWloQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc3fs5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 06:32:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so3816300a91.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 23:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787207547; x=1787812347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//htdwkL/78TcjodbvcTISK7bM+zdIfRZiL5zVJBctc=;
        b=WpPoL/BxF8zxKbaXWFArQcuzbK6yPeISu5o6gMBzXC9ca9BwM61KxvSrlWSFlPvOEt
         dv2/Pk5EwTl7HMB5pszPIwUw47s2R47iLaBNTAC/TFT6N3ZM2yFojTr79fwRG1IVs3eb
         PZf02kAlAA+TOWIhrNL+LMcoEVNN6LH2FFtCIQhyDuYVIvNiQIsAlZUCjavpK4mZdAcv
         wrPF0yzS+mykZTO6H9GfcnygXl2fCyP3uCWVnu4irg63jxhBzNczNCBXy8nKS1wQlQih
         YKX+Ocs7ZZ6js76jYGLDfzzXeuRLKe9eVXi4DoZEOX8XxwqVkgLyKA72wSNoQF7XRzgm
         xilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787207547; x=1787812347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//htdwkL/78TcjodbvcTISK7bM+zdIfRZiL5zVJBctc=;
        b=cLIGkI0pY9XdKdFFQYNdenSAjiiyOzphdbqB91mE2VzqTiz8Nl9yeaa2iJLjaFVrts
         x2jpHJ98QISJAEnyQmv3CtKR9qDQBmnbo/2NuQCTNRbZ2twgNtFLNw3wZiWW/277DuXg
         jqNERBta76G+nhCnkmrtJO45gqAxfouVR02N2FLz3tGOLI7vPcRKrBaEGwrfKDOncAyY
         bklRkgbGJAWe63unJhh8PD4Gbv94Ein06RYvvKPh86wCTaw2CqZgsZeaRXxcjDsBMSiD
         /YbxsniYFtIpM3xngZYinJyTDwGr/Gd71FWl0eRf4V72MPrOup3ZPnlncxmNru778YjB
         3TZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmH4W8giwjkMOAtS/uQBE1etP5NMbzMdCbzRMqvhynmvnyll3iHjA3ana3Hnlo+VXHnoeWmT9LPw==@vger.kernel.org
X-Gm-Message-State: AFuF++nBAxDIOK4ftWRuJYp1FRDGsMXnvQE2BrSPBotX1S+ytmD+Q+xC
	2iWvgRx3oRInqf7HZTKrnTYwHPyjtQqLOFjZjX3cZBtlv9CN+CleI5zHMkwiZQwTxtu346dwcs7
	LJt40+3TnGWsKJ0vamh9ADdW5QAMF+PioGtPyGX138drpsxco+J2WWCwYx5Ze8jIp22COnQ==
X-Gm-Gg: AR+sD10nM7a67X7fDIox32nBP4Yfj3cbUHsTPQYwtGv/1fmsZ3vRoFNBnvt4FA4DHr7
	Zxnh3ACAH+N7UvoHYngu9hbOUHNRWi660eZJybsZYt7V6CTVfW3HGFtKwGtrnDUDgBCRmCUY1ia
	HbPbkBVdTHijqW6ojixWdnKpDZcgX09ztqJPnarqD+I/BEOwzb2Z6k2y9+CQI6Gbe0EBZ9CkSsB
	mgt+3HrGe7p83oQETof1rCfV0deXoUujsj/8YEgbo7eEPDmIIncl8abidIbQLsClnFcr9wUQKEi
	DzudPlSyPw65WzYfODN2xi2Jd+2tPvQp5/4HdA9FmOKcxr6HzKjqp1vTbXHK7UUIQa2/EgE3YBk
	TZeE8sR+XhFtFfr/izLzvL8kVeMDraI4=
X-Received: by 2002:a17:90b:2b4f:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39580f0d585mr20497446a91.6.1787207546467;
        Wed, 19 Aug 2026 23:32:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4f:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39580f0d585mr20497312a91.6.1787207545824;
        Wed, 19 Aug 2026 23:32:25 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395a9bc47ffsm482602a91.0.2026.08.19.23.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 23:32:25 -0700 (PDT)
Message-ID: <9eb142ae-9f79-4f7f-91ae-6a49a7103dfd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Add support for Qualcomm remoteproc subsystem
 cooling
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qHT1kZCFq8IrDnnkrpDnpCMoK3XN2Bwi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX9yW49tKNO8BE
 ALiKkFFmCKSSg2z+LfC5euJzglK5p7rYKH3LcQJPvL4lF5WpXHlM6r6npfURwVa++ybV5zfpCnl
 HRLwb6uGxvY4k0ucV7t/Eu0WGOFwdhE=
X-Proofpoint-ORIG-GUID: qHT1kZCFq8IrDnnkrpDnpCMoK3XN2Bwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfXzXqQ9GCL035c
 sX5OVd9ZsfZ5Ir4uopHNs7B7fD8ih3XJQiEhHmcmGze6XRkVDnyHjfWDhlyp9NwBvJuh5/elFMF
 xno61wBMhNb0bZcebdfyPw1kNNsgUC2fM3mXz70J36KeTlD68gtWf4T7moAIp3jdzA3AJb03utd
 puBNJkxiuT1d5l/4N5m70FsvziM0EADAHOF7XUikehrua49Xupk7h/UECVYUgoFj3uAzQic+0o5
 xpse3UXAAEVa5BBl3FzF3mg3rGbVZtDB+QWKa5/EZht/EnMbJ3kDxydEpKanpmCYCsEPvFLu9T3
 Qfnd+noCP3ohhxuzr5TuCv8w3MnWZ+QP78026UlSngg57LUwUr6x6Vvvsj/GGLpHUhLk0yZPv+e
 A8D/nvX8hX2NJMKPYwEOCRgeE6a76RhTyLanYQ9Xk4/P+oUyQXXD9W81MRQvGwLj05UPIEbiqiO
 errbrrCeULDtUCTdtvw==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a869f7c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yPFEGgveNQz0cEWlPAoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200046

Hi Bjorn, Mathieu,

Just wanted to kindly check if this series can be picked up.

Patch 1 has Krzysztof's Reviewed-by and Daniel's Acked-by, and the later
patches carry the review tags received in previous versions.

Please let me know if you would prefer any changes or a resend.

Thanks,
Gaurav


On 8/9/2026 5:58 PM, Gaurav Kohli wrote:
> This series introduces Qualcomm Messaging Interface based Thermal
> Mitigation Device (QMI TMD) support to control thermal mitigation
> on remote subsystems such as the Modem and CDSP.
> 
> The QMI TMD is an interface that instructs a remote subsystem to adjust
> the performance level of the devices it manages, reducing power consumption
> in response to critically low battery charge, overcurrent alerts, or
> overheating conditions.
> 
> The series is organized as follows:
> 
>   - Add a shared dt-bindings header mapping TMD device indices for use
>     in DT cooling-maps, ensuring a consistent binding between the thermal
>     zone and the QMI TMD driver.
> 
>   - Extend the remoteproc PAS binding with the optional #cooling-cells
>     property to allow remoteproc nodes to be referenced as cooling devices.
> 
>   - Add QMI TMD support in the remoteproc PAS framework, hooking into
>     the probe/unregister lifecycle to register and unregister cooling
>     devices with the thermal framework.
> 
>   - Enable CDSP and Modem cooling on kodiak, lemans, talos, monaco and
>     hamoa platforms using the new binding.
> 
> Not all TMD endpoints advertised by the firmware are wired into kernel
> thermal zones. Endpoints such as BCL (battery current limiting) and cold
> temperature protection are handled from userspace via qmi and do not
> require kernel thermal zone bindings.
> 
> The constants defined in this series cover only the endpoints actively
> used for thermal mitigation in the kernel thermal framework on the
> currently posted targets: cdsp_sw (CDSP software thermal limit), pa
> (modem power amplifier), and modem.
> 
> This work revives the earlier QMI cooling series by Casey Connolly [1],
> with the following key differences:
>   - Uses an id based API for cooling-device binding
>   - Integrates QMI TMD directly into the remoteproc PAS framework and
>     hooks into the probe/unregister lifecycle.
>   - Removes unused code and cleans up macro names
> 
> This series depends on cooling device id support from Daniel Lezcano [2].
> 
> [1] https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
> [2] https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/
> 
> ---
> Changes in v8:
> - Added Reviewed-by tags from Abel and Krzysztof.
> - Return -ENOTCONN when QMI TMD is disconnected.
> - Use label references for Hamoa IoT NSP trip overrides. (Stephan)
> - Link to v7: https://lore.kernel.org/r/20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com
> 
> Changes in v7:
> - Added Daniel's Acked-by/Reviewed-by tags.
> - Serialized cur_state update with QMI state request. (Sashiko)
> - Link to v6: https://lore.kernel.org/r/20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com
> 
> Changes in v6:
> - Added Reviewed-by tags from Dmitry.
> - Kodiak: delete MPSS cooling maps by label on non-modem boards. (Dmitry)
> - Renamed qcom,qmi-tmd.h to qcom,pas.h. (Krzysztof)
> - Made QCOM_QMI_TMD tristate to fix unmet dependency issue. (Sashiko)
> - Removed redundant negative TMD id check in qcom_pas_setup_tmd(). (Dmitry)
> - Fixed QMI_DATA_LEN type issue by using u32. (Sashiko)
> - Link to v5: https://lore.kernel.org/r/20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com
> 
> Changes in v5:
> - Added Reviewed-by tag (Daniel Lezcano)
> - Squashed dt-bindings header patch into the yaml binding patch.(Krzysztof)
> - Renamed constants: QCOM_CDSP_TMD_CDSP_SW -> QCOM_TMD_CDSP_SW,
>    QCOM_MODEM_TMD_PA -> QCOM_TMD_PA, QCOM_MODEM_TMD_MODEM ->
>    QCOM_TMD_MODEM.(Krzysztof)
> - Replaced dev_err() with dev_err_probe() in qmi_tmd_init() (Krzysztof)
> - Fixed qmi_tmd_exit() teardown order to prevent cancel_work_sync()
>    re-queue race.(Krzysztof)
> - Removed only MPSS maps instead of entire cooling-maps node.(Dmitry)
> - Added cover letter note clarifying TMD endpoint selection rationale.(Dmitry)
> - Added NET dependency in Kconfig.(Julian)
> - Link to v4: https://lore.kernel.org/r/20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com
> 
> Changes in v4:
> - Drop the tmd-names DT property.
> - Move TMD instance id and tmd device name into PAS platform data.
> - Add a shared dt-bindings header to define numeric constant for TMD id.
> - Add mutex documentation comments for get/set state callbacks.
> - Link to v3: https://lore.kernel.org/r/20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com
> 
> Changes in v3:
> - Removed the remoteproc-cooling abstraction approach.
> - Integerated QMI TMD with remoteproc core framework.
> - Cleaned the macro names and removed unused code.
> - Switched to index-based thermal_of_cooling_device_register() api.
> - Link to v2: https://lore.kernel.org/linux-devicetree/20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com/
> 
> Changes in v2:
> - Update Remoreproc thermal config to tristate and removed unnecessary NULL checks.
> - Fixed dt binding file format and added generic name support for cdsp.
> - Fixed memory leak and cleaned up qmi-cooling driver file.
> - Corrected DT formatting errors and commit descriptions for all targets.
> - Link to v1: https://lore.kernel.org/linux-devicetree/20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com/
> ---
> 
> ---
> Casey Connolly (1):
>        soc: qcom: Add QMI TMD support for remote thermal mitigation
> 
> Dipa Ramesh Mantre (1):
>        arm64: dts: qcom: hamoa: Enable CDSP cooling
> 
> Gaurav Kohli (7):
>        dt-bindings: remoteproc: qcom,pas: add #cooling-cells property
>        remoteproc: qcom: pas: add support for TMD thermal cooling devices
>        remoteproc: qcom_q6v5_pas: enable QMI TMD cooling support
>        arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
>        arm64: dts: qcom: lemans: Enable CDSP cooling
>        arm64: dts: qcom: talos: Enable CDSP cooling
>        arm64: dts: qcom: monaco: Enable CDSP cooling
> 
>   .../bindings/remoteproc/qcom,pas-common.yaml       |   9 +
>   MAINTAINERS                                        |   8 +
>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  16 +
>   arch/arm64/boot/dts/qcom/hamoa.dtsi                |  63 +++
>   arch/arm64/boot/dts/qcom/kodiak.dtsi               | 125 +++++
>   arch/arm64/boot/dts/qcom/lemans.dtsi               | 125 ++++-
>   arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
>   .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   8 +
>   .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |   8 +
>   .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |   8 +
>   .../boot/dts/qcom/qcs6490-vicharak-axon-mini.dts   |   8 +
>   .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  10 +
>   .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |   9 +
>   arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
>   drivers/remoteproc/Kconfig                         |   1 +
>   drivers/remoteproc/qcom_q6v5_pas.c                 | 117 +++-
>   drivers/soc/qcom/Kconfig                           |  12 +
>   drivers/soc/qcom/Makefile                          |   1 +
>   drivers/soc/qcom/qmi_tmd.c                         | 595 +++++++++++++++++++++
>   include/dt-bindings/thermal/qcom,pas.h             |  20 +
>   include/linux/soc/qcom/qmi.h                       |   1 +
>   include/linux/soc/qcom/qmi_tmd.h                   |  36 ++
>   22 files changed, 1285 insertions(+), 13 deletions(-)
> ---
> base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> change-id: 20260715-b4-qmi-tmd-d23e8df1b282
> 
> Best regards,

