Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3727C4320A
	for <linux-pm@archiver.kernel.org>; Mon, 26 Jul 2021 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFB260F91
	for <linux-pm@archiver.kernel.org>; Mon, 26 Jul 2021 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhGZWVj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWVj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 18:21:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0CC061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 16:02:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so6916592ota.11
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YQOUs6IHKvgmEEaJoamgZLDtUOOWcnZjqqyzNqPHtgA=;
        b=X7ukQguYL+MKBPkBFhO7H5nfKnc70OCDuiDFR7YSf6QZLoLc4ReLFF6oY/7WEAPpeS
         PFJCBGADy/cvzKcTOc1MuVUHe+mO9raKPlB3JjjxQuitmjuPBprCfWobERLCeG8YR46C
         HBZgujM21DWWX2fFg3Zb81ftslEqmBez79Y5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YQOUs6IHKvgmEEaJoamgZLDtUOOWcnZjqqyzNqPHtgA=;
        b=JAobOZ3tocttSvOqnMFn97/UGDKxoTQK8NziCHuOhdB+y1iMrJBhQkdRC0a15BKf9x
         ouiXm+8skDQWef5GuYL99jBQ80TegWs1ZvOXLsIE0ZqREfG8K47AunkISMvkaMKTzDFV
         X5bjFD8gRWI0oinaR+8WhGA+FyT824CsQWf1VelzFFFDTB+R+wTNX8CPRsYNpUQHHnW+
         y2zIOvbgWXS2g7OtC2r9w3CX8Ql2LYB1ztnzrw8WR9sHB0DtUATRJW6I/pW0e8bAuOPl
         H30X/UY7XVoSB4fvGH2XcUOqzflZf9kpDDgX7mb1qE6v5oa5jiehcPiK5kSJQV6wDc6z
         YpJw==
X-Gm-Message-State: AOAM533cPnQoqUxbZE2OY5T/UOP27bcW03GodO+8MwrpCmBC94FLHZ+u
        EpUovg1ko/p7jehtumjwc1zmQWJn3viBmlB+Xr+JdxZTjp4=
X-Google-Smtp-Source: ABdhPJz5jt91J7s64KRcgC3G/srUYZuXPZrU0BBg8ga7AFXoIHLQ4iQUzviPocNr4D2zmNt8R5pRz0hfblCs9cIwm10=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr13153554otl.34.1627340525819;
 Mon, 26 Jul 2021 16:02:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 19:02:05 -0400
MIME-Version: 1.0
In-Reply-To: <20210725031414.3961227-1-bjorn.andersson@linaro.org>
References: <20210725031414.3961227-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 19:02:05 -0400
Message-ID: <CAE-0n51vBEUY4A0ed+sBDd1tWX2oBqW9PeeAttLordaBw174rg@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: osm-l3: Use driver-specific naming
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Bjorn Andersson (2021-07-24 20:14:14)
> In situations were the developer screws up by e.g. not giving the OSM
> nodes unique identifiers the interconnect framework might mix up nodes
> between the OSM L3 provider and e.g. the RPMh provider.
>
> The resulting callstack containts "qcom_icc_set", which is not unique to
> the OSM L3 provider driver. Once the faulting qcom_icc_set() is
> identified it's further confusing that "qcom_icc_node" is different
> between the different drivers.
>
> To avoid this confusion, rename the node struct and the setter in the
> OSM L3 driver to include "osm_l3" in their names.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
