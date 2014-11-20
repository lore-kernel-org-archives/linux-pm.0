From: Mason <mpeg.blue@free.fr>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Thu, 20 Nov 2014 15:20:01 +0100
Message-ID: <546DF891.2050401@free.fr>
References: <546D26AE.50601@free.fr> <CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 20/11/2014 10:13, Viresh Kumar wrote:

> On Thu, Nov 20, 2014 at 4:54 AM, Mason <mpeg.blue@free.fr> wrote:
>
>> Hello everyone,
>
> The right list is linux-pm and try to cc maintainers from MAINTAINERS
> file as they can respond quickly then.

Sorry about that. I wasn't even aware that an index like MAINTAINERS
existed AND was kept up-to-date.

>> I'm running kernel 3.14 on an ARM Cortex-A9 based SoC.
>> The baseline frequency for the ARM CPU is 999 MHz.
>>
>> The SoC provides a way to dynamically change the CPU frequency,
>> dividing it by N/16 (N=32..4095) [Actually, I think there are
>> also ways to divide by 1.x, but I need to read the docs again.]
>>
>> I'm writing the platform-specific cpufreq driver.
>> I could expose hundreds of frequencies to cpufreq, but I don't
>> think that would be very productive. Correct?
>> (Note: I can't offer ANY frequency.)
>>
>> My question is: how many frequencies should I expose for "optimal"
>> behavior of cpufreq?
>
> You can specify as many number of frequencies as you want. The framework
> doesn't have any upper cap on that. But there is no point specifying
> 500 MHz and 510 MHz, you wouldn't save much power with 500 :)

Suppose I expose 100 frequencies. Aside from wasting memory, isn't
there also a risk that cpufreq will take time, ramping up/down
through similar frequencies? (Or does it just say "jump to THAT
frequency" skipping useless intermediate frequencies?)

> So, just gap them smartly. Normally people gap them to 100 MHz. But
> if there is a voltage change required at some specific freq, suppose 550 MHz,
> then its better you specific that as well..

Point taken.

>> I'm thinking I would only expose div={2,3,5} meaning the available
>> scaled frequencies would be {500,333,200} MHz. Are these enough?
>
> I thought you can goto 1 GHz.. Why not the upper ones then?

The actual formula for dividers is
div(I,F) = if I > 1 then I+F/16 else I+F/(32-F)
I=1..255 F=0..15

So, I can use (for example) div={1, 1.33, 2, 4, 8}
to offer freq={999,750,500,250,125}

>> Should there be more? Should I go lower than 200 MHz?
>
> If that really saves power.

There is a trade-off, tough.

My concern is this: suppose the CPU cores are set to e.g. 54 MHz.
Suddenly, the driver for an important subsystem needs to speak with
the corresponding device, with hard deadlines in the comms protocol.
Will the CPU ramp up fast enough (assuming ondemand governor).

And the end of this message is as good a place as any to thank you
for having answered my many questions.

Regards.

