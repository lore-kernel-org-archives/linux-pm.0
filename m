Return-Path: <SRS0=yg//=VG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDCC606D7
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D98B216C4
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apgBZ4X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfGIH0T (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:26:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfGIH0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 03:26:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so8976280pgb.9
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VU++xFR4UeS5wi0kjYAOOzJHg9p99MkOSC469PWKtiE=;
        b=apgBZ4X6rGUau8HDn6zxvjaAbzKsFih4+juV1oPlI/6mu5bLVrqKrL1DcuiEVk6qym
         NBwY8pHMoa4Fr6d4fLhivIAJbt4/tpElXsML8xmXZBJvB924rYqGC9jEwi8JP2ywcFWI
         GXu9KqIs5AcfK15LuIU6FDabc2YEaDAgooke+emPmxg5fO5p4j+/FJIZ4WnAXgXEHRob
         zTH/fDXaeMq2qFXxtWO9oIn6v23ByzeTHqx7E+qh7isXghw3Y5GNvVWmNytfboHsKFcZ
         Z57F4nuzERn5O+E3oSH6FDR9pFBWdO1mTbNsKwdbx6+z0ayFPu3Y0E67R0s6ALtz7VrX
         7fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VU++xFR4UeS5wi0kjYAOOzJHg9p99MkOSC469PWKtiE=;
        b=j5WSnvvmEdzn9lM3fdmEqk7amvXjHC0TcTiLLIyQskitj919msi9CXtQD02HS9TTLI
         /9w2CJwMxrCxVEcgUAzJpR008bNOvnUg7ovNh0eAe15Bk87wD6/WMy77Aj72BrP/zTCe
         ldDLQR3SXXcFROl4BV09EsAjnoxuasu6z4K0B5nh3b5U7fRkpjUbPy7xvad6RzXiZevV
         LbSSV2wmbCcozaogqcYyVTPhHYKMtegWvtDK9md5vrMP/nEWqPZS0r+U0nDSSH1j7wmB
         C7iElpBVBy5o8CkILuJUtQUb8sTKiIXYv7WGnHq4k45O4o/iK1iZ8AOwSSS2r9VAi5t/
         EVTA==
X-Gm-Message-State: APjAAAVXP1/k9Upmjdmjek1jOpp0eF/fM/AKT1/MpH3COYto/x0oyFIW
        O2YAJnNsJ/AHg85E5Aq07MfWqg==
X-Google-Smtp-Source: APXvYqxrf8g/VrlI7miB6XEk8mRZC3zQZQMxO667s/7gnRYvdWVTPaqo0bYulUdlitI+2Q83bRT8cg==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr30906790pjq.102.1562657178825;
        Tue, 09 Jul 2019 00:26:18 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id j20sm7155992pfr.113.2019.07.09.00.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 00:26:18 -0700 (PDT)
Date:   Tue, 9 Jul 2019 12:56:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
Message-ID: <20190709072616.bt2754numhdnjb3t@vireshk-i7>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd>
 <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
 <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com>
 <20190708092840.ynibtrntval6krc4@vireshk-i7>
 <20190708141302.GA7436@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708141302.GA7436@amd>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 16:13, Pavel Machek wrote:
> On Mon 2019-07-08 14:58:40, Viresh Kumar wrote:
> > Though it makes me wonder why I didn't hit this thing. I was using the
> > cpu_cooling device the other day, which calls cpufreq_update_policy()
> > very frequently on heat-up. And I had a hair dryer blowing over my
> > board to heat it up. Lemme check that again :)
>
> Can you test on some x86 ACPI? No dryers needed :-).
> 

Found out why I didn't hit it then. I tested it after converting
cpu_cooling driver to use QoS APIs and there is no double locking with
that.

-- 
viresh
