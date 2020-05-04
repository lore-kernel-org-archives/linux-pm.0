Return-Path: <SRS0=wqoS=6S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FEC47247
	for <linux-pm@archiver.kernel.org>; Mon,  4 May 2020 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B8420746
	for <linux-pm@archiver.kernel.org>; Mon,  4 May 2020 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awQyZcp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgEDWEE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 May 2020 18:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDWEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 18:04:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D8C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 15:04:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so158097oij.4
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG81CHNe0QI0NTrcW8A+JoCmXNVDbes2uRrDzLgGKZ0=;
        b=awQyZcp56CR+knPRnNk21A1iejTvhrYFLChzm3D8lOIkwo5L29DDqfYpOQLytNd4Wl
         PZ0pw0oGfkICw4vK77z9xVA/P+4bMM/pOOWq1BfkSLu+gukAONxmc7l9395y0J94jMvb
         SEljtLDp8Rd+20G3yKC4Msa9QXUUPbIL3knX4W4l9rYfWcq4mwSz728aHXV8rT09nh1c
         u8+IB2oBb0mo0VcASnfmLUxm6hfZCTP6qL2c5S1/n8o7LSMhCNiQeCXOXjkhI7eaV0R/
         HoJQIi2Tw4NDoVlonxzmj/pbTjhdvw7jZhGkNMRNpDiaoSDvux9z59kPjqqzBXYxli6i
         9WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG81CHNe0QI0NTrcW8A+JoCmXNVDbes2uRrDzLgGKZ0=;
        b=oiKZqKlEl5V7wFSWIAzaDxwdMBO7YpqR2uwOW90MH/f0q75oBUiw7OysNdBmhk3bmd
         qulcqn4sV7NLaerzUKPjruxiboYgJISIXbkxrw+Mzda4QGi/CbtnG8k7Lrwg4665G0dA
         0NBdHR8jxiGyeNbnK61QiiadXIwacTNnOZG2mYFKySEwmL2mIf56TNUfoujUI2IOY9Tj
         X+jHtQbHN7NLUtfqxoy/gOix4Pka7PlJY81IP5EXXKy8VsqhKgYAo4BYG+cBoquPvmh/
         8uQO/miI1ux/y+CySfC7zic8fbSvAxu9yKYTnuHOCbuwK/9X8TlKSq4m7Ltc6GqFM/+w
         30LA==
X-Gm-Message-State: AGi0PuYPc4lXrWTA0TksHcGeD4b1T5hc1YzHgvt1lMxDhJvdKCoXzj6p
        hrHpDCggUMXIXogcL1zstr9yGkgqgZIritCcxjmcGA==
X-Google-Smtp-Source: APiQypKDHasungWQjMayXhFnYsz3plBUGmQGh5tJ355DQrIPVoVy/eOJEF75X4WbUqO6BDVWSC9QCDmuk+RxO75/Zhw=
X-Received: by 2002:a54:418f:: with SMTP id 15mr374635oiy.69.1588629843284;
 Mon, 04 May 2020 15:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org> <20200504202243.5476-8-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-8-sibis@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 May 2020 15:03:26 -0700
Message-ID: <CAGETcx9=kfuG9WtaSxsDe_SM1Gewbn889eQ--3ui3H_rzm3BRA@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] OPP: Add and export helper to get icc path count
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, lukasz.luba@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 4, 2020 at 1:24 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add and export 'dev_pm_opp_get_path_count' to get the icc path count
> associated with the device.

This is not related to OPP. You should add this helper function to ICC
framework?

-Saravana
