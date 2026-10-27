Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.42.129.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121579;
	b=V2C3B36w17kLWtzTcdrIjut9CdY+rwoVYLOZFCQ2B5MICteQH6sBX6jZj1iMFPodkxiq
	 WVCEi5grwaWfkxo5QWrzApvv58KqQY/QBbeAlDVdTjcWVyPEojcdBTTZ4lZ+fyliDv3ZL
	 Ko+pxvuLTiG/hbinldfTVywLoUDKhZ8HqvR7H1freXWI+Ej/dhW0Yn8YorlHn/8ypqtSb
	 MQJ9SZyfZt4yXoME6mkVJqxwAx4VHTTI4pZxf26BV3je1ALsX6hJ9VXNQ3Zp7P5m2JsSG
	 zFqc4e2Ou/4yQG2VYvSassjpCOtiLIzsrQSfObzoVcKt6PQlLMFoN5i7L4sU3w6+PIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121579;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lp3hOSIGPE1tppyJv1RE+JXMFvZyG7e+JE+3G2D1EhM=;
	b=fu0Ta493eOcwG38cTcKG9oFVA0f6yzOgsnKuahvV8KbujUEq7l1wYDHXGT3V1ymRpMcR
	 MnnKOyzalZQIMqg60wLTAURfGASLXD1zO0vALmFnD0V37kM+Ntc1deKvZQoNR20BokINm
	 q3vAcAD8+DLiWfNRm9C7oFc0c2p175gjnz0eBmetkd2//684xoPE3pPo0FiAHzTRAUnDX
	 AaCnR9e2kD9e8eovd8pldIHqtjwoFCTrRfQ/QDrrsSflR/pmQNWoBLTNDO6H9y6gTT2s+
	 yeEnbyF6Ex9/jJwSfzE5s78+XchtOPrfIGKv09CdmhIVOIiQ+0jzlpiULo+hC9Zhg3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ixit.cz;
	spf=pass smtp.mailfrom=ixit.cz;
	dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=YM8ItfqA;
	arc=none smtp.remote-ip=84.42.129.46
Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD6606A31A;
	Tue, 27 Oct 2026 17:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=YM8ItfqA
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 723EE5340910;
	Tue, 27 Oct 2026 18:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1793121569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lp3hOSIGPE1tppyJv1RE+JXMFvZyG7e+JE+3G2D1EhM=;
	b=YM8ItfqA4BF7rJZDIFswBTxxeSt2+Wmke/u8AQRSaWDIEkZBpQr6VW4vl4O7mke0AZpKtE
	rVqebQG/95qvDD25TnBI5HD1MN2Bh+SCXNfMu0IwB6JNxRMFe256XCsZyNNtXz1nnPNWAE
	AU+qWs7KjqVNem5fIqGtdh6urwU5IDA=
Message-ID: <6251801f-3662-4ad4-8d55-710144462010@ixit.cz>
Date: Tue, 27 Oct 2026 18:19:28 +0100
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
Subject: Re: [PATCH v4 2/2] power: supply: qcom_smbx: add SMB5 support
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>
References: <20260820-submit-qcom-smbx-send-v1-v4-0-818dabb2771e@snyders.xyz>
 <20260820-submit-qcom-smbx-send-v1-v4-2-818dabb2771e@snyders.xyz>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260820-submit-qcom-smbx-send-v1-v4-2-818dabb2771e@snyders.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 12:03, Robin Snyders via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Introduce support for the SMB5 charger found on PM7250B, PM8150B and
> related Qualcomm PMICs.
> 
> SMB5 uses different DCDC status offsets, charger-state encodings and
> electrical ranges. Select these from per-PMIC match data, with PM7250B
> using the PM8150B compatible fallback and parameter block. Read
> overvoltage from the SMB5 status bit, use the already-prescaled IIO
> voltage reading, and convert the SMB5 current-sense voltage to microamps.
> Use battery-info property presence when selecting voltage and current
> targets.
> 
> Keep Type-C power-role and VBUS control with the dedicated TCPM and
> regulator drivers. Clear the unsupported HVDCP negotiation modes so stale
> firmware settings cannot raise VBUS. Leave the firmware recharge policy
> unchanged and match the downstream default of ADC-based AICL disabled,
> while enabling periodic hardware AICL with its twelve-second SMB5 rerun
> interval. Preserve the existing three-second SMB2 interval.
> 
> PM8150B places the charger and VBUS regulator in the same DCDC peripheral,
> but the SMB5 path does not write the regulator registers. qcom_smbx reads
> 0x1108 and 0x110b, while qcom_usb_vbus-regulator writes 0x1140, 0x1152
> and 0x1153. The SMB2-only OTG configuration write to 0x1153 is not part
> of the SMB5 initialization sequence. The TCPM port and PD PHY use the
> separate 0x15xx and 0x17xx peripherals. Name the USBIN BC1.2 integration
> register and SMB2-only OTG definitions accordingly to make this ownership
> boundary explicit.
> 
> Program the battery limits and complete SMB5 input and charging setup
> from the power-supply registration init callback before device_add
> publishes the properties. This makes all public callbacks safe without
> driver-specific probe synchronization.
> 
> Suspend USB input and charging before SMB5 initialization. On a later
> failure, restore the original charging-enable state before the
> input-suspend state; leave the input suspended if charging cannot be
> restored. Cancel status work before unregistering the power supply during
> managed teardown. Update the Kconfig description to cover both charger
> generations.
> 
> On a OnePlus 7T Pro, register reads from the initial implementation
> confirmed the programmed 4.40 V, 1.50 A and 500 mA limits. A 180-second
> guarded charging trace and a subsequent 600-second runtime trace
> completed without crossing the voltage guard.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: Joel Selvaraj <foss@joelselvaraj.com>
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> Co-developed-by: Robin Snyders <robin@snyders.xyz>
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---
>   drivers/power/supply/Kconfig     |   8 +-
>   drivers/power/supply/qcom_smbx.c | 757 ++++++++++++++++++++++++++++++---------
>   2 files changed, 598 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index b89ef40df7f8..1159a7711919 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1173,13 +1173,13 @@ config BATTERY_CHARGER_SURFACE_RT
>   	  will be called surface-rt-ec.
>   
>   config CHARGER_QCOM_SMB2
> -	tristate "Qualcomm PMI8998 PMIC charger driver"
> +	tristate "Qualcomm SMB2 and SMB5 charger driver"
>   	depends on MFD_SPMI_PMIC
>   	depends on IIO
>   	help
> -	  Say Y here to enable the Qualcomm PMIC Charger driver. This
> -	  adds support for the SMB2 switch mode battery charger found
> -	  in PMI8998 and related PMICs.
> +	  Say Y here to enable the Qualcomm PMIC charger driver. This adds
> +	  support for the SMB2 and SMB5 switch-mode battery chargers found
> +	  in PMI8998, PM660, PM7250B and PM8150B PMICs.
>   
>   config FUEL_GAUGE_MM8013
>   	tristate "Mitsumi MM8013 fuel gauge driver"
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index 71f5a4859412..bc2b1cd3ed68 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -23,6 +23,13 @@
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> +enum smb_generation {
> +	SMB2,
> +	SMB5,
> +};
> +
> +#define SMB_REG_OFFSET(smb) ((smb)->gen == SMB2 ? 0x600 : 0x100)
> +

More and more as I look at it, this shouldn't be here, but within the 
device-tree as
charger@1000 {
     reg = <0x1000>, <0x1600>;  # SMB2, or
     reg = <0x1000>, <0x1100>;  # SMB5
};

But see also:
https://lore.kernel.org/all/eodzuccugtdn42basgpczett4yatyirog4nxwe5rhg5xf46ibp@jzcjmje4aqc3/

I'll try to do some basic separation so we know what bits belongs into which 
blog, keep you in CC.

David


[...]
