Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B419CD6E7F
	for <linux-pm@archiver.kernel.org>; Wed, 11 Oct 2023 15:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjJKPtk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJKPtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 11:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC7A4;
        Wed, 11 Oct 2023 08:49:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50FCC433C7;
        Wed, 11 Oct 2023 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697039378;
        bh=+4vMMnbz6QM3xqt6SUWU/u/wTBq1TQ2bMWhWyVpP1ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neKr/JAWpIGZ6cQ0odUAwAzsX3izewlUsu5qdv35VN0D0QoFSqseHZk/VhagElKQ7
         xO/Ep7SaCKgWM9l2v3e9586y8od72dvk7klu6xqQROrtbzceADDqAQZ9HU88O8eEo2
         A1tkawJa3OkYvdouGHXKnYtjiLqtobcRHjy3L+13H6maeJxrYjzpnWAWNutUG/BOFg
         K5vncX1Z4QhvXx3Rm9P3k7es1t7wWcZyDH3bM812FIHy1bi7WyNrx8MlmX+FYoSxF+
         GErynuIp6oa2BbpPsQdRkeeggaHiZHdJkCL7/U+mh/ld31fKEpSxLaOpxR/y7NvWsB
         YHcVjWyd/pqaQ==
Received: (nullmailer pid 793454 invoked by uid 1000);
        Wed, 11 Oct 2023 15:49:35 -0000
Date:   Wed, 11 Oct 2023 10:49:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v4 08/23] soc: qcom: Add driver for Qualcomm Krait L2
 cache scaling
Message-ID: <20231011154935.GA785564-robh@kernel.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827115033.935089-9-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 27, 2023 at 02:50:18PM +0300, Dmitry Baryshkov wrote:
> Add a simple driver that handles scaling of L2 frequency and voltages.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +static const struct of_device_id krait_l2_match_table[] = {
> +	{ .compatible = "qcom,krait-l2-cache" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, krait_l2_match_table);
> +
> +static struct platform_driver krait_l2_driver = {
> +	.probe = krait_l2_probe,
> +	.remove = krait_l2_remove,
> +	.driver = {
> +		.name = "qcom-krait-l2",
> +		.of_match_table = krait_l2_match_table,
> +		.sync_state = icc_sync_state,
> +	},
> +};

As I mentioned in the other thread, cache devices already have a struct 
device. Specifically, they have a struct device (no subclass) on the 
cpu_subsys bus type. So there should be no need for a platform device 
and second struct device.

See drivers/acpi/processor_driver.c for an example. Or grep any use of 
"cpu_subsys".

Rob
