From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH v2 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Date: Fri, 1 Jun 2018 18:08:01 -0400
Message-ID: <10b558c4-9734-061f-c6ed-5b1288d1f23f@nvidia.com>
References: <20180601172400.50737-1-briannorris@chromium.org>
 <20180601173434.GA22509@roeck-us.net>
 <20180601183126.GA72050@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601183126.GA72050@rodete-desktop-imager.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Alexandru Stan <amstan@chromium.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 6/1/2018 2:31 PM, Brian Norris wrote:
> Hi,
> 
> On Fri, Jun 01, 2018 at 10:34:34AM -0700, Guenter Roeck wrote:
>> On Fri, Jun 01, 2018 at 10:23:59AM -0700, Brian Norris wrote:
>>>  drivers/power/supply/sbs-battery.c | 54 +++++++++++++++++++++++++-----
>>>  1 file changed, 46 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
>>> index 83d7b4115857..8dea63464a3f 100644
>>> --- a/drivers/power/supply/sbs-battery.c
>>> +++ b/drivers/power/supply/sbs-battery.c
> ...
> 
>>> @@ -315,6 +320,27 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
>>>  static int sbs_get_battery_presence_and_health(
>>>  	struct i2c_client *client, enum power_supply_property psp,
>>>  	union power_supply_propval *val)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (psp == POWER_SUPPLY_PROP_PRESENT) {
>>> +		/* Dummy command; if it succeeds, battery is present. */
>>> +		ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
>>> +		if (ret < 0)
>>> +			val->intval = 0; /* battery disconnected */
>>> +		else
>>> +			val->intval = 1; /* battery present */
>>> +		return 0;
>>> +	} else { /* POWER_SUPPLY_PROP_HEALTH */
>>
>> Static analyzers may complain that else after return is unnecessary.
> 
> I noticed (checkpatch complains) but decided I didn't care. It would be
> worse to promote the 'else' to top-level (things would look asymmetric).
> I suppose I could pull the 'return 0' out, but I'm not sure that would
> make the code any better.

I generally prefer to make checkpatch happy, so I would vote to move the
return outside of the if blocks as a minimal way of making it happy. In
general though,

Acked-by: Rhyland Klein <rklein@nvidia.com>

> 
>> Other than that
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>>> +		/* SBS spec doesn't have a general health command. */
>>> +		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
>>> +		return 0;
>>> +	}
>>> +}
>>> +
> 
> Brian
> 


-- 
nvpublic
