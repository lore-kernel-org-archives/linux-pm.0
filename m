From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Fri, 27 Oct 2017 21:16:08 +0200
Message-ID: <CAJZ5v0hH62vFnL0=rK6VHB8LSBB=BD2CG5apw3QCxd=BH_OzYA@mail.gmail.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan> <20171024055409.GA5805@intel.com>
 <2465945.6cfLQGiipl@aspire.rjw.lan> <CAHp75VdY=q4A2cam=xg17+pOPgDbtYRdVdQvEjO7OGjG6m947Q@mail.gmail.com>
 <CAJZ5v0hgnq78z+=msaJjJmSFSHPM06MZ2_iRzixtRRDGxK-yBg@mail.gmail.com> <CAHp75VcdUP-108-ijVubYBXGyJOkpoP6hGz7LLu86NJAaMM3OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:48205 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbdJ0TQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2017 15:16:09 -0400
In-Reply-To: <CAHp75VcdUP-108-ijVubYBXGyJOkpoP6hGz7LLu86NJAaMM3OA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ramesh.thomas@intel.com, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Oct 27, 2017 at 8:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Oct 26, 2017 at 11:38 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Oct 25, 2017 at 10:06 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Oct 24, 2017 at 11:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Tuesday, October 24, 2017 7:54:09 AM CEST Ramesh Thomas wrote:
>>>>> On 2017-10-20 at 13:27:34 +0200, Rafael J. Wysocki wrote:
>>>
>>>>> >  static ssize_t pm_qos_resume_latency_store(struct device *dev,
>>>>> > @@ -228,11 +235,19 @@ static ssize_t pm_qos_resume_latency_sto
>>>>> >     s32 value;
>>>>> >     int ret;
>>>
>>>>> > +   if (!kstrtos32(buf, 0, &value)) {
>>>>> > +           /*
>>>>> > +            * Prevent users from writing negative or "no constraint" values
>>>>> > +            * directly.
>>>>> > +            */
>>>>> > +           if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>>>>> > +                   return -EINVAL;
>>>
>>>>> > +           if (value == 0)
>>>>> > +                   value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>>>> > +   } else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
>>>>>
>>>>> Can the 2 checks for "n/a" be combined by checking first 3 characters?
>>>>
>>>> No, because "n/asomething" would then match too.
>>>
>>> If I don't missed anything, kernfs is aware of \n which means the
>>> first check is enough.
>>> Am I correct?
>>
>> I'm not sure, honestly. :-)
>
> Okay, just a summary:
> 1. kernfs guarantees that buffer is NULL terminated
> 2. sysfs guarantees that the buffer is not empty
> 3. kstrto* are aware of '\n'
> 4. sysfs_streq() and __sysfs_match_string() are aware of '\n'
>
> Thus, we just may use sysfs_streq() for that.
>
> I will prepare a clean up patch on top of this fix if you are okay with it.

OK, but then please cover all similar cases in this file.

Thanks,
Rafael
