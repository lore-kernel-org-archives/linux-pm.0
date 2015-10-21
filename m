From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Alternative approach to solve the deferred probe
Date: Wed, 21 Oct 2015 19:55:29 +0300
Message-ID: <5627C381.60602@ti.com>
References: <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk> <56270D5B.5010902@gmail.com>
 <20151021081847.GB32532@n2100.arm.linux.org.uk> <5627B0F7.7010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5627B0F7.7010600@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: frowand.list@gmail.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=c3=b6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood>
List-Id: linux-pm@vger.kernel.org

On 10/21/2015 06:36 PM, Frank Rowand wrote:
> On 10/21/2015 1:18 AM, Russell King - ARM Linux wrote:
>> On Tue, Oct 20, 2015 at 08:58:19PM -0700, Frank Rowand wrote:
>>> On 10/20/2015 8:46 AM, Russell King - ARM Linux wrote:
> 
> < snip >
> 
>>>> +
>>>>   static bool driver_deferred_probe_enable = false;
>>>> +
>>>>   /**
>>>>    * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
>>>>    *
>>>> @@ -188,6 +210,13 @@ static int deferred_probe_initcall(void)
>>>>   	driver_deferred_probe_trigger();
>>>
>>> Couldn't you put the "driver_deferred_probe_report = true" here?  And then
>>> not add another round of probes.
>>
>> The idea is not to report anything for drivers that were deferred
>> during the normal bootup.  The above is part of the normal bootup,
>> and the deferred activity should not be warned about.
> 
> The above is currently the last point for probe to succeed or defer
> (until possibly, as you mentioned, module loading resolves the defer).
> If a probe defers above, it will defer again below.  The set of defers
> should be exactly the same above and below.
> 

Unfortunately this is not "the last point for probe to succeed or defer".
There are still a bunch of drivers in Kernel which will be probed at late_initcall() level.
(like ./drivers/net/ethernet/ti/cpsw.c => late_initcall(cpsw_init);
Yes - they probably need to be updated to use module_init(), but that's what
we have now). Those drivers will re-trigger deferred device probing if their
probe succeeded.

As result, it is impossible to say when will it happen the 
"final round of deferred device probing" :( and final list of drivers which
was "deferred forever" will be know only when kernel exits to User space 
("deferred forever" - before loading modules).

May be, we also can consider adding debug_fs entry which can be used to display
actual state of deferred_probe_pending_list? 

>>
>> If we have any devices still deferring after _this_ round, that must
>> indicate that some resource they want is not available, and that
>> should be warned about.
>>
>> Of course, modules can defer too - and I made some suggestions in my
>> waffle above the patch about that.
>>
> 
> < adding back trimmed, for fuller context >
> 
>>>>   	/* Sort as many dependencies as possible before exiting initcalls */
>>>>   	flush_workqueue(deferred_wq);
>>>> +
>>>> +	/* Now one final round, reporting any devices that remain deferred */
>>>> +	driver_deferred_probe_report = true;
>>>> +	driver_deferred_probe_trigger();
>>>> +	/* Sort as many dependencies as possible before exiting initcalls */
>>>> +	flush_workqueue(deferred_wq);
>>>> +
>>>>   	return 0;
>>>>   }


-- 
regards,
-grygorii
