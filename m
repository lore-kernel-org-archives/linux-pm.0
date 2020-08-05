Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE27C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2A922B42
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658194;
	bh=2jLFMm+CdiwmOZG/JOnONjoNi2LeTl32WhNCd1CZKsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EvKIlhj8era0fFOQlWTYeFrUV0oY8p23AdZ8jTIsKTQ/0QWGn/7E0GZbb9W+ySPs6
	 OYTw3wv0hXR/2Ri/ZxrZil2yB0ZU4ALkgrt+nkH0X2gL1bfg9JWMHgt8gdkFodBYAj
	 H5zT8RruEsmtUYLQ1HmLsos9hSrsCVZlI9AFul3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHEUJu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:09:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43608 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHEQ3G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:29:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so23270791ota.10;
        Wed, 05 Aug 2020 09:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2Pl0nxbT6UouzIoo2qIhPoj7Bo+fxndZdi1tAY/F2o=;
        b=evdsFFTQx9K0IFg7PgdGrbOMSQEld9thfsrPXZJwH03tBm4zYVMNRf8kfpDrR0SMOz
         Vp7hWNLLeib3bZ3y0RIn2y/6d3gwAOjLEDi5yFK8xPGIq2Y74SwikqT+fTf+opgWTsCZ
         STEYf16frTl1sHxqC4oKPcrVK0yriSLj1CxzH2cRi4CSnqqlzXvEdr1eoT9eXKmzRlC/
         fvd9DZRrUCg2lvR7E9dEijgr6nyAb5QyT/ZS1mi7cxWbDUL7KWI2Oz8+69YxKExWj9G1
         VZi8DrBhik2E6mgTA5KVttslVkNaA9KB2+LSBPEbnxQ38DYPidC4xTFH2yJj5GSCYOmC
         QMOA==
X-Gm-Message-State: AOAM530e/iFMFhMeEY/MoXMYd6YMmTv1k65lG9OCj4B14GpK3rtaydLz
        QWGHHOuOc/O/3RhDn3T6MJGmkpJzCRXOjYDBDaE=
X-Google-Smtp-Source: ABdhPJzOYRjlDWBGFAd8+wHpr++Fx1aamqiZW3DaWfdMtrRewVD42Wv6SvyQfxbhnME5/3h2VMvoUcmBILP+cPAm8MM=
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr3262615otg.167.1596644944989;
 Wed, 05 Aug 2020 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
 <1633168.eVXp6ieOpF@kreacher> <000d01d66a81$59326a50$0b973ef0$@net>
 <CAJZ5v0h7iKvO1-9R_JiVjM8j_a87B=LpTCoaUWRfrhXTRaMMOw@mail.gmail.com> <ff21e71060b589219c21b46b5e26b6c3aca9f951.camel@linux.intel.com>
In-Reply-To: <ff21e71060b589219c21b46b5e26b6c3aca9f951.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Aug 2020 18:28:51 +0200
Message-ID: <CAJZ5v0hfoHpBX9-W4B7cMRpoxF6a0Ci-81zJC4pwbxGpd_9fGA@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 5, 2020 at 5:38 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2020-08-05 at 11:34 +0200, Rafael J. Wysocki wrote:
> > Hi Doug,
> >
> > On Tue, Aug 4, 2020 at 7:07 PM Doug Smythies <dsmythies@telus.net>
> > wrote:
> > > Hi Rafael,
> > >
> > >
> [...]
>
> > Note that the active mode performance scaling algorithm (which is not
> > the same as the performance cpufreq governor) sets the EPP to 0 for
> > all of the CPUs that it is used with and the driver sets the EPP to
> > 255 in ->stop_cpu.
> >
> > That last bit is questionable, but that's the active mode behavior
> > which is not changed by the $subject patch.
> You need to set the CPU which is going offline to the lowest perf
> settings. If not its sibling's performance can never be lowered than
> offlined CPUs max/min/epp.

OK, fair enough.  I'm not going to make this change after all then. :-)

This behavior is really confusing, though, because if you change the
status from "active" to "passive" or the other way around, the EPP
goes to 0xFF on all CPUs and cannot be restored.

To fix this, we need an extra patch on top of the $subject one to
introduce ->online and ->offline callbacks so that ->offline sets the
EPP to 0xFF and either ->online or ->exit can restore it to the
previous setting.

Cheers!
