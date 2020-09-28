Return-Path: <SRS0=bGsN=DF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D88C4741F
	for <linux-pm@archiver.kernel.org>; Mon, 28 Sep 2020 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0002080C
	for <linux-pm@archiver.kernel.org>; Mon, 28 Sep 2020 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601292768;
	bh=xZudESZoNWrMKl+EPdcNAvEcHmI/YsJEVNHFPvHdvRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dc+FXr7EY8AjH2W0MzfVOY+5OiS+0V3C3R81mAWILY8lAyN1YKvQ6doMoEdZPenuZ
	 GT6kYWe7QVJbo+8VpVMD5/8Wroj9VUfIaD6uT6sg9iLgY7BNJFNdMjBxXYVW4OcHuz
	 NwdLzySxnwhSEQO4H3g+jwdyR0a0UPVxYUBVUf8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1Lcq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgI1Lcq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Sep 2020 07:32:46 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5557122204
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601292765;
        bh=xZudESZoNWrMKl+EPdcNAvEcHmI/YsJEVNHFPvHdvRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fV426os9TKYhIvZkBaY+TYvgHU6OJYQsGQk4Tpul2CZ51ZaWRTiWuf9w364bwBhsR
         IRlU4mW7otJHIm8U5T4YViul/+q9/OqJW6QFuB+dSbHTpNwoe3p4S/mFEmGPbVYlX+
         2UjkzTjLMvUPEj1WO6INrt3u6khip8A+xsxfpGpE=
Received: by mail-ua1-f46.google.com with SMTP id z46so2049018uac.13
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 04:32:45 -0700 (PDT)
X-Gm-Message-State: AOAM532DgV+t/0NcQGQ9Zp911+yBWA+OA8BSJ5MUiDCLsaSN7kgGrmSM
        oDvHNjB2K5+FTCX1XZcmWi3yzUsa0ucNCGkM6UjlMA==
X-Google-Smtp-Source: ABdhPJwi7Kf1/TO4y4q7aWBNfNZi/GSTHY4iSAWGo4xUBrHZWc5IjjiWge++TaqlAxtqOzKiEm24pDFMZvhTRGzNq1g=
X-Received: by 2002:ab0:35e9:: with SMTP id w9mr303137uau.48.1601292764466;
 Mon, 28 Sep 2020 04:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Mon, 28 Sep 2020 17:02:33 +0530
X-Gmail-Original-Message-ID: <CAHLCerM666W9ijLu529NNPNz_NuyO0QPKws8spWrR4bWNo0A-A@mail.gmail.com>
Message-ID: <CAHLCerM666W9ijLu529NNPNz_NuyO0QPKws8spWrR4bWNo0A-A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/8] Add support for ipq8064 tsens
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ansuel,

Just a quick note to say that I'm not ignoring this, just on
vacations. I'll be back to review this in a few days.

Regards,
Amit

On Fri, Aug 14, 2020 at 7:12 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> This patchset convert msm8960 to reg_filed, use int_common instead
> of a custom function and fix wrong tsens get_temp function for msm8960.
> Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
> to be registered as a gcc child as the tsens regs on this platform are
> shared with the controller.
> This is based on work and code here
> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage
>
> v6:
> * Fix spelling error (can't find the problem with variable misallignment)
> * Rework big if-else
> * Remove extra comments
> * Add description about different interrupts
> v5:
> * Conver driver to use reg_fiedl
> * Use init_common
> * Drop custom set_trip and set_interrupt
> * Use common set_trip and set_interrupt
> * Fix bad get_temp function
> * Add missing hardcoded slope
> v4:
> * Fix compilation error and warning reported by the bot
> v3:
> * Change driver to register as child instead of use phandle
> v2:
> * Fix dt-bindings problems
>
> Ansuel Smith (8):
>   drivers: thermal: tsens: use get_temp for tsens_valid
>   drivers: thermal: tsens: Add VER_0 tsens version
>   drivers: thermal: tsens: Convert msm8960 to reg_field
>   drivers: thermal: tsens: Use init_common for msm8960
>   drivers: thermal: tsens: Fix wrong get_temp for msm8960
>   drivers: thermal: tsens: Change calib_backup name for msm8960
>   drivers: thermal: tsens: Add support for ipq8064-tsens
>   dt-bindings: thermal: tsens: Document ipq8064 bindings
>
>  .../bindings/thermal/qcom-tsens.yaml          |  50 ++++-
>  drivers/thermal/qcom/tsens-8960.c             | 172 +++++++++++-------
>  drivers/thermal/qcom/tsens.c                  | 130 +++++++++++--
>  drivers/thermal/qcom/tsens.h                  |   7 +-
>  4 files changed, 270 insertions(+), 89 deletions(-)
>
> --
> 2.27.0
>
