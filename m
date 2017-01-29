From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Sun, 29 Jan 2017 12:47:57 -0800
Message-ID: <0447204d-34c6-aa62-d82b-ee064f1e79bb@roeck-us.net>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth> <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth> <20170119232934.GA18102@roeck-us.net>
 <20170120083804.GF4894@ulmo.ba.sec> <20170129200239.x2rwx23xjj57flus@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43489 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdA2UsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 15:48:01 -0500
In-Reply-To: <20170129200239.x2rwx23xjj57flus@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/29/2017 12:02 PM, Sebastian Reichel wrote:

>>
>> To keep things simple, I think it would be okay to allow only one of
>> each type of controller in any running system. It's very unlikely that
>> board designers would devise two different ways of powering off or
>> restarting a system, while in a similar way an SoC or CPU would only
>> ever provide one way to do so. Even if theoretically multiple
>> possibilities exist, I think the board code should pick which ones are
>> appropriate.
>
> Using that logic we may also advice, that board-code should only
> register the board-level reset/poweroff and it's enough to have
> a callback again... I wonder if that is really feasible.
>

FWIW, it is also not true. There is a reason why many of the restart
handlers used to have code saying "install restart handler, but only
if none is installed yet". Which of course is racy, and gets more
interesting if the restart handler installed first is unloaded at a
later time, leaving the system with no restart handler. Or both are
unloaded, leaving the system with a pointer to a no longer existing
handler.

One could then argue that anything implementing a restart handler must
not unload. Which results in more restrictions. And drivers loaded
on hardware which don't need it. And more corner cases to deal with.
And more inconsistencies.

In reality, many systems or system variants will have more than one means
to restart it. Yes, board designers do devise multiple ways of powering off
or restarting a system. There may be and likely are valid reasons for doing
so; I would not want to claim or suggest that board designers would design
such hardware without reason. Even "standard" PCs tend to have have more
than one means to reset it. There _was_ a reason for introducing that
framework; I didn't just do it for fun.

However, as I had mentioned before, I am not really interested in this
topic anymore. Just treat this as my final word of caution, or feel free
to ignore it. I hope you'll find a much better solution than mine
to implement "the board code should pick which ones are appropriate".

Thanks,
Guenter

