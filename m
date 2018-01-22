From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Mon, 22 Jan 2018 13:30:30 -0800
Message-ID: <CAJWu+oqdS9LUqaKMWpS5gG-HAD5UGL8SW2ZxED55BR6Pvmbu=A@mail.gmail.com>
References: <20180119094549.5468-1-quentin.perret@arm.com> <20180119094549.5468-3-quentin.perret@arm.com>
 <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com> <20180122051126.GD2421@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:40570 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeAVVab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 16:30:31 -0500
Received: by mail-io0-f180.google.com with SMTP id t22so10987826ioa.7
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2018 13:30:31 -0800 (PST)
In-Reply-To: <20180122051126.GD2421@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, Amit Kachhap <amit.kachhap@gmail.com>, javi.merino@kernel.org, rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On Sun, Jan 21, 2018 at 9:11 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19-01-18, 15:15, Joel Fernandes wrote:
>> > -       if (capacitance) {
>> > -               ret = update_freq_table(cpufreq_cdev, capacitance);
>> > -               if (ret) {
>> > -                       cdev = ERR_PTR(ret);
>> > -                       goto remove_ida;
>> > -               }
>> > -
>> > -               cooling_ops = &cpufreq_power_cooling_ops;
>> > -       } else {
>> > -               cooling_ops = &cpufreq_cooling_ops;
>
>> also don't unnecessarily call
>> dev_pm_opp_find_freq_ceil in update_freq_table.
>
> He would need that anyway as he needs to get the real power numbers.
>

I think I wasn't articulating well enough what I meant but sorry if I
missed something...

In the current code, if capacitance is not available, then
update_freq_table -> dev_pm_opp_find_freq_ceil isn't called. However
in the new code, with this patch, you're calling update_freq_table
anyway and later discovering through the new 'found_power' variable
that capacitance isn't possibly available. It seems the new code will
be slower than the older one.

Instead of doing that, if you queried that capacitance isn't available
in advance, then you could avoid finding that out later. Admittedly, I
am new to these code paths so forgive me if I'm noisy, just trying to
help. And thanks for explaining anything I missed.

Thanks,

- Joel
