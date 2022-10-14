Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9FC4332F
	for <linux-pm@archiver.kernel.org>; Fri, 14 Oct 2022 10:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJNKvx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Oct 2022 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJNKvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 06:51:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3C5B2D776;
        Fri, 14 Oct 2022 03:51:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4BE13D5;
        Fri, 14 Oct 2022 03:51:56 -0700 (PDT)
Received: from bogus (unknown [10.57.35.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E113F792;
        Fri, 14 Oct 2022 03:51:45 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:51:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com, wzmuda@marvell.com,
        dan.carpenter@oracle.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v3 1/1] powercap: arm_scmi: Add SCMI Powercap based driver
Message-ID: <20221014105143.4yxldx2idqgvmzgu@bogus>
References: <20221013174612.393830-1-cristian.marussi@arm.com>
 <20221013174612.393830-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013174612.393830-2-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 13, 2022 at 06:46:12PM +0100, Cristian Marussi wrote:
> Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
> platform firmware for the list of existing Powercap domains, registers all
> of such discovered domains under the new 'arm-scmi' powercap control type.
>
> A new simple powercap zone and constraint is registered for all the SCMI
> powercap zones that are found.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org

From the core SCMI perspctive, this looks good. I don't have much in-depth
knowledge of powercap framework itself.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
