From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Wed, 25 Oct 2017 23:06:42 +0300
Message-ID: <CAHp75VdY=q4A2cam=xg17+pOPgDbtYRdVdQvEjO7OGjG6m947Q@mail.gmail.com>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan> <20171024055409.GA5805@intel.com>
 <2465945.6cfLQGiipl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:52180 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdJYUGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 16:06:44 -0400
In-Reply-To: <2465945.6cfLQGiipl@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ramesh.thomas@intel.com, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Oct 24, 2017 at 11:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 24, 2017 7:54:09 AM CEST Ramesh Thomas wrote:
>> On 2017-10-20 at 13:27:34 +0200, Rafael J. Wysocki wrote:

>> >  static ssize_t pm_qos_resume_latency_store(struct device *dev,
>> > @@ -228,11 +235,19 @@ static ssize_t pm_qos_resume_latency_sto
>> >     s32 value;
>> >     int ret;

>> > +   if (!kstrtos32(buf, 0, &value)) {
>> > +           /*
>> > +            * Prevent users from writing negative or "no constraint" values
>> > +            * directly.
>> > +            */
>> > +           if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>> > +                   return -EINVAL;

>> > +           if (value == 0)
>> > +                   value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> > +   } else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
>>
>> Can the 2 checks for "n/a" be combined by checking first 3 characters?
>
> No, because "n/asomething" would then match too.

If I don't missed anything, kernfs is aware of \n which means the
first check is enough.
Am I correct?

-- 
With Best Regards,
Andy Shevchenko
