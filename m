From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Tue, 8 Aug 2017 22:53:45 +0200
Message-ID: <67c2ed8f-f89d-7c00-3e51-0b5f1e38442e@redhat.com>
References: <5f3d7cfa-c993-0cda-fae6-a975f7d4ca1c@redhat.com>
 <20170808093947.ezczjb6stdgek4hy@sirena.org.uk>
 <0b75c318-0f71-c536-7c7f-9ba16b215690@redhat.com>
 <20170808144217.c2fm25uge75p4lo2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170808144217.c2fm25uge75p4lo2@sirena.org.uk>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

<resend with the CC really added back>

Hi,

On 08/08/2017 04:42 PM, Mark Brown wrote:
> On Tue, Aug 08, 2017 at 02:56:46PM +0100, Hans de Goede wrote:
>> Hi,
> 
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.

Sorry, that was unintentional I probably accidentally hit reply instead
of reply-to-all.

I've re-added the lists to the Cc.

>> On 08/08/2017 10:39 AM, Mark Brown wrote:
>>> On Mon, Aug 07, 2017 at 09:20:05PM +0200, Hans de Goede wrote:
> 
>>> Why not?  This is just really standard usage of platform data.
> 
>> Right, but in general in most cases we are trying to get rid of
>> platform data (where possible). So introducing new platform_data
>> is not going to be popular, but I agree that it likely is the
>> best solution here.
> 
> No, we aren't.  The majority of architectures are still platform data
> only and x86 as you're finding uses it extensively along with ACPI.

Ok.

>>>> Alternatively the entry could additionally contain a provider_supply_name
>>>> so that we can make arbitrary consumer-dev-name + consumer-supply-name
>>>> provider-dev-name + provider-supply-name matches. That would probably
>>>> be more flexible then requiring the supply name to match.
> 
>>> I'm sorry but I can't follow what you mean here.  What do you mean by
>>> "provider_supply_name"?
> 
>> The current "const char *supply" in regulator_map is the supply name
>> passed to regulator_get, so the rdev_get_name requested by the consumer
>> (assuming no mapping is in place)
> 
> The name on the parent is *NOT* something anything else should
> reference, it's just some internal documentation intended exclusively
> for human consmption and can be overridden by the platforms.  It should
> never be referenced by anything outside the device.
> 
>> One regulator parent-device can register multiple regulator names, iow
>> multiple supplies, basically what I want to do is have the map
>> (when not using the regulator pointer) match the following 2 pairs:
> 
>> dev_name + supply
> 
>> regulator_parent_dev_name + rdev_get_name
> 
> Have your platform register identifiers that are useful within your
> platform, don't rely on the drivers.

Ok, I need to think a bit about this. I think I've enough info to
come up with a new patch-set not introducing the fcs,vbus-regulator-name
device-property ugliness. But this is a side project and I'm rather busy with $dayjob
atm, so it may take a while for me to come up with a new patch.

Regards,

Hans
