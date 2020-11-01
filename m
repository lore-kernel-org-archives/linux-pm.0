Return-Path: <SRS0=PI5C=EH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A53C56201
	for <linux-pm@archiver.kernel.org>; Sun,  1 Nov 2020 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF9D2225B
	for <linux-pm@archiver.kernel.org>; Sun,  1 Nov 2020 14:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNCbyfl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKAOpU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 1 Nov 2020 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOpT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 09:45:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A091FC0617A6;
        Sun,  1 Nov 2020 06:45:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 141so14049359lfn.5;
        Sun, 01 Nov 2020 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nfSTOQa1GHPu7yZflmElx1yrigDoZA+beTbfSTxADDQ=;
        b=LNCbyfl80w5m5vmdw3f6tkQFZPsqsLTQxD7B0YQ9lQsp91AmlP1vbAFBWNx1lZpLAd
         P38k7TmgrN7uaqeRam6cxqBfIwjYYLqYjvGGuwvZOqwRdmzY9yEqvtyWbHNwRtZNQ9vg
         MuVynxEAfEH9OIJ0IwgQTMEP9jtxTsxGwPF6tHrg4ERcckfqZGAgvFJ6TZP9o2+cIGDi
         fdUdmmpX5MwYo8Qy+YuyNywQgXTUSAFuARSWrtAYrm1zpbva063byVj2nxUXXovDzt8u
         xL7T3BWrj5oXGEBJdmPgkwsMNh1Zv8hRvSh9OdWVNAO9IELnHdrPWxk2Ax3Rl6A3VLf7
         JBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nfSTOQa1GHPu7yZflmElx1yrigDoZA+beTbfSTxADDQ=;
        b=BnbSw1mVjGf3BIlk09CaRF8NJkipOUjgGbvqONvkRpwJ5lXBMLrvSZ2COpFSx68hbV
         BaLAgRkA8x1bXiwv8ZxtK3ZCsk6ceanDB9yMEWmnQ8P8GH+kK3GOyUtgNsCDRjkPbVqh
         HzmTl8RBQ1TtOJjFm6tpEaJTGfmoFWsKnwVeY9ag/ciB6p3VxIQRt1VeLzk9Zvj1qooA
         QHJpLCOEFMlL5o3xfsk7j0W6NdwKS3xc9gJasYUpITRSkWoB0ecuUH/Kvy9Z32miWZH7
         vSVpyBH/geZ8sBLEOt+S1LArLmEcXSptkECh7SFNmD4z5edsumriYKwz2fhyDpZUb0no
         6Duw==
X-Gm-Message-State: AOAM532WE522ywBzDyRwcu0ExRq3235J7gWCaTYdcq7nHPRpCiPywDy8
        4GJ3Hb5uoZlHNWlWDesf2+8Y22khUF379oFIxXg=
X-Google-Smtp-Source: ABdhPJyBkgiSrqXhZk/gcQpWF+e/o3AVHRSwjg0BQJhL/gY5tJ65y2vrH74G0ZFq651tDjCK4YjMxaHGxd8OKMjGS5w=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr3971359lfe.571.1604241916924;
 Sun, 01 Nov 2020 06:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-52-digetx@gmail.com>
In-Reply-To: <20201025221735.3062-52-digetx@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 1 Nov 2020 23:44:40 +0900
Message-ID: <CAGTfZH2rBaWKox9nKM=_Wz8k65FLt1R7D8xSOUxe7xAJ1A00hA@mail.gmail.com>
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> This patch moves ACTMON driver away from generating OPP table by itself,
> transitioning it to use the table which comes from device-tree. This
> change breaks compatibility with older device-trees in order to bring
> support for the interconnect framework to the driver. This is a mandatory
> change which needs to be done in order to implement interconnect-based
> memory DVFS. Users of legacy device-trees will get a message telling that
> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 91 ++++++++++++++++---------------
>  1 file changed, 48 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 3f732ab53573..1b0b91a71886 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -19,6 +19,8 @@
>  #include <linux/reset.h>
>  #include <linux/workqueue.h>
>
> +#include <soc/tegra/fuse.h>
> +

This patch touches the OPP. Is it related to this change?

>  #include "governor.h"
>
>  #define ACTMON_GLB_STATUS                                      0x0
> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
>
>  struct tegra_devfreq {
>         struct devfreq          *devfreq;
> +       struct opp_table        *opp_table;
>
>         struct reset_control    *reset;
>         struct clk              *clock;
> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>                                 u32 flags)
>  {
> -       struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> -       struct devfreq *devfreq = tegra->devfreq;
>         struct dev_pm_opp *opp;
> -       unsigned long rate;
> -       int err;
> +       int ret;
>
>         opp = devfreq_recommended_opp(dev, freq, flags);
>         if (IS_ERR(opp)) {
> -               dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
> +               dev_err(dev, "failed to find opp for %lu Hz\n", *freq);

You used the 'Failed to' format in almost every error case.
Don't need to change it.
(snip)

Best Regards,
Chanwoo Choi
