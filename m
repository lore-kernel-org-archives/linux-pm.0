From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH 6/6] cpufreq: probe the Integrator cpufreq driver
 from DT
Date: Tue, 8 Oct 2013 18:44:13 +0530
Message-ID: <CAKohpo=2jA=0QYPU9coBvu-wJi-DtTD=K4afNxKkDW=t47BbgQ@mail.gmail.com>
References: <1381154027-9197-1-git-send-email-linus.walleij@linaro.org>
	<11922424.2GnUz8ms0E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <11922424.2GnUz8ms0E@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 8 October 2013 01:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, October 07, 2013 03:53:47 PM Linus Walleij wrote:
>> This makes the Integrator cpufreq driver probe from the core
>> module device tree node through it's registered platforms
>> device, getting the memory base from the device tree,
>> remapping it and removing dependencies to <mach/platform.h>
>> and <mach/hardware.h> by moving the two affected CM
>> register offsets into the driver.
>>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> CPUfreq guys - can either of you ACK this patch so I can take
>> it through the ARM SoC tree?
>
> Formally, Viresh is responsible for ARM cpufreq, but I have no objections,
> so please feel free to add:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Sorry, I am currently on vacation so couldn't respond earlier. :(
