Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39BC10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 03:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C5D217D6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 03:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulCKW46I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDJDyE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:54:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33199 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDJDyE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2019 23:54:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so589021pfo.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+p6WtM7TMz0AFrDPtlDt/keNDoiZYMcADTq7mOxaojY=;
        b=ulCKW46IiZ0zdLV59onv+1VMMBMcPPo5eYsplQtnqti7gUPo9tdzr76pckGBxdhTPg
         E7t4T7u7HczlIRB//Y5izsEnD9d6osadENsNNNHjRhBkAAG72GNA6z1NKuuhKzkVxwwt
         AQuIstltcKV9fMs9VDxawIQb4r2FkmeWFUhTbjxo46mX5sJlV5MoMtIanNK6ILdutdWY
         2v4Ze0lxrDE1B2M7Un3p7NiiUUsyQJHO92xE9UsplBS5SEJtaoFRvUaywlTXn/tb56uq
         u1oViTBLN9trPjk31b7naB1H4QZl+O0TaJKWVOlnuyB6qAGewctmGcoxl2BIJiMehQZK
         63aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+p6WtM7TMz0AFrDPtlDt/keNDoiZYMcADTq7mOxaojY=;
        b=GAHsvc4Yl7fALPBA/p0TbDw0PcmK5cG9L8H5QxopVXgjG8ftJolxGHej7rAzXW/Z/f
         jz8U0HzjqLcnhStEBilUv+MnGTuwORo3O5UZlec9TpeDcfQXik3SxhjUf7dz1NAX2Ppg
         CG4YbdaUIDJRPfQtIAf+f/EsYNVInY5RscqpMrkdPLlRqXruOGRXjO7Z+1KFoe9rYL3s
         K3DpdAAT9wXrINP1HGDIYlf9GA3d39FPZWDmmHrl6lPzQX8Cg9WMiNSYDv6DW944CCwV
         YwnYsl1IGC1mkRGtrTwW+6VMg60Fdv/MCanjO5EY3CwHfggCHqa8xxIWkYcnkKY+aEF4
         IiCA==
X-Gm-Message-State: APjAAAWj/oAeo637F97CBQHv81/LyWEucp10c78yTikgVXBmBAVrXir+
        I52WyKGM7vyk27sFFJM60iXhkw==
X-Google-Smtp-Source: APXvYqw3u+QvQDAvaO3qKUR3SW1KeQRVZaWxKyNrlSIb899fdG73Wz8WtydFOJaKH3BpbG1vN8oyIw==
X-Received: by 2002:a62:e10e:: with SMTP id q14mr40110907pfh.161.1554868443751;
        Tue, 09 Apr 2019 20:54:03 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id k6sm35702599pfj.173.2019.04.09.20.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:53:58 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:23:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the interconnect
 bandwidth
Message-ID: <20190410035356.up3qxkc6az5lpjyt@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-3-georgi.djakov@linaro.org>
 <20190314063047.urmzez52bdyrkdsu@vireshk-i7>
 <0cb2d777-4d05-2b06-e458-755d171b3436@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <0cb2d777-4d05-2b06-e458-755d171b3436@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190410035356.1TgaupyMYKSo7bslJAHvOy3UKopSdMAfC7_ztYDsYeQ@z>

On 09-04-19, 17:37, Georgi Djakov wrote:
> Hi Viresh,
> 
> On 3/14/19 08:30, Viresh Kumar wrote:
> > On 13-03-19, 11:00, Georgi Djakov wrote:
> >> The OPP bindings now support bandwidth values, so add support to parse it
> >> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> >> is part of the dev_pm_opp.
> >>
> >> Also add and export the dev_pm_opp_set_path() and dev_pm_opp_put_path()
> >> helpers, to set (and release) an interconnect path to a device. The
> >> bandwidth of this path will be updated when the OPPs are switched.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  drivers/opp/core.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/opp/of.c       | 44 +++++++++++++++++++++++++++
> >>  drivers/opp/opp.h      |  6 ++++
> >>  include/linux/pm_opp.h | 14 +++++++++
> >>  4 files changed, 131 insertions(+)
> >>
> >> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> >> index e06a0ab05ad6..4b019cecaa07 100644
> >> --- a/drivers/opp/core.c
> >> +++ b/drivers/opp/core.c
> >> @@ -19,6 +19,7 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/device.h>
> >>  #include <linux/export.h>
> >> +#include <linux/interconnect.h>
> >>  #include <linux/pm_domain.h>
> >>  #include <linux/regulator/consumer.h>
> >>  
> >> @@ -1645,6 +1646,72 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
> >>  
> >> +/**
> >> + * dev_pm_opp_set_path() - Set interconnect path for a device
> >> + * @dev: Device for which interconnect path is being set.
> >> + * @name: Interconnect path name or NULL.
> >> + *
> >> + * This must be called before any OPPs are initialized for the device.
> >> + */
> >> +struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name)
> > 
> > Maybe the OPP core can do it itself in a similar way to how we do
> > clk_get() today ?

It took me a decade to understand my own comment ;)

> Do you mean to directly call of_icc_get() in _allocate_opp_table()?

I believe I wanted to say s/clk_get()/clk_set_rate()/ . i.e. if someone calls
set-opp-rate, then the path should get set as well accordingly automagically.

-- 
viresh
