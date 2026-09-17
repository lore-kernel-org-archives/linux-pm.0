Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC051D51A;
	Thu, 17 Sep 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656322; cv=none; b=LfGIbXph3CIz+aLwllJEsmRfTvYs2+ejB/PyTE3IysgyB9Rka5+hIO0j9yrcl5FLWoOZEEYmXX9Ns0VelgrHqtMKO2NckxLe5LqqVjsfue2KRd5+V9HsipGaEO126dhaka0RrILITCSbKPnIcMFUVA29lU6lLQmlDCkbp44g53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656322; c=relaxed/simple;
	bh=tNMI+unbbhAk3m2HZHleqT/GIgLAApbvWU8iG4tFJpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hl2hIkCwmj11qw7ZG6rd0cdbo8Q8oGRbNByZmNQDSi6IDiNUsDBjQKY8vksPLkdRwHXQiKbtLQl73jQQw5rio/drare0ivg6G08gJt4Pao4UIJSq6h0T9GgOe1N9gJBrcsmnce2ArnyYn6Vad28autdqUHkurRQ8YoxhNdjvE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gtzfmaWi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gtzfmaWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789656307;
	bh=tNMI+unbbhAk3m2HZHleqT/GIgLAApbvWU8iG4tFJpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtzfmaWivaS2wKXOsIPaL2GU/aRv5pmTRdiBnPFRjuLWYAEa2xZkoeJoAzF/6nlgp
	 LkmyHBeuIBdbxHF5tF2BC6ER4nkfsc0SfYj/wDhB4m66YkFxj+ekatZMbEDe4It/rn
	 OW1DmKkrHOC53nUT2jDo+ViVoOHRdN50yDYOJxCza7c5LEcDtlXbrXIu0pZNxZ05rs
	 QLuZen+V+R39g2Lu03qAuvLG2q7ZseQOhua1Vc5n1Fw44vlr/HUT4HdGwy+lxu2lup
	 /ncmzFw7mytCIY5pLOKhzFh57sZYFy/ohKjlsWvPiH34DkdzxB/Uerjta8TYyDOzGF
	 fWvHUus9JF4Cg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE73417E01C5;
	Thu, 17 Sep 2026 16:45:06 +0200 (CEST)
Message-ID: <231214ab-9ae9-4e3f-a75b-d65a597e9956@collabora.com>
Date: Thu, 17 Sep 2026 16:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/12] SPMI: Implement sub-devices and migrate drivers
To: jic23@kernel.org, sboyd@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
 krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
 melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
 ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com,
 konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com,
 krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 11:36, AngeloGioacchino Del Regno wrote:
> Changes in v13:
>   - Removed `if (IS_ENABLED(CONFIG_OF))` check in spmi_dev_release (Andy)
>   - Rebased (though still applies cleanly) over next-20260720
> 

Is there any further comment on this series?

Cheers,
Angelo

> Changes in v12:
>   - Removed call to of_node_put() for failure as it's being already
>     done in spmi_dev_release(), as pointed out by Sashiko
>   - Fixed usage of the new helper in all users (it's too hot today, sorry)
> 
> Changes in v11:
>   - Use kzalloc_obj() in spmi_subdevice_alloc_and_add()
>   - Introduced new helper to get a parent SPMI device which verifies
>     both if the device has parent and if that parent is effectively
>     a SPMI device type
>   - Removed dev->parent NULL checks in all migration code, as that
>     is now being checked in the new helper instead, reducing the
>     amount of required lines of code to instantiate a SPMI subdevice
>   - Moved of_node reference dropping to dev release callback (Sashiko)
>   - Rebased over next-20260706
> 
> Changes in v10:
>   - Add use-after-free fix rebased to before this series, as the v1 of
>     that did not apply cleanly on a tree without this series applied
>   - Replace unsafe to_spmi_device() with spmi_find_device_by_of_node() (Sashiko)
>   - Fix -Wformat warning in dev_set_name call (Sashiko)
> 
> Changes in v9:
>   - Added check for dev->parent where missing (Sashiko)
>   - Changed %d to %u in dev_set_name() call as arg is unsigned (Sashiko)
>   - Propagating error code from devm_regmap_init_spmi_ext() instead of
>     returning -ENODEV in phy-qcom-eusb2-repeater.c (Sashiko)
>   - Rebased over next-20260605 (no conflicts anyway)
> 
> Changes in v8:
>   - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
>   - Changed kerneldoc wording to "error pointer" for function
>     spmi_subdevice_alloc_and_add() (Andy)
>   - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
>   - Used device_property_read_u32() instead of of_property_read_u32()
>     in all of the migrated drivers (Andy)
>   - Changed .max_register field in all of the migrated drivers from
>     0x100 to 0xff (Andy)
>   - Kept `sta1` declaration in reversed xmas tree order in function
>     iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)
> 
> Changes in v7:
>   - Added commit to cleanup redundant dev_name() in the pre-existing
>     spmi_device_add() function
>   - Added commit removing unneeded goto and improving spmi_device_add()
>     readability by returning error in error path, and explicitly zero
>     for success at the end.
> 
> Changes in v6:
>   - Added commit to convert spmi.c to %pe error format and used
>     %pe error format in spmi_subdevice code as wanted by Uwe Kleine-Konig
> 
> Changes in v5:
>   - Changed dev_err to dev_err_probe in qcom-spmi-sdam (and done
>     that even though I disagree - because I wanted this series to
>     *exclusively* introduce the minimum required changes to
>     migrate to the new API, but okay, whatever....!);
>   - Added missing REGMAP dependency in Kconfig for qcom-spmi-sdam,
>     phy-qcom-eusb2-repeater and qcom-coincell to resolve build
>     issues when the already allowed COMPILE_TEST is enabled
>     as pointed out by the test robot's randconfig builds.
> 
> Changes in v4:
>   - Added selection of REGMAP_SPMI in Kconfig for qcom-coincell and
>     for phy-qcom-eusb2-repeater to resolve undefined references when
>     compiled with some randconfig
> 
> Changes in v3:
>   - Fixed importing "SPMI" namespace in spmi-devres.c
>   - Removed all instances of defensive programming, as pointed out by
>     jic23 and Sebastian
>   - Removed explicit casting as pointed out by jic23
>   - Moved ida_free call to spmi_subdev_release() and simplified error
>     handling in spmi_subdevice_alloc_and_add() as pointed out by jic23
> 
> Changes in v2:
>   - Fixed missing `sparent` initialization in phy-qcom-eusb2-repeater
>   - Changed val_bits to 8 in all Qualcomm drivers to ensure
>     compatibility as suggested by Casey
>   - Added struct device pointer in all conversion commits as suggested
>     by Andy
>   - Exported newly introduced functions with a new "SPMI" namespace
>     and imported the same in all converted drivers as suggested by Andy
>   - Added missing error checking for dev_set_name() call in spmi.c
>     as suggested by Andy
>   - Added comma to last entry of regmap_config as suggested by Andy
> 
> While adding support for newer MediaTek platforms, featuring complex
> SPMI PMICs, I've seen that those SPMI-connected chips are internally
> divided in various IP blocks, reachable in specific contiguous address
> ranges... more or less like a MMIO, but over a slow SPMI bus instead.
> 
> I recalled that Qualcomm had something similar... and upon checking a
> couple of devicetrees, yeah - indeed it's the same over there.
> 
> What I've seen then is a common pattern of reading the "reg" property
> from devicetree in a struct member and then either
>   A. Wrapping regmap_{read/write/etc}() calls in a function that adds
>      the register base with "base + ..register", like it's done with
>      writel()/readl() calls; or
>   B. Doing the same as A. but without wrapper functions.
> 
> Even though that works just fine, in my opinion it's wrong.
> 
> The regmap API is way more complex than MMIO-only readl()/writel()
> functions for multiple reasons (including supporting multiple busses
> like SPMI, of course) - but everyone seemed to forget that regmap
> can manage register base offsets transparently and automatically in
> its API functions by simply adding a `reg_base` to the regmap_config
> structure, which is used for initializing a `struct regmap`.
> 
> So, here we go: this series implements the software concept of an SPMI
> Sub-Device (which, well, also reflects how Qualcomm and MediaTek's
> actual hardware is laid out anyway).
> 
>                 SPMI Controller
>                       |                ______
>                       |               /       Sub-Device 1
>                       V              /
>                SPMI Device (PMIC) ----------- Sub-Device 2
>                                      \
>                                       \______ Sub-Device 3
> 
> As per this implementation, an SPMI Sub-Device can be allocated/created
> and added in any driver that implements a... well.. subdevice (!) with
> an SPMI "main" device as its parent: this allows to create and finally
> to correctly configure a regmap that is specific to the sub-device,
> operating on its specific address range and reading, and writing, to
> its registers with the regmap API taking care of adding the base address
> of a sub-device's registers as per regmap API design.
> 
> All of the SPMI Sub-Devices are therefore added as children of the SPMI
> Device (usually a PMIC), as communication depends on the PMIC's SPMI bus
> to be available (and the PMIC to be up and running, of course).
> 
> Summarizing the dependency chain (which is obvious to whoever knows what
> is going on with Qualcomm and/or MediaTek SPMI PMICs):
>      "SPMI Sub-Device x...N" are children "SPMI Device"
>      "SPMI Device" is a child of "SPMI Controller"
> 
> (that was just another way to say the same thing as the graph above anyway).
> 
> Along with the new SPMI Sub-Device registration functions, I have also
> performed a conversion of some Qualcomm SPMI drivers and only where the
> actual conversion was trivial.
> 
> I haven't included any conversion of more complex Qualcomm SPMI drivers
> because I don't have the required bandwidth to do so (and besides, I think,
> but haven't exactly verified, that some of those require SoCs that I don't
> have for testing anyway).
> 
> 
> AngeloGioacchino Del Regno (12):
>    spmi: Fix potential use-after-free by grabbing of_node reference
>    spmi: Remove redundant dev_name() print in spmi_device_add()
>    spmi: Print error status with %pe format
>    spmi: Remove unneeded goto in spmi_device_add() error path
>    spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
>    spmi: Add helper to get a parent SPMI device
>    nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
>    power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
>    phy: qualcomm: eusb2-repeater: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
> 
>   drivers/iio/adc/qcom-spmi-iadc.c              | 116 ++++++++---------
>   drivers/misc/Kconfig                          |   2 +
>   drivers/misc/qcom-coincell.c                  |  45 +++++--
>   drivers/nvmem/Kconfig                         |   1 +
>   drivers/nvmem/qcom-spmi-sdam.c                |  41 ++++--
>   drivers/phy/qualcomm/Kconfig                  |   2 +
>   .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  52 +++++---
>   drivers/power/reset/qcom-pon.c                |  31 +++--
>   drivers/spmi/spmi-devres.c                    |  24 ++++
>   drivers/spmi/spmi.c                           | 121 ++++++++++++++++--
>   include/linux/spmi.h                          |  17 +++
>   11 files changed, 325 insertions(+), 127 deletions(-)
> 
