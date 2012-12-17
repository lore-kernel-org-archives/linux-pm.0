From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/2] clocksource: nomadik-mtu: support timer-based delay
Date: Mon, 17 Dec 2012 10:59:03 -0800
Message-ID: <50CF6B77.3000000@linaro.org>
References: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org> <20121217113611.GA31470@balto.lan> <CACRpkdYRJvFEUvB++fKgVWEXZrTQ7aob0MPMwW4TBs_VRNuzsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYRJvFEUvB++fKgVWEXZrTQ7aob0MPMwW4TBs_VRNuzsA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/17/2012 10:38 AM, Linus Walleij wrote:
> On Mon, Dec 17, 2012 at 12:36 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
>> On Tue, Dec 04, 2012 at 11:10:43AM +0100, Fabio Baltieri wrote:
>>> this implements timer-based delay support for nomadik and ux500
>>> platforms, using the MTU as time source, and marks the u8500 cpufreq
>>> driver as CPUFREQ_CONST_LOOPS accordingly.
>>>
>>> The patches are based on Arnd's arm-soc/ux500/mtu-clk branch, as that
>>> contains latest MTU driver developments, including a driver move/rename,
>>> but I can rebase if necessary.
>> The patches applies cleanly on current mainline now, as all dependencies
>> has already been merged, can this be considered for for merging too?
> If no clocksource maintainer steps up in a week then notify me and
> I'll simply stick these into the ux500 tree.
Yea, I'd actually prefer these go through the arch tree where they can 
get testing.

thanks
-john
