Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4558CC433B4
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C71A613ED
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 20:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhDVUEO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbhDVUEN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 16:04:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C8C06174A
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 13:03:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 20so20140029pll.7
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfL45R5dBs0MS9kZn3ph77DF/daCg5TSX71XRehgnxk=;
        b=UjUpfOM/+EU+ODcUcs8lF11e3se8Yw8Lky6BSnX4yXUh+tH0bpE0cSc4yyI3n5B7pk
         pv8ltbRteNvl2R3roc9z2gnsO8vWps8U6LQsGpj3qY+cNNdAKS4TAI5H102o/aDYkmit
         DSgHAkITih3THSRWqGyqGn3H5/wg4Zzxk0AD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfL45R5dBs0MS9kZn3ph77DF/daCg5TSX71XRehgnxk=;
        b=TjWE/cOKmPC+R++hIhvgHbjcG5zJUvq7lJzQw9Lgq1JUGlbMIDXc6hRtoApqwoMwsw
         G/k+H+1RgNb5eajWkYXoByUnsaJoDCuli7L/uD40xOsSHcmxU4YWKrj484hhlwP9GFMg
         kRUJ7pmUI8keBaX/453NaCCi2NASIMSjKyg2pLE09B2jx0Qu5SrKNydonCXwdeemHTMf
         JmVdXDXTR+ETWXGd7SPsncqZ6mnqB3dvwezr+iqvkjennDG26bvToNNcBLf2VKmbI9jj
         VgRkylCeO4E2fZLH52VQ4Zc+nrF7Ra9H/qj/0Bkj0oPXJ4C7r8Mi0wV8IsSgz7lrEftD
         8Yew==
X-Gm-Message-State: AOAM533SX0ClUyYaTrAV8aZMg80c1gULHk1ETHo0icP6zV5fa+0VAblr
        57gYPR0gU74u+YzwBYG9Lm7LOw==
X-Google-Smtp-Source: ABdhPJza8gCfdaIX2zwXwIfrBz18VOBT1lbCrdWZuk0N4EoKlrwKK9Gt24lkIqjFphGcuVLpxWADDA==
X-Received: by 2002:a17:90a:d18a:: with SMTP id fu10mr444528pjb.233.1619121817858;
        Thu, 22 Apr 2021 13:03:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:acff:4f9f:d039:23ff])
        by smtp.gmail.com with UTF8SMTPSA id y13sm3044062pgs.93.2021.04.22.13.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:03:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:03:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: bcm-voter: add a missing
 of_node_put()
Message-ID: <YIHWmJPcoh4bFKNi@google.com>
References: <1619116570-13308-1-git-send-email-subbaram@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619116570-13308-1-git-send-email-subbaram@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 22, 2021 at 11:36:10AM -0700, Subbaraman Narayanamurthy wrote:
> Add a missing of_node_put() in of_bcm_voter_get() to avoid the
> reference leak.
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Cc: stable@vger.kernel.org

nit: I think you would typically put tags like 'Cc' or 'Fixed' before
the 'Signed-off-by' tag.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
