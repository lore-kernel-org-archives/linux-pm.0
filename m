From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] ARM: dts: augment Ux500 to use DT cpufreq
Date: Wed, 16 Aug 2017 08:56:56 +0530
Message-ID: <20170816032656.GC4233@vireshk-i7>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-2-linus.walleij@linaro.org>
 <20170811051515.GD3638@vireshk-i7>
 <CACRpkdZ-7yHA4Xz62K53_XM28pTNf1dNLV42Fo-Jzzx5Y7in8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35305 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdHPD07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2017 23:26:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id t86so803214pfe.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2017 20:26:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdZ-7yHA4Xz62K53_XM28pTNf1dNLV42Fo-Jzzx5Y7in8g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On 13-08-17, 14:23, Linus Walleij wrote:
> On Fri, Aug 11, 2017 at 7:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > For example, below will fail cpufreq on your board. You can try that
> > to make sure I am not dreaming.
> >
> > - Compile cpufreq-dt as a module.
> > - Boot the board.
> > - Offline CPU0 (i.e. Keep only CPU1 online).
> > - Boom, cpufreq failed.
> >
> > This will happen because the CPU1 doesn't have the operating-points
> > and other properties. We should have them in all the CPUs.
> 
> I don't think that will be a problem because CPU0 cannot be
> taken offline on this system.

Should be fine then.

-- 
viresh
