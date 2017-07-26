From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v3 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 11:18:19 +0200
Message-ID: <CAHKzcEMcM7ke=k8qSXH6Y4BhL1U7aO9+y47BgkyNCPBuqmyrZQ@mail.gmail.com>
References: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com> <65601d57-81fb-d8b8-195c-6ec0a429d4c3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35702 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdGZJTB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 05:19:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id r77so5996933wmd.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 02:19:00 -0700 (PDT)
In-Reply-To: <65601d57-81fb-d8b8-195c-6ec0a429d4c3@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 26 July 2017 at 02:54, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/24/2017 09:03 AM, Waldemar Rymarkiewicz wrote:
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
> One minor nit, but it's fine to change later as well.
>
>> @@ -593,18 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>               if (cpu == cpu_dev->id)
>>                       continue;
>>
>> -             tcpu_dev = get_cpu_device(cpu);
>> -             if (!tcpu_dev) {
>> -                     dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>> +             cpu_np = of_get_cpu_node(cpu, NULL);
>> +             if (!cpu_np) {
>> +                     dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
>>                               __func__, cpu);
>> -                     ret = -ENODEV;
>> +                     ret = -ENOENT;
>>                       goto put_cpu_node;
>>               }
>>
>>               /* Get OPP descriptor node */
>> -             tmp_np = dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
>> +             tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>>               if (!tmp_np) {
>> -                     dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
>> +                     dev_err(cpu_dev, "%s: Couldn't find opp node.\n",
>
> I would remove the full-stop. And also use %pOF with cpu_np and pr_err()
> instead of dev_err() here so that we print out the node that's missing
> the OPP node pointer.

Makes sense. I  will send v4 anyway so can include this too.

/Waldek
