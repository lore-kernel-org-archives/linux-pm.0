Return-Path: <SRS0=8pdy=3R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40167C2D0DB
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B89A21739
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNCVgdtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1Uo0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:44:26 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51437 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1Uo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 15:44:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so1586854pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbJeh8/LI2mlLTbZ1tH2VO6yi1sNDNk35sjg9NyyWm8=;
        b=FNCVgdtuEjKA0XO9LyT7fFDkTLztdtZBXLK+Wji/XBIULcUc0VHBKSq9rnp57o4/uv
         Wrvz6O3JeBx7ohJxH5vzXQHWvMR/zOkDj31S7lKg05DguscHm3hzpUBEspKsfME/HFvJ
         hbOhPs4Mz+OsShEmI3DgPvYZwga6/tAccTuq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbJeh8/LI2mlLTbZ1tH2VO6yi1sNDNk35sjg9NyyWm8=;
        b=Kdkh+7cGfqZZp6sexV+M+aR53rw3GZNJJ2YW4uJXGXIM1nNUloG0oL8+aZ0eQTWKRx
         EVYpfYtnoUISS/Jo0w7Qm/F/g3z+Yq0jbjw8mcFlYZF2Jjp5/8FHR2HKA8x/V9/XKqSx
         koVy4J9ZF+0SPbhext6NQg8fCL0lHTZUSQFfiInwFop/YB7JF87GanT7jqFl+bJHgJub
         umwTpv5CQ4ntVuO0CyyiEJNEM7F5U1JdTFagpwcaK3xUlXVXI4rbmRcRYuHdTfQOrZ5p
         pf9NbZkYYdJZEbaXBu9YtWkMfYHqH7igN1xSD0svN7ZWTQz+aMieGEWsiptf3yoATjPt
         /OnA==
X-Gm-Message-State: APjAAAXi9UtDTiTVLuiJuqDCDzdxIAAnVZa80RK4KGrMDzgj7Y2PReob
        cwzP8H0KWUD56Zk+DYM8B2vQHg==
X-Google-Smtp-Source: APXvYqxRJmQfwf2gXkhjLY8zub6q2yqFGirhOsUJnZOp1NUzUg5k4YhfFHNWtUB/gZ/+9rYRTomoww==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr6823668pjr.129.1580244265708;
        Tue, 28 Jan 2020 12:44:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c14sm20864917pfn.8.2020.01.28.12.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:44:25 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:44:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
Message-ID: <20200128204423.GF46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 28, 2020 at 01:33:42AM +0530, Sibi Sankar wrote:
> Add SDM845 to cpufreq-dt-platdev blacklist.

nit: you could mention that cpufreq is handled by the
'qcom-cpufreq-hw' driver.

> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f2ae9cd455c17..5492cf3c9dc18 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -130,6 +130,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,sdm845", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
