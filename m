From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] clk: x86: Disable unused clocks to fix S0ix
Date: Wed, 13 Dec 2017 08:25:05 -0600
Message-ID: <d49e5176-91fe-b4ad-11b6-a227edd90fbf@linux.intel.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <1555462.9U3gvkyXAX@aspire.rjw.lan>
 <20170925192352.ihzakshd7yofowdd@sig21.net>
 <7178688.oS2VOf73im@aspire.rjw.lan>
 <fb202f9b-1fa2-4b9c-de75-4431a6273d12@redhat.com>
 <20171213112245.GB20260@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213112245.GB20260@sig21.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 12/13/2017 05:22 AM, Johannes Stezenbach wrote:
> On Wed, Dec 13, 2017 at 09:56:45AM +0100, Hans de Goede wrote:
>> On 13-12-17 01:01, Rafael J. Wysocki wrote:
>>> On Monday, September 25, 2017 9:23:52 PM CET Johannes Stezenbach wrote:
>>>> d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"
>>>> exposed an issue on Asus E200HA where BIOS enables unused
>>>> Atom PMC clocks which prevent the system from entering S0ix.
>>>> Add a quirk to disable these clocks on E200HA.
>>>>
>>>> Signed-off-by: Johannes Stezenbach <js@sig21.net>
>>> Mika, Andy, Hans, any comments here?
>> This seems like it is papering over an issue in the
>> d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"
>> patch to me. That patch seems like a somewhat hackish fix to
>> me, it would be better to figure out which device needs the clock
>> in question and fix the device's driver...
>>
>> And or maybe have a mask of clocks for which to do this check
>> and not do it for all clocks at least? That way we can maybe
>> fix both Johannes and Carlo's issue in one go without needing
>> device specific quirks ?
>>
>> Carlo, do you remember which clock you needed this for ?
>>
>> Johannes, same question for you, which clock is being kept
>> alive because of this ?
> IIRC all of these platform clocks need to be disabled for S0ix,
I don't know if this is 100% correct. We've enabled S0i1 with audio 
playback running in the past, and i think the pmc_clk_3 was used.

> but d31fd43c0f9a keeps them all enabled (if BIOS had enabled them),
> and only the one claimed by the audio codec driver
> is disabled by it before trying to enter S0ix.
>
> Yes, my vote would be to revert d31fd43c0f9a and fix the issue
> properly, but my patch was the result of previous discussion.
> Since it's BIOS' fault to have these clocks enabled I think
> a platform quirk isn't too bad.
>
>
> Thanks,
> Johannes

