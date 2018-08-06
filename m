From: skannan@codeaurora.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Mon, 06 Aug 2018 13:46:05 -0700
Message-ID: <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Evan Green <evgreen@google.com>, tdas@codeaurora.org, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, anischal@codeaurora.org, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-03 15:24, Stephen Boyd wrote:
> Quoting skannan@codeaurora.org (2018-08-03 12:52:48)
>> On 2018-08-03 12:40, Evan Green wrote:
>> > Hi Taniya,
>> >
>> > On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>> >>
>> >> +               if (src)
>> >> +                       c->table[i].frequency = c->xo_rate * lval /
>> >> 1000;
>> >> +               else
>> >> +                       c->table[i].frequency = INIT_RATE / 1000;
>> >
>> > I don't know much about how this hardware works, but based on the
>> > mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
>> > and 3 all mean xo_rate?
>> >
>> > Also, is INIT_RATE really constant? It sounds like gpll0 (or
>> > gpll0_out_even?). You're already getting the xo clock, why not get
>> > gpll0's real rate as well?
>> 
>> Actually I was about to comment and say NOT to get clocks just to get
>> their rate. The XO_RATE is just a multiplication factor. This HW/FW 
>> can
>> change in the future and make the multiplication factor to 1KHz.
> 
> So future changes to this hardware are going to make this register
> return the final frequency that we should use? Sounds great! But that
> isn't how it's working right now. We need to have XO in the binding 
> here
> so the driver can work with different XO frequencies in case that ever
> happens. Same story for GPLL0. Hardcoding this stuff in the driver just
> means we'll have to swizzle things in the driver when it changes.

XO being a different frequency in a Qualcomm chip is way way less likely 
than anything else we are discussing here. In the 10+years I've been 
there this has never changed.

So, how about making this binding optional? If it's not present we can 
make assumptions for XO rate and init rate. That'll handle your 
hypothetical use case while also being optimized.

>> We also
>> can't really control any of the clocks going to this block from Linux
>> (it's all locked down).
> 
> This shouldn't matter. The clocks going to this hardware block are
> described by the firmware to the OS by means of the DT node. If the
> firmware or the hardware decides to change the input clks then the
> binding can have different clk nodes used.

There are tons of clocks that are input to blocks in an SoC that are 
never controlled by Linux. Or are expose in DT because they are set up 
ahead of time and can't change. So, why make an exception here?

>> Adding clk_get significantly delays when this
>> driver can be probed and increases boot up time.
> 
> Huh? Please fix your bootloader to increase the CPU frequency before
> booting the kernel. I really doubt probe defer is going to happen if we
> send GPLL0 here (XO is a DT clk so it's definitely registered before
> this driver), and trying to work around probe defer because the CPU
> won't go fast before that is papering over a larger problem with both
> probe defer and bootloaders not supplying enough CPU speed for you.

There are multiple reason the bootloader can't run the CPU faster. For 
one, it doesn't have thermal handling, etc. And adding all those 
features into the bootloader doesn't make sense when Linux already has 
support for it.

>> The INIT_RATE will
>> always be 300 MHz independent of what source it's coming from (as in, 
>> if
>> GPLL0 can't give 300, the HW design will be so that we'll find a
>> different source).
>> 
>> So, I'd like to remove any clock bindings for this driver.
> 
> No. Bindings describe how the hardware is connected. Please don't 
> remove
> clocks from the binding just because probe defer is a concern.

Binding describes hardware controllable by the OS. That's the reality. 
Let's not add mandatory clock bindings for clocks that the OS can't do 
anything about.

-Saravana
