From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: mt8173: move resources allocation into
 ->probe()
Date: Mon, 30 Nov 2015 11:02:06 +0530
Message-ID: <20151130053206.GL3373@ubuntu>
References: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34297 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbK3FcT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 00:32:19 -0500
Received: by padhx2 with SMTP id hx2so172948510pad.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 21:32:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ricky Liang <jcliang@chromium.org>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linaro-kernel@lists.linaro.org, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, "moderated list:ARM/Mediatek SoC..." <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 30-11-15, 11:02, Ricky Liang wrote:
> On Sun, Nov 29, 2015 at 4:31 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> >         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
> >         if (ret)
> >                 pr_err("failed to register mtk cpufreq driver\n");
> 
> I think you want "return ret;" inside the if block.

Not just that, he needs to jump to release_dvfs_info_list.

> >
> > +       return 0;
> > +
> > +release_dvfs_info_list:
> > +       list_for_each_safe(list, tmp, &dvfs_info_list) {
> > +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
> > +
> > +               mtk_cpu_dvfs_info_release(info);
> > +               list_del(list);
> > +               kfree(info);
> > +       }
> > +
> >         return ret;
> >  }

-- 
viresh
