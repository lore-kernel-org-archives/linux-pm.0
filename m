From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/17] thermal: add COMPILE_TEST (on drivers)
Date: Thu, 10 Sep 2015 17:34:28 +0200
Message-ID: <CAMuHMdVArB3wPtHWNN8r=Pf4LCQjuU8OJwMeiNYsinBnz_R36Q@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<CAMuHMdVRztDtqDU6j6UBmGy4Z3Sm=QtCr0rrPwxrV+axTw17iA@mail.gmail.com>
	<20150910145640.GA32748@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150910145640.GA32748@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

On Thu, Sep 10, 2015 at 4:56 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Thu, Sep 10, 2015 at 08:23:45AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Sep 10, 2015 at 6:10 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> > This is a simple series to add the COMPILE_TEST on thermal drivers.
>> > The idea is to help compiling and maintaining.
>>
>> Thanks, good idea!
>>
>> > Split into smaller patches so people can have their own voices on their drivers.
>> >
>> > Let me know if this is a problem.
>>
>> Have you compile-tested this?
>> I'm seeing too many failures.
>
> Yes I did, but apparently I missed some drivers in my test. I had x86
> target while compile arm drivers, thats probably why I did not see the
> cpuid problems. I am trying again, as I really did not see all errors
> you mentioned on arm drivers.

I compiled on m68k, to make sure none of the drivers are native ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
