From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol brcm_avs_cpufreq_attr static
Date: Mon, 14 Nov 2016 01:33:21 +0100
Message-ID: <5120029.lrhJXGVADr@vostro.rjw.lan>
References: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com> <CAGt4E5sQvRXdS+wh2jqa9jF4jxS9TxnULXwg1vJm1fwU-Gja4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65017 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751057AbcKNAZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:25:49 -0500
In-Reply-To: <CAGt4E5sQvRXdS+wh2jqa9jF4jxS9TxnULXwg1vJm1fwU-Gja4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>

On Thursday, November 10, 2016 02:06:16 PM Markus Mayer wrote:
> On 10 November 2016 at 07:19, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > Fixes the following sparse warning:
> >
> > drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
> >  symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?
> 
> Yes, thanks for the fix.
> 
> Acked-by: Markus Mayer <mmayer@broadcom.com>

Applied.

Thanks,
Rafael

