From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sun, 19 Mar 2017 19:13:24 +0100
Message-ID: <bae15856-5c25-6288-2cc8-7fde530fe84d@redhat.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <1489935277.19767.89.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdCSSvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Mar 2017 14:51:05 -0400
In-Reply-To: <1489935277.19767.89.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi Andy,

On 19-03-17 15:54, Andy Shevchenko wrote:
> On Sat, 2017-03-18 at 17:57 -0700, Liam Breck wrote:
>
>>> Assuming the platform_data has sane values like uA that means
>>> re-implementing most of the bq24190 driver in the code filling
>>> the platform data (to go from register values to uA) that does
>>> not seem like a sane approach when a simple do not reset
>>> flag suffices. Note also see below for another way to deal
>>> with this.
>>
>> I am suggesting you treat platform_data like a DT node: fill it with
>> board-specific params. Don't compute the params, read them manually
>> via /sys/class/...-charger/f_* and hard-code them for this board. That
>> gives you control over the charger config. You've already found that
>> you need that given the high voltage setting.
>
> Guys, did you see my mail regarding all these?

Yes I did, thank you for all the reviews! I still need to go
over them one by one. From the top of my head I agree with most of
your comments and will fix them for the next version.

One thing I disagree with is the cht_wc > chtwc rename you are
proposing for one Cherry Trail and Whiskey Cove are 2 different
words (4 if you look at spelling but 2 if you look at pronunciation,
so IMHO cht_wc is more readable other then that I see the suggested
rename as a lot of extra churn without any tangible benefits.

> Repeating myself here:
>
> "I would not extend platform data at all.
> For GPIO we may use GPIO lookup tables, for the rest -- unified (built-
> in) device properties API.
>
> Consider to get rid of
>  include/linux/power/bq24190_charger.h
> completely."
>
> Do you consider that approach? If no, why not?

Liam asked more or less the same question and I answered with:

"Since this is info being passed around inside the kernel
using platform_data is a hell of a lot simpler (and cleaner
no need to check types, etc on the receiving side) then
using device-properties. Device-properties are nice when
getting info from firmware, but this is not that.

Also one of the things passed is actually a function
pointer to a function to get extra power_supply_properties
from the fuel-gauge, and passing function pointers certainly
is not something which should be done through device-props."

Now the function pointer bit is possibly going away but
it still feels wrong to first pack some native C-type into
a device-prop and then needing to unpack it on the other
side using platform_data for passing things along which
are purely in kernel really is a lot easier.

Regards,

Hans
