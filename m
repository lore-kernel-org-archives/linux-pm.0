Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B50C433FE
	for <linux-pm@archiver.kernel.org>; Mon, 10 Oct 2022 13:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJJNOR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJJNOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 09:14:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77D4615718;
        Mon, 10 Oct 2022 06:14:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 439E811FB;
        Mon, 10 Oct 2022 06:14:21 -0700 (PDT)
Received: from [10.57.5.39] (unknown [10.57.5.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 210953F766;
        Mon, 10 Oct 2022 06:14:11 -0700 (PDT)
Message-ID: <14be9c37-55af-54cf-fb08-406a2a6b8952@arm.com>
Date:   Mon, 10 Oct 2022 14:14:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] powercap: arm_scmi: Add SCMI Powercap based driver
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20220906142337.1697569-1-cristian.marussi@arm.com>
 <20220906142337.1697569-2-cristian.marussi@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220906142337.1697569-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

On 9/6/22 15:23, Cristian Marussi wrote:
> Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
> platform firmware for the list of existing Powercap domains, registers all
> of such discovered domains under the new 'arm-scmi' powercap control type.
> 
> A new simple powercap zone and constraint is registered for all the SCMI
> powercap zones that are found.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - using clamp_t() to simplify normalizations
> - cleanup style in block of var declarations
> - refactor scale conversions code
> - add MAINTAINER entry
> - refactored normalizations and added dev_dbg
> vOLD --> v1
> - fix _init cleaning up powerctrl zone on failure
> - removed uneeded casting
> - simplified normalization helpers
> ---
>   MAINTAINERS                          |   1 +
>   drivers/powercap/Kconfig             |  13 +
>   drivers/powercap/Makefile            |   1 +
>   drivers/powercap/arm_scmi_powercap.c | 508 +++++++++++++++++++++++++++
>   4 files changed, 523 insertions(+)
>   create mode 100644 drivers/powercap/arm_scmi_powercap.c
> 

Thanks for addressing my comments.
The code LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
