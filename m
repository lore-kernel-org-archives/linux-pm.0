From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: mt8173: move resources allocation into ->probe()
Date: Mon, 30 Nov 2015 22:38:57 +0800
Message-ID: <CALx668XUU4H1QnVAF8Mo78_QbeNawb6yFbxC30ZCuzoD0tuKnw@mail.gmail.com>
References: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
	<20151130053206.GL3373@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34587 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbbK3Oi7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 09:38:59 -0500
Received: by ykfs79 with SMTP id s79so186828513ykf.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 06:38:57 -0800 (PST)
In-Reply-To: <20151130053206.GL3373@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ricky Liang <jcliang@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, "moderated list:ARM/Mediatek SoC..." <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Nov 30, 2015 at 1:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-11-15, 11:02, Ricky Liang wrote:
>> On Sun, Nov 29, 2015 at 4:31 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> >         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
>> >         if (ret)
>> >                 pr_err("failed to register mtk cpufreq driver\n");
>>
>> I think you want "return ret;" inside the if block.
>
> Not just that, he needs to jump to release_dvfs_info_list.

Hi Ricky and Viresh,

Thanks for reviewing.
I failed to check this error case handling.
I will fix it and resend again.

Best Regards,
Pi-Cheng

>
>> >
>> > +       return 0;
>> > +
>> > +release_dvfs_info_list:
>> > +       list_for_each_safe(list, tmp, &dvfs_info_list) {
>> > +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
>> > +
>> > +               mtk_cpu_dvfs_info_release(info);
>> > +               list_del(list);
>> > +               kfree(info);
>> > +       }
>> > +
>> >         return ret;
>> >  }
>
> --
> viresh
