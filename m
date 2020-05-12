Return-Path: <SRS0=zDym=62=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C2C54E4A
	for <linux-pm@archiver.kernel.org>; Tue, 12 May 2020 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F1720673
	for <linux-pm@archiver.kernel.org>; Tue, 12 May 2020 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589293578;
	bh=gebEDLKrxJUMN6S+qQygxff5Q531HiyO3JNQOScZzH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1m5/QGBzgf9ClL39e/rv72llD3ztpykegUr6dlTKyBEvfYuRiKAs/a+lrcE4yPUvW
	 GtvTk9OBGFLLjEXSMWxaUVLjLv8a9gwWI29n1rFkfyX+RgpkyMOuMxQliKZPnYHSs0
	 uJ5YhjSEGtUrZcKHeJWJ0SdcRWdo6JkC7UAHf7OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgELO0R (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 12 May 2020 10:26:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41578 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgELO0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 10:26:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id 63so3239731oto.8
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45HMBvU5mnuD/YPEsMrs7gjEaaIwWfQc1uLgD2S+xK8=;
        b=Hv/xpyuMkKvHERtSSNBFToNGBlxPsMjzZoRlibydYjqjAN+AxD8ZK7TyzGNXrychBW
         Zw00sdk7rgMqzA0zmMVLkRkxSw8qvhg5zCgy+rMgez/gUJR75aUE9eq2s1LvxcbivVUv
         aguYk9DJDe4r0lAfddzsUUXQNYza7XYIu3HnMiwrDNSgvZ7Q8qzL/4Nuzy1xZiD0KUQL
         cjxCmbBzV1hk+FFsXlWH6vbZ7IucmlI1fPGpDSt6aQ8bSx2m5dlVeWiF/OSD8MYSwZTw
         WenmzfuYZuLCbwCmPzgWeoZrcdzeliQVaKmSQ0gI2Qo3Y/ogOxkstI5jAgTEBM8fIV4P
         b/sw==
X-Gm-Message-State: AGi0PuYZwJbINGsQU6U/r6WJ0rA7xn2TH9u3tW64u+RqMziDlAnTZUxQ
        RGaUVO95Dm1NkwG70mRfF5UGJvUohU1nXdpevx0=
X-Google-Smtp-Source: APiQypLFBS1fss/n0yDRVADd9XBXnB6e00jilNH6eEybyXcTe39CzTGqVXuzWnl5uK/ZtUE1TAgUYJ5mssUtbiL7t9Y=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr17033842otq.262.1589293576759;
 Tue, 12 May 2020 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200512060814.jkbbxxsxw45mcmg7@vireshk-i7>
In-Reply-To: <20200512060814.jkbbxxsxw45mcmg7@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 May 2020 16:26:05 +0200
Message-ID: <CAJZ5v0gwu6d4MNP0q_h4bQKiZ9HGav+dxTdCixSXEX+7Jt4Pvg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.8
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 8:08 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Build OMAP cpufreq driver by default for ARCH_OMAP2PLUS platform
>   (Anders Roxell).
>
> - Fix compatible bindings for qcom cpufreq driver (Ansuel Smith).
>
> - Update qoriq cpufreq driver to automatically loaded when built as
>   module and related changes (Mian Yousaf Kaukab and Geert
>   Uytterhoeven).
>
> - Add support for r8a7742 to cpufreq-dt platform driver (Lad
>   Prabhakar).
>
> - Add support for i.MX7ULP to imx cpufreq driver (Peng Fan).
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
>
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

Pulled, thanks!
