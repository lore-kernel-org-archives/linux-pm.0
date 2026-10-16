Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5858B6B1;
	Fri, 16 Oct 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172616; cv=none; b=hnfWrwksua8jey8H+kmqjwmH8PJLI4e5312L7lKOui+OXUFGU/ZrRLfwymzeRtXP9BECH2qDHMun833T4E6N/lzc6nJsDzkS5h6ijGSLDl5VU3hYrK9x3XETW1ox2MPMy9aMGqc55/0dG4J6+UQrLkC5qLsc0z1JatwYM2oqiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172616; c=relaxed/simple;
	bh=fM6XTWTLhnbCkPCUCjhMy0C1DVUHlxAhKyBRjw2sv4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw9ePc4U24CR/6jezZhv+2Sk5of3oXB53pnf0Gi0oldO2I0nBLakN6WMdv6xRl2qcDiBHUxda9FnwChvpjSn8QCZ8/r+7sJJf5fwi33tFOTvVJcrFx1VhZnvcDapm1JFRtlHQuhzfKIadDnMtD9bCGIaRiRz5FXNeed/aTmbAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=WTZEmU+y; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="WTZEmU+y"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 605265340216;
	Fri, 16 Oct 2026 19:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1792172611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zspz9CnfWuG9pRyJzbP33rK+tRLq2h6Xi9Cmp1yWjEc=;
	b=WTZEmU+yvE4FD7fdl93sQug/2tx14M/LK8mJvg+TetzIBsfTOQCk04p9gXhpSGuRx0roCl
	d6lPTFljWP8T5qesH8oOFr0erhkQB8i8MVXM/vBFjyA0JZFXuk8DxUKqdM6o/HC9aIE3+X
	I4A2Xa1tEP7JIVH2d0bdY7WB7dohmLU=
Message-ID: <138d527f-c19b-463a-b405-43fc0ec7c603@ixit.cz>
Date: Fri, 16 Oct 2026 19:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] power: supply: qcom_smbx: add SMB5 support
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>
References: <20260820-submit-qcom-smbx-send-v1-v4-0-818dabb2771e@snyders.xyz>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260820-submit-qcom-smbx-send-v1-v4-0-818dabb2771e@snyders.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 12:03, Robin Snyders via B4 Relay wrote:
> Add support for the SMB5 charger generation found in PM7250B and
> PM8150B to the existing qcom_smbx driver.
> 
> The series extends the binding and selects register layouts, charger
> status encodings and electrical limits from per-PMIC match data. Encode
> PM7250B as PM8150B-compatible in the binding and let the compatible
> fallback select the shared charge-parameter block, including the +0x08
> effective input-current status register. Convert the SMB5 0.2 V/A USB
> current-sense voltage measurement to microamps while leaving the SMB2
> current reading unchanged.
> 
> SMB5 setup suspends USB input and disables charging before configuration.
> The power-supply registration init callback programs battery limits and
> completes final input and charging setup before device_add publishes the
> properties, so public callbacks cannot observe partially initialized
> hardware. Managed rollback restores the charging state before the USB input
> state; if charging cannot be restored, USB input remains suspended. Managed
> teardown cancels status work before unregistering the power supply.
> 
> Enable periodic hardware AICL with the downstream twelve-second rerun
> interval while leaving ADC-based AICL disabled by default. Clear the
> unsupported HVDCP modes so firmware state cannot raise VBUS, and do not
> override the firmware recharge policy without a binding input. The
> dedicated TCPM and VBUS regulator drivers retain ownership of Type-C
> power-role and VBUS control.
> 
> On PM8150B, the SMB5 charger and VBUS regulator use the same DCDC
> peripheral but do not write the same registers. qcom_smbx only reads
> 0x1108 and 0x110b there; qcom_usb_vbus-regulator writes 0x1140, 0x1152
> and 0x1153. The qcom_smbx write to 0x1153 belongs only to the SMB2
> initialization sequence and is not executed for SMB5. The TCPM port and PD
> PHY use the separate 0x15xx and 0x17xx peripherals. Patch 2 names the
> USBIN BC1.2 integration register and SMB2-only OTG definitions explicitly
> to document this boundary.
> 
> Apply the five-patch qcom_smbx Fixes series before this one. This series is
> based on power-supply for-next (99b38cda3f4c). The b4 dependency metadata
> records all five prerequisite patch IDs. This ordering preserves the SMB2
> watchdog, health, overvoltage and float-voltage fixes across the SMB5
> driver refactoring. The prerequisite series is public at:
> https://lore.kernel.org/r/20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz/
> 
> The v3 implementation was tested on a OnePlus 7T Pro (HD1913) with
> PM8150B. Register reads confirmed 4.40 V, 1.50 A and 500 mA limits. A
> 180-second guarded charging trace and a subsequent 600-second runtime
> trace completed with health Good and the input current below its 500 mA
> limit. After a physical USB-C disconnect and reconnect, USB networking and
> the charger recovered automatically; a further 60-second trace remained
> Good and below the input-current limit. The final kernel log had no SMB5
> warning, error, oops or lockdep report.
> 
> The v4 driver was rebuilt and retested on the same device. A 180-second
> trace and a 600-second, 121-sample guarded trace completed with the charger
> online, health Good and no guard failure. With a powered USB-C dock, the
> phone remained the data host and PD power sink; with the dock unpowered, it
> remained the data host and enabled the VBUS regulator as the power source.
> The USB 2 and USB 3 hubs, storage and RTL8153 interface enumerated in both
> connector orientations, and 64 MiB read-only storage reads produced the
> same hash in all four dock configurations. Reconnecting the phone directly
> to the PC restored the power-sink/device roles, charging, NCM and SSH
> without a reboot. Ethernet traffic and visual DisplayPort output were not
> tested in this run because no Ethernet carrier or display was available.
> The final kernel log had no SMB5, Type-C or VBUS warning, error, oops or
> lockdep report.
> 
> The driver builds with LLVM W=1 and passes Sparse. The binding passes
> dt_binding_check, and both patches pass checkpatch --strict. A full LLVM
> Image, modules and DTBs integration build completed and booted on the test
> device.
> 
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---
> Changes in v4:
> - Make the PM8150B charger, VBUS regulator and TCPM register ownership
>    explicit, including the shared DCDC peripheral's disjoint accesses.
> - Rename the USBIN BC1.2 integration register and SMB2-only OTG definitions
>    to prevent them from being mistaken for SMB5 TCPM/VBUS controls.
> - Test powered sink/host and unpowered source/host USB-C dock operation in
>    both connector orientations, including storage I/O and gadget recovery.
> - Link to v3: https://lore.kernel.org/r/20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz
> 
> Changes in v3:
> - Complete SMB5 input and charging setup in the pre-device_add power-supply
>    registration init callback instead of gating setters on a driver-specific
>    probe flag.
> - Register the power supply and initialize managed status work before
>    requesting IRQs so handlers cannot observe an unassigned power supply.
> - Let PM7250B match the required PM8150B compatible fallback and remove its
>    duplicate match-data entry.
> - Collect the binding Reviewed-by tag.
> - Link to v2: https://lore.kernel.org/r/20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz
> 
> Changes in v2:
> - Rebase onto power-supply for-next 99b38cda3f4c.
> - Encode PM7250B with the required PM8150B compatible fallback.
> - Leave SMB5 Type-C power-role and VBUS control to the TCPM and regulator
>    drivers.
> - Preserve the SMB2 3-second AICL interval and use the SMB5 downstream
>    12-second interval; leave ADC-based AICL disabled by default.
> - Disable unsupported HVDCP negotiation deterministically.
> - Do not override the firmware recharge policy without a binding input.
> - Model PM7250B with PM8150B electrical limits and the +0x08 AICL ICL
>    status register.
> - Convert the SMB5 0.2 V/A USB current-sense reading to microamps while
>    leaving the SMB2 current reading unscaled.
> - Program battery limits in the pre-device_add registration init callback
>    and gate setters until probe completes.
> - Order managed teardown so status work is cancelled before the power
>    supply is unregistered.
> - Restore charging before USB input on probe failure, and leave input
>    suspended if charging restoration fails.
> - Correct the SMB5 overvoltage register and charger-state decoding.
> - Avoid repeated error logs when polling a persistent overvoltage state.
> - Use battery-info property presence when selecting charge targets.
> - Remove duplicate scaling from the already-prescaled USB voltage reading
>    and clarify the binding IIO channel descriptions.
> - Update the binding title, Kconfig prompt and module description for both
>    charger generations.
> - Move the five pre-existing SMB2 fixes to a prerequisite Fixes series.
> - Link to v1: https://lore.kernel.org/r/20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz
> 
> ---
> Casey Connolly (2):
>        dt-bindings: power: supply: qcom,pmi8998-charger: add SMB5 PMICs
>        power: supply: qcom_smbx: add SMB5 support
> 
>   .../power/supply/qcom,pmi8998-charger.yaml         |  17 +-
>   drivers/power/supply/Kconfig                       |   8 +-
>   drivers/power/supply/qcom_smbx.c                   | 757 ++++++++++++++++-----
>   3 files changed, 609 insertions(+), 173 deletions(-)
> ---
> base-commit: 99b38cda3f4c486cfbc40f3c8ede1703594e9f13
> change-id: 20260811-submit-qcom-smbx-send-v1-69acefa61977
> prerequisite-patch-id: 3d8a9cf43b5e5eac64a60aeec5e9c90880bcf792
> prerequisite-patch-id: de3e3b494f9644596cfa4cafc362ca0b48288c45
> prerequisite-patch-id: d5e22a0fe7cd55374f60d7c2cb14ed3df8f94e0b
> prerequisite-patch-id: 9eafa41402e97d6a3e5369bec46df4e9db3d2af6
> prerequisite-patch-id: 5638b901cd10773fa9485605f84b25a1dd826a84

Hello Robin,

the prerequisites got in, since this patch is pretty big other 
fixes/improvements are getting queued, could you please rebase on top of latest 
linux-next and send next version please?

Thank you for your work
David

P.S. so far your series still applied on sdm845 and no issues.

> 
> Best regards,

