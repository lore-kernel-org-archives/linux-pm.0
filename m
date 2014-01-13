From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/3] power: clock_ops.c: fixup clk prepare/unprepare count
Date: Mon, 13 Jan 2014 09:21:45 +0000
Message-ID: <52D3B029.4060509@codethink.co.uk>
References: <1389445540-21426-1-git-send-email-ben.dooks@codethink.co.uk> <2133074.4EFCIDJZXE@avalon> <52D38787.5030505@codethink.co.uk> <CAMuHMdXek5YhKt9p-1LPXRuifqv6sazwzTZ+k6Ps=1-Myepirw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXek5YhKt9p-1LPXRuifqv6sazwzTZ+k6Ps=1-Myepirw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@lists.codethink.co.uk, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 13/01/14 08:50, Geert Uytterhoeven wrote:
> On Mon, Jan 13, 2014 at 7:28 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> I've never noticed this on Lager, probably because Lager multiplatform
>>> doesn't
>>> make use of clock_ops.c as drivers/sh/pm_runtime.c (which you addressed in
>>> another patch that I've also replied to). I'm thus not sure we need to
>>> apply
>>> this as a fix and backport it to stable branches.
>>
>>
>> Yes, it seems that a lot of the lager drivers assume that this support
>> is there, and the work seems to have been sponsored by Renesas.
>
> I can confirm that applying both this and "[PATCH] ARM: shmobile: compile
> drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI" makes

Thanks. Wonder how long this has been broken for?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
