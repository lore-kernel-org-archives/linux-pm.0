Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E303E7E657
	for <linux-pm@archiver.kernel.org>; Tue, 26 Sep 2023 18:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjIZSqb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZSqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 14:46:30 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A310A;
        Tue, 26 Sep 2023 11:46:24 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1d542f05b9aso1069309fac.1;
        Tue, 26 Sep 2023 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753983; x=1696358783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp43ADpVQE/LHvggziq02GgXbHTDklTFZf89WGvKd1k=;
        b=bCOs1/sIo/Q0pe5QRR0bTpCOOA382vxHk31uXS9HhLdLUotdo3xyJKMb79AkDLsUj7
         13ITC6sN+LHyPcGVpuG9844XIUUwhEOJ4e5LFrXefgpoTN6YNvxKshtYbMbH5c6tCc4c
         UKDQQT1OQy9ZNaZJu4Fws1LG6sQDvs052Y2VeDS+UzlE2GNE92qtu58mo9Ca+izbomif
         2yWZ/GRD4qvBltmRy/ZmTBpOMCJzuXEvTBakNnY9bONZvH/an0NHZrMcQAot+n/uD8bN
         XzqlOtlTwNJB836akBrYsuo7VYKBXBNBuVxLXW/YPCPyT4ZbH86r1sAJqmHq6M9lnTCU
         jdEQ==
X-Gm-Message-State: AOJu0YxV0y7CkjnS3JqfKHHyIZKRorE/AXbN8yRxqEOWq7EvaYuN8PY9
        uhqRT1MQETgY0qy1tSkXX3d7URueVmc0YlNGQ1M=
X-Google-Smtp-Source: AGHT+IHTCrpSskZBVytBdk0DLAs/ttbDQ/J8rqpWobugNM5fgmA8SasfgeckdUu0F678986uoq9EYChClGgmEJhxpfE=
X-Received: by 2002:a05:6870:3515:b0:1dc:6f5b:c0a0 with SMTP id
 k21-20020a056870351500b001dc6f5bc0a0mr9817179oah.4.1695753983646; Tue, 26 Sep
 2023 11:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-7-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-7-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:46:11 +0200
Message-ID: <CAJZ5v0g9hX6S1jnSD3=uatnPmF3vDPEF3ARru5ORst-CNc=5dQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/18] PM: EM: Check if the get_cost() callback is
 present in em_compute_costs()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The em_compute_cost() is going to be re-used in runtime modified EM
> code path. Thus, make sure that this common code is safe and won't
> try to use the NULL pointer. The former em_compute_cost() didn't have to
> care about runtime modification code path. The upcoming changes introduce
> such option, but with different callback. Those two paths which use
> get_cost() (during first EM registration) or update_power() (during
> runtime modification) need to be safely handled in em_compute_costs().

I would just say something like this:

"Subsequent changes will introduce a case in which cb->get_cost may
not be set in em_compute_costs(), so add a check to ensure that it is
not NULL before attempting to dereference it."

The rest of the changelog is just redundant IMO.

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 7ea882401833..35e07933b34a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -116,7 +116,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>         for (i = nr_states - 1; i >= 0; i--) {
>                 unsigned long power_res, cost;
>
> -               if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +               if (flags & EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost) {
>                         ret = cb->get_cost(dev, table[i].frequency, &cost);
>                         if (ret || !cost || cost > EM_MAX_POWER) {
>                                 dev_err(dev, "EM: invalid cost %lu %d\n",
> --
> 2.25.1
>
