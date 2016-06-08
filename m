From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] leds: handle suspend/resume in heartbeat trigger
Date: Wed, 8 Jun 2016 10:28:38 +0200
Message-ID: <CACRpkdZSAy=MzmBY6kMn7AQ1=N2unjgBVLPPXd34GjWGvRkPaA@mail.gmail.com>
References: <1464874906-13120-1-git-send-email-linus.walleij@linaro.org> <CAPDyKFp3DnGp2MRQOSOpRHhuD5_2MiA2Wge01W6B43YHpQ8S8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp3DnGp2MRQOSOpRHhuD5_2MiA2Wge01W6B43YHpQ8S8Q@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 3, 2016 at 11:32 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> I believe most other led-trigger types that should also be "suspended"
> in the similar fashion as the heartbeat. Perhaps not all, but least
> some more (timer, cpu, etc).

I'm uncertain about those ... I guess they need separate patches
at least.

> Okay, my point is, perhaps we should do this in a more generic manner
> and manage the suspend/resume of triggers in
> drivers/leds/led-triggers.c?

That must be done by someone familar with that code I'm afraid.
I'm not sure, the other triggers have their own special hooks (like
the CPU trigger hooking into the CPU suspend/resume ops) so
I'm worried about breaking them.

>> +       switch (pm_event) {
>> +       case PM_SUSPEND_PREPARE:
>
> I think you should add:
> case PM_HIBERNATION_PREPARE:
> case PM_RESTORE_PREPARE:
>
>> +               led_trigger_unregister(&heartbeat_led_trigger);
>> +               break;
>> +       case PM_POST_SUSPEND:
>
> I think you should add:
> case PM_POST_HIBERNATION:
> case PM_POST_RESTORE:

Fixing this and resending.

Yours,
Linus Walleij
