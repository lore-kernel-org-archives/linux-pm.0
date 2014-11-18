From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Tue, 18 Nov 2014 20:54:36 +0200
Message-ID: <546B95EC.5000705@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>	<1600093.60yAP0Qpua@wuerfel> <7h389h3aif.fsf@deeprootsystems.com>	<1618855.DXsjWXLqau@wuerfel> <7hsihhzecq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hsihhzecq.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

Thank you for your comments.

On 11/17/2014 11:50 PM, Kevin Hilman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
>> On Monday 17 November 2014 11:14:16 Kevin Hilman wrote:
>>>>>
>>>>> So, The Keystone 2 Generic PM Controller is just a proxy PM layer here between
>>>>> device and Generic clock manipulation PM callbacks.
>>>>> It fills per-device clock list when device is attached to GPD and
>>>>> ensures that all clocks from that list enabled/disabled when device is
>>>>> started/stopped.
>>>>
>>>> The idea of such a generic power domain implementation sounds useful, but
>>>> it has absolutely no business in platform specific code.
>>>
>>> Yes it does.  This isn't a generic power domain implementation, but
>>> rather just the platform-specific glue that hooks up the clocks to the
>>> right devices and power-domains so that the generic power-domain and
>>> generic pm_clocks code does the right thing.
>>
>> How would you do this on an arm64 version of keystone then? With
>> the current approach, you'd need to add a machine specific directory,
>> and that seems completely pointless since this is not even about
>> a hardware requirement.
> 
> Yeah, you're right.  I misunderstood you're original comment.
> 
>>>> I suggest you either remove the power domain proxy from your drivers
>>>> and use the clocks directly,

Hm. I've been thinking about this, but the problem is that Keystone 2
reuses a lot of IPs from Davinci and PM for Davinci is based on Generic clock
manipulation PM callbacks framework, but for non-DT case. So, I can't simply
use clocks directly.

>>>
>>> No.  That's a step in the wrong direction.  This change isn't affecting
>>> drivers directly.  It's the runtime PM and generic power domain layers
>>> that handle this, and runtime PM adapted drivers don't need any changes.
>>>   
>>>> or come up with an implementation that can be used across other
>>>> platforms and CPU architectures.
>>>
>>> We already have those in the generic power domain and the pm_clock
>>> layers.  This series is just hooking those up for Keystone.
>>
>> Then why not add the missing piece to the generic power domain
>> code to avoid having to add infrastructure to the platform
>> for it?
> 
> Yes, good point.  There is nothing keystone-specific in this glue.
> 
> Grygorii, what about adding a feature to the generic domain parsing so
> that it can get clocks from device nodes that are part of the domain,
> and so it sets up pm_clk accordingly.

I'd like to mention few points here:
1)  not all platforms may need this

2)  not all platforms may allow to add ALL clocks from "clocks" property
   to pm_clk as some of them can be optional or have to be controlled by drivers only
   (for example, initially, it was the case for SH-mobile https://lkml.org/lkml/2014/4/24/197
    also now, last implementation for shmobile add only first clock from "clocks" property
    to pm_clk https://lkml.org/lkml/2014/11/17/272).

3)  such functionality have to be enabled for devices selectively, for example
   now we are going to enable it for devices which a ready for runtime PM.

Current implementation cover 1 & 3, but also it allows to cover 2 too, because
it's platform specific implementation and .attach_dev() can be updated to skip some 
clocks or devices if needed.

> 
> I've recently seen other SoCs doing very similar, so this really should
> be generalized.
> 
> I've been looking at this primarily as a right incremental improvement
> from what is there for Keystone today, but Arnd is right.  This should
> be moved out of platform code.

I'm ready to do what ever you want, but I don't fully understand what exactly to do :(
Should I create some generic_pm_clk_domain.c?
- or - Do you mean to integrate it in domain.c (see no way to do it:()?
- or - smth. else

What about introduced DT bindings? For example, How will devices be selected for attachment 
to Generic pm_clk domain if I'll introduce generic_pm_clk_domain.c?

Regards,
-grygorii
