From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Thu, 20 Jul 2017 11:06:12 +0200
Message-ID: <CAHKzcEODLquVxWnywz=vYtio3U6NbeVs8h5XshTVGdWVU_tABA@mail.gmail.com>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org> <20170717071234.GK352@vireshk-i7>
 <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com>
 <20170718043536.GT352@vireshk-i7> <CAHKzcENsE=So2omU2v27XoHEbvcpW1gmB5P0NM=Z-Bg=f_O_4g@mail.gmail.com>
 <20170720033158.GH352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36646 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935485AbdGTJGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 05:06:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id y67so9025349wrb.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2017 02:06:53 -0700 (PDT)
In-Reply-To: <20170720033158.GH352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 20 July 2017 at 05:31, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19-07-17, 16:10, Waldemar Rymarkiewicz wrote:
>> Anyway, below a proposal how we can solve the problem of getting
>> shared CPUs w
>>         /* Get OPP descriptor node */
>> @@ -572,22 +592,16 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>         if (!of_property_read_bool(np, "opp-shared"))
>>                 goto put_cpu_node;
>>
>> -       for_each_possible_cpu(cpu) {
>> +       for_each_node_by_type(cpu_np, "cpu") {
>> +               cpu = of_device_node_get_cpu(cpu_np);
>
> Actually you can keep the original loop as it is and use
> of_get_cpu_node() here. We better open code of_device_node_get_cpu()
> here.

Indeed, I can do so.

>> +
>>                 if (cpu == cpu_dev->id)
>>                         continue;
>>
>> -               tcpu_dev = get_cpu_device(cpu);
>> -               if (!tcpu_dev) {
>> -                       dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>> -                               __func__, cpu);
>> -                       ret = -ENODEV;
>> -                       goto put_cpu_node;
>> -               }
>> -
>>                 /* Get OPP descriptor node */
>> -               tmp_np = _of_get_opp_desc_node(tcpu_dev);
>
> I see dev_pm_opp_of_get_opp_desc_node() here, not sure how you got
> above change..

Yeah, I test on 4.9 kernel. I will include your comments and build
patch on top of linux-next/master anyway.

>> +               tmp_np = of_parse_phandle(cpu_np, "operating-points-v2", 0);
>
> I would create _opp_of_get_opp_desc_node(np) and use it everywhere,
> i.e. from dev_pm_opp_of_get_opp_desc_node() as well.

Makes sense.

/Waldek
