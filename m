Return-Path: <SRS0=6fVe=56=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83ADC2BB1D
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811162074D
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586899124;
	bh=QTc0Uwc1T257Q+FefIhjMUIgBRsqhODz6ilOwxjjh5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=euQrXX8JVN4OXMdh1UCZOrwKiPkcy2HKjJ3poHe/cerDom++uo0/vREvHpLLF31xI
	 iBdM6goaV9c2I8Cel96AibhWZ2GdpjfDYoKklH/xVmw3+hAHnaNcLSC45S/WCQNfa3
	 RimKllpNrW8ieNC9PCTScpzHrvU+Crc5llOnQjb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633753AbgDNVSn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:18:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37876 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633733AbgDNVSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 17:18:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id r25so1885343oij.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b78y/qprVyrWWHqOCyz9Uq8uGo8VRikgf5v37xoaSbc=;
        b=kIDWf4QwaaMLvTNH+1lZrq63DJNNxlf9Ui6JTEJHckxRPFry7uSN2C2tNb/GJC0zgB
         clnVPwEFMbLLleMFhObRUe2Qj5nDpn3DFuwC8Pm+xTD9rLUL5XMSk63gMWBJNCUbiyaX
         0pKq9oSUy7jpVmk2KKJYgfzyp4BU1sK121uo0IfnXYWzBmjy1fxFvEJmwy1qi5vBUlEo
         twGO00t6SLYASrGiDFD5lZqWvHkfgIAShqYZMLsGoItaxO4MWhnQgz5bsyzFFkn3mOdF
         fypIg5guYnpDOE9zQ9uPnP23lkdrG7yQx/UqFNTJbhxRKRcVZy5+CySpH6QOl1Hxw8K4
         L/gw==
X-Gm-Message-State: AGi0PuYXMGdV5VkW5x70UYjpCj8F5CA5D9CJVeVO3j7o/I+a92DJ3e/j
        T3OAt6s5P90ZO2LjbHuruLvJY+EoLQyi+GTPjykTUQ==
X-Google-Smtp-Source: APiQypKOmK/m0kC0ENUqWIhzl6nuHqk9GeNL38KesK7vjC209H1SaLERi0gda9kUXLRJNlj6wX5vkUxQFlhtEINk/Ok=
X-Received: by 2002:aca:2209:: with SMTP id b9mr17467492oic.103.1586899121837;
 Tue, 14 Apr 2020 14:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414060737.ckxaa7bff6l24pym@vireshk-i7>
In-Reply-To: <20200414060737.ckxaa7bff6l24pym@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Apr 2020 23:18:30 +0200
Message-ID: <CAJZ5v0jjG+QD67pk0tz18ScJsP9mDa6E7y4eqn+2SEGY5yOosg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.7-rc2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 14, 2020 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patch that lets the OPP core to be
> used by several IO drivers without making a lot of changes in them for
> the case where the same driver may be used by a platform with an OPP
> table or a clock node on another one. I am looking to get this into
> 5.7 release itself, which will enable other users (in multiple
> frameworks) to get merged without waiting for the dependency to get
> resolved.
>
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
>
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to aca48b61f963869ccbb5cf84805a7ad68bf812cd:
>
>   opp: Manage empty OPP tables with clk handle (2020-04-13 16:14:55 +0530)

Pulled, thanks!
