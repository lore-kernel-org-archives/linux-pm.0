From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/3] power: clock_ops.c: fixup clk prepare/unprepare count
Date: Mon, 13 Jan 2014 06:28:23 +0000
Message-ID: <52D38787.5030505@codethink.co.uk>
References: <1389445540-21426-1-git-send-email-ben.dooks@codethink.co.uk> <2133074.4EFCIDJZXE@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2133074.4EFCIDJZXE@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@lists.codethink.co.uk, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/01/14 22:04, Laurent Pinchart wrote:
> Hi Ben,
>
> Thank you for the patch.
>
> On Saturday 11 January 2014 13:05:38 Ben Dooks wrote:
>> The drivers/base/power/clock_ops.c file is causing warnings from
>> the clock driver (as shown below) due to failing to do a clk_prepare()
>> call before enabling a clock. It also fails to check the balance of
>> prepare/unprepare as __pm_clk_remove() do clk_disable_unprepare() call.
>>
>> This bug has probably been in since commit b2476490e ("clk: introduce
>> the common clock framework") as the warning was part of the original
>> commit. It is strange that it has not been noticed (although this has
>> also been coupled with a failure for certain SH builds to not build the
>> necessary glue to use this method of controlling the clocks).
>>
>> In summary, this is probably needed in several stable branches but need
>> advice on which ones.
>>
>> On the Renesas Lager board, this causes numerous warnings of the following
>> and even worse the clock system will not enable clocks, causing drivers
>> that are in development to fail to work:
>>
>> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:883 __clk_enable+0x2c/0xa0()
>
> I've never noticed this on Lager, probably because Lager multiplatform doesn't
> make use of clock_ops.c as drivers/sh/pm_runtime.c (which you addressed in
> another patch that I've also replied to). I'm thus not sure we need to apply
> this as a fix and backport it to stable branches.

Yes, it seems that a lot of the lager drivers assume that this support
is there, and the work seems to have been sponsored by Renesas.

I think there must be people still building the old style of kernel
as there is still work going on for board-lager.c which leads me to
being a bit surprised that no-one had noticed this (as it isn't as
if it produces a pile of warnings on the console output).

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
