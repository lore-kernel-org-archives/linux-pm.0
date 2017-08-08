From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 13/18] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Tue, 8 Aug 2017 23:09:13 +0200
Message-ID: <879cc928-de30-5e3e-954a-8b9bd97638e1@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-14-hdegoede@redhat.com>
 <CAKvHMgRJ4CVn43BnsB1odx_B3QvfFMMqeT3BrrwVtteXFszyAQ@mail.gmail.com>
 <ddee22bd-7f0e-6065-8936-ce9a7e2f7a02@redhat.com>
 <CAKvHMgThHhO6S_6cfu1RWoNG5g43taUpGpPkgMsXcf42HDscDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAKvHMgThHhO6S_6cfu1RWoNG5g43taUpGpPkgMsXcf42HDscDQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Liam Breck <liam@networkimprov.net>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 08/08/2017 08:57 PM, Liam Breck wrote:
> On Tue, Aug 8, 2017 at 2:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 08-08-17 10:39, Liam Breck wrote:
>>>
>>> Hi Hans,
>>>
>>> On Sun, Aug 6, 2017 at 5:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Register the 5V boost converter as a regulator named
>>>> "regulator-bq24190-usb-vbus". Note the name includes "bq24190" because
>>>> the bq24190 family is also used on ACPI devices where there are no
>>>> device-tree phandles, so regulator_get will fallback to the name and thus
>>>> it must be unique on the system.
>>>
>>>
>>> What we're enabling here is 5V boost for otg host mode, not vbus
>>> generally, so maybe the name should indicate that...
>>>
>>> regulator-bq24190-usb-5volt
>>> regulator-bq24190-usb-host
>>> regulator-bq24190-usb-otg-5v
>>
>>
>> I picked vbus because that gets used a lot already in similar cases,
>> but I agree that we should probably come up with a better name.
>>
>> I like "regulator-bq24190-usb-otg-5v", shall I use that for v2?
> 
> There is this upstream, with "otg-vbus":
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=61274eff0ddee8f10deaa5f79085e981db52930a
> 
> Related search:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/?qt=grep&q=otg+regulator
> 
> I don't think it needs a "regulator-" prefix, and maybe the driver
> name is a suffix. We could also recommend the "regulator-name" value
> for OTG here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/Documentation/devicetree/bindings/regulator/regulator.txt
> 
> a. Make the above patch wrong :-)
> usb-otg-5v (generic)
> usb-otg-5v-bq2419x (specific)
> 
> b. Follow a weak precedent
> otg-vbus (generic)
> otg-vbus-bq2419x (specific)

Looking at dts files under arch/arm/boot/dts the most used name seems to be
usb_otg_vbus (with underscores) so I will use that for v2 of this patch.

As for making the name more specific, as Mark Brown has correctly pointed
out the right thing to do on x86 is to add a mapping for the consumer of the
regulator using regulator_init_data, which can be passed through platform_data
(and I do control the i2c_client instantiation on x86, so adding that is easy),
which means that we can keep the name generic, which is a much better solution
then relying on the name. This means that we can keep the name generic as
one normally does for a regulator-name.

Regards,

Hans
