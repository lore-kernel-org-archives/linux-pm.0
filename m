From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert from
 i2c-smbus to i2c-core-smbus
Date: Tue, 7 Nov 2017 09:16:27 +0800
Message-ID: <2eaccb51-62cf-b764-d313-84008c6c8f87@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
 <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
 <1397131b-c22d-9872-dbe0-9b691553cb9e@electromag.com.au>
 <20171106213646.2h3zsitnlablblli@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106213646.2h3zsitnlablblli@ninjato>
Content-Language: en-AU
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 7/11/2017 05:36, Wolfram Sang wrote:
> Hey Phil,
> 
> (CCing Jean for some additional expertise)
> 
>>>> In preparation to adding of_i2c_setup_smbus_alert() move
>>>> i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
>>>> will call i2c_setup_smbus_alert() and this avoid module dependecy issues.
>>>
>>> I am not very happy with this but don't want to cause another delay. So,
>>> I hope we can discuss and fix it incrementally.
>>>
>>>  From what it does, I really think both setup_alert functions belong
>>> to i2c-smbus.c. Three possibilities come to my mind (untested,
>>> though):
>>>
>>> a) use try_then_request_module somehow
>>>
>>> b) add to CONFIG_I2C something like: select I2C_SMBUS if OF
>>>
>>> c) get rid of i2c-smbus.c entirely and move it all into the core
>>>
>>> Dunno if a) or b) have been tried in the course of this series
>>> already?
>>>
>>
>> Nope hadn't tried either a) or b). a) is not something I was aware of.
>> Had a brief play and not sure how to make this work. This gives me the
>> same linking problem.
> 
> Which one? I2C core is built-in and the driver is a module? And
> i2c-smbus is a module then, too?
Yes. I may be doing something wrong with how to use a) thou..
I do like conditional pulling the alert code in the to core if everyone else is happy with that.


> 
>> A variant of b) was tried by selecting I2C_SMBUS from driver modules
>> having smbalert support, but that caused problems if the i2c core was
>> builtin and the driver was a module. But this looks to work for me.
> 
> It should work(tm). Yet, it will cause overhead, because OF is big these
> days and I2C_SMBUS is still rare.
> 
>> A variant of c) with option to exclude the i2c-smbus code still.
>> Add i2c-smbus to the i2c-core module by:
>> Change Kconfig I2C_SMBUS to a bool
>> add i2c-smbus to i2c-core object.
>> fixup duplicate init_module calls etc.
> 
> I see. From my side, why not. But I'd really like Jean's opinion here on
> why i2c-smbus.c was a seperate module and not included in the core.
> Because I split the I2C core into multiple source files recently, we
> could have a seperate source file for i2c-smbus-alert without ifdeffery
> but with some Makefile magic.
> 
>> Possibly also rename i2c-smbus to i2c-smbus-alert?
> 
> Why the rename? I thought we put all the code into the core?

I was just thinking that all that's in the file now is smbus-alert code.
The other smbus (host notify) code was moved to i2c-core
So maybe i2c-core-smbus-alert and as you say use makefile to include it.
I've tried this and it seems to work for the various combinations.
I'll wait a bit for Jean to offer an opinion.

> 
>> Let me know your preference and I'll put something together.
> 
> Thanks for the assistance. I am afraid we need a bit more discussion
> first, though.


-- 
Regards
Phil Reid
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
