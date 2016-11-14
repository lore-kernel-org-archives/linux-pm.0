From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: add Socionext UniPhier SoCs support
Date: Mon, 14 Nov 2016 01:23:27 +0100
Message-ID: <1876722.yBbCOHufDN@vostro.rjw.lan>
References: <1477500093-12796-1-git-send-email-yamada.masahiro@socionext.com> <20161027032715.GO9162@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48612 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbcKNAPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:15:55 -0500
In-Reply-To: <20161027032715.GO9162@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, October 27, 2016 08:57:15 AM Viresh Kumar wrote:
> On 27-10-16, 01:41, Masahiro Yamada wrote:
> > Add compatible strings for Pro5, PXs2, LD6b, LD11, LD20 SoCs to use
> > the generic cpufreq driver.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

