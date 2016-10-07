From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH v2 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
 driver for Broadcom STB SoCs
Date: Fri, 7 Oct 2016 09:03:46 +0530
Message-ID: <20161007033346.GA3954@vireshk-i7>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-3-git-send-email-mmayer@broadcom.com>
 <20161005032509.GG4664@vireshk-i7>
 <CAGt4E5s9UBam4RKsq3k1P77-81NR-8AeQi==7dBNnp37xxtr_g@mail.gmail.com>
 <20161006040139.GA17619@vireshk-i7>
 <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34834 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934928AbcJGDdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 23:33:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id s13so17896228pfd.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Oct 2016 20:33:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06-10-16, 07:51, Markus Mayer wrote:
> During early development, when the driver couldn't fully register, I
> would see the init() function called four times, i.e. once for each
> core. If the first call succeeded, that was it. It would only get
> called once. But if it failed, all cores would try to register. And I
> wanted to avoid spilling the same error message four times.

This is the current behavior of the cpufreq core.

> I'll look at that again. It may have had something to do with how the
> driver worked back then. If it doesn't happen anymore, I'll just get
> rid of this code.

I don't think so, but again, we don't need to have special code to save few
lines which get printed only in the rare case of errors.

-- 
viresh
