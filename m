From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH v2] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Wed, 8 Jun 2016 00:31:54 -0700
Message-ID: <CAJFUiJiueshUbY416YkGKQJb1W4D3XBuyqBc62NV1mQfKF-C4g@mail.gmail.com>
References: <1465279021-3299-1-git-send-email-lianwei.wang@gmail.com> <alpine.DEB.2.11.1606070832440.28031@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1606070832440.28031@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 6, 2016 at 11:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 6 Jun 2016, Lianwei Wang wrote:
>> Currently it just print a warning message but did not
>> reset cpu_hotplug_disabled when the enable/disable is
>> unbalanced. The unbalanced enable/disable will lead
>> the cpu hotplug work abnormally.
>>
>> Do nothing if an unablanced hotplug enable detected.
>>
>> Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
>> ---
>>  kernel/cpu.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 3e3f6e49eabb..8011b1e40523 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -245,6 +245,19 @@ void cpu_hotplug_done(void)
>>       cpuhp_lock_release();
>>  }
>>
>> +static void _cpu_hotplug_disable(void)
>
> What's the purpose of this function?
>
The only purpose is to make the cpu_hotplug_disable as one API and
always disable it from the same interface. It makes the code looks
more beautiful. But yes, we can remove it since it is not necessary
for this change.

>> +{
>> +     cpu_hotplug_disabled++;
>> +}
>> +
>> +static void _cpu_hotplug_enable(void)
>
> Double underscores please
>
Ok, I will update it.
>> +{
>> +     if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
>> +             return;
>
> And this want's to be a WARN_ONCE()
>
WARN is convenient for debugging because kernel buffer is limited and
we might lose the first warning message. But WARN_ONCE is good to me
too.

> Thanks,
>
>         tglx
