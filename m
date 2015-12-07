From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: mt8173: move resources allocation into
 ->probe()
Date: Mon, 7 Dec 2015 21:33:57 +0530
Message-ID: <20151207160357.GL3294@ubuntu>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
 <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
 <CAGS+omBwHVAARNA=ZwK+fAwfJye6eDnxoKW6qCaH_haqsw9PJA@mail.gmail.com>
 <CALx668XbV2CbuB0QL_3eV=JMTeOyjKP=s2mznadQxgGD_SGABg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33997 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbbLGQED (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 11:04:03 -0500
Received: by pacwq6 with SMTP id wq6so49611710pac.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 08:04:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALx668XbV2CbuB0QL_3eV=JMTeOyjKP=s2mznadQxgGD_SGABg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ricky Liang <jcliang@chromium.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 07-12-15, 20:42, Pi-Cheng Chen wrote:
> >>         ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
> >
> > Hmm. Does this change at init() time?  Or can we move this to probe(), too?
> 
> It doesn't change at init() time for MT8173 since we don't add OPP
> dynamically and I don't see any problem to move it. I will move it to probe().

No. None of this belongs to probe(), we do it there just to handle the
EPROBE_DEFER thing. Please don't move anything that isn't required to
be.

-- 
viresh
