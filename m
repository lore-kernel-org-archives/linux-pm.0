Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C19FCE7B1F
	for <linux-pm@archiver.kernel.org>; Fri, 29 Sep 2023 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjI2KEI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 29 Sep 2023 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjI2KEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 06:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0451B6;
        Fri, 29 Sep 2023 03:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A36EC433C9;
        Fri, 29 Sep 2023 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695981845;
        bh=sRv8buPbIEC/2+2Qdm20Skddoq4EaMiObQKSQ48/r9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjnWjqXhitCgqauUtxVj0MRGszBzWeMGoRidOq0bsgV3dNX/HiVc6+rbeqO9HzLQb
         S/9L3+gB4Qt3167BA86TSW5wPYTwd7k6gOAdX/uOMTkSJVwbdJlKzq8HpAh0CuMCT2
         OtPJfa7AvnvW8Yl7RbEyt/1ezfarQF1iUkJTOF9ld3+uRHNnUJFJOJuJ6VylNKLehv
         XlSLCNnwPgudXR/kHZVBiQL3tjbYA/PfZ4I2MtCQBd0LmxjijFtfWLU0eREm8kNPJ3
         F2Yko22Wx9TL9TgaFLm+KiQCxRzL5dctNpsh3f1ZyhwruXzW7uxKHwqpbJKKYCb08B
         8MxeyotwgfsHw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qmALr-0003rX-30;
        Fri, 29 Sep 2023 12:04:03 +0200
Date:   Fri, 29 Sep 2023 12:04:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix battery_id type
Message-ID: <ZRahE9StzjDMzaCy@hovoldconsulting.com>
References: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 19, 2023 at 02:42:22PM +0200, Sebastian Reichel wrote:
> qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
> and should be of type __le32, just like all other 32bit integer requests
> for qcom_battmgr.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@intel.com/
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index de77df97b3a4..a05fd00711f6 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -105,7 +105,7 @@ struct qcom_battmgr_property_request {
>  
>  struct qcom_battmgr_update_request {
>  	struct pmic_glink_hdr hdr;
> -	u32 battery_id;
> +	__le32 battery_id;
>  };
>  
>  struct qcom_battmgr_charge_time_request {

I can confirm that this addresses the corresponding sparse warnings:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

I'll send a fix for the remaining warnings...

Johan
