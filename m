From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: Need help understanding the logic of __cpuidle_set_driver
Date: Fri, 22 Aug 2014 17:36:23 +0530
Message-ID: <CAGAs2AkZH4GJv9g_-HJRw6HWSNMuefZTbK4nL0GR=TAP5GGn1Q@mail.gmail.com>
References: <CAHu9=sOwSuw5igPp0UQWJe8fwMb_vt3PPrc1A9nK4pJB5QmXDA@mail.gmail.com>
	<53F553A9.7050104@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55107 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaHVMG0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 08:06:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so16609798pab.30
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2014 05:06:23 -0700 (PDT)
In-Reply-To: <53F553A9.7050104@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

>> However, regarding the logic, I have a few doubts -
>>
>> 1. for each cpu in drv->cpumask, if there is already a driver
>> registered, its calling __cpuidle_unset_driver which loops over for
>> each cpu in drv->cpumask again. Isn't it unnecessary to do this nested
>> calls?
>
>
> It is to rollback the previous changes done in the loop.

However, I have two concerns here:-
1.
static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
{
        int cpu;
        struct cpuidle_driver *tmp = NULL;
        for_each_cpu(cpu, drv->cpumask) {

                tmp = __cpuidle_get_cpu_driver(cpu); /* This would
prevent nesting of loops */
                if ( tmp != NULL ) {
                        if ( tmp == drv )
                              per_cpu(cpuidle_drivers, cpu) = NULL;
                        return -EBUSY;
                }

                per_cpu(cpuidle_drivers, cpu) = drv;
        }

        return 0;
}
Instead of calling __cpuidle_unset_driver() which would loop-over
again for all the cpus , is it not that the above function would be
more efficient.

2. Secondly, if the cpuidle driver to be registered matches to the one
already registered , then why should it be unset instead of leaving it
as it is.


Any views would be highly appreciated.
