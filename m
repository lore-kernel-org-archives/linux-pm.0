From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
Date: Tue, 16 Apr 2019 10:42:30 +0200
Message-ID: <8d1f70a7-46d6-f278-f58c-6a7e7a644d46@collabora.com>
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
 <20190416071941.GB14538@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416071941.GB14538@amd>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, Sameer Nanda <snanda@chromium.org>, bleung@chromium.org, rjw@rjwysocki.net, gwendal@chromium.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On 16/4/19 9:19, Pavel Machek wrote:
> Hi!
> 
>> This patch exposes a new property, similar to input current limit, to
>> re-configure the maximum voltage from the external supply at runtime
>> based on system-level knowledge or user input.
> 
> Well, and I suspect it should expose input power limit, not input
> voltage limit.
> 

Oh, ok, I thought we were agree that input voltage had sense after had some
discussion in v3. Seems that no, let me try to give you another example...

> DC-DC convertor efficiency normally does not much depend on input
> voltage....
> 
> 								Pavel
> 

As we said we have a heat "problem" due the internal voltage conversions.

Lets assume you have a linear regulator instead with a Vin range from 5V to 9V
and we want an output of 3.3V/1A

For 9V:
 Input power : P(in) = 9V x 1A = 9W
 Output power: P(out) = 3.3V x 1A = 3.3W
 Regulator power dissipated: P(reg) = P(in) - P(out) = 9W - 3.3W = 5.7W

For 5V:
 Input power : P(in) = 5V x 1A = 5W
 Output power: P(out) = 3.3V x 1A = 3.3W
 Regulator power dissipated: P(reg) = P(in) - P(out) = 5W - 3.3W = 1,7W

In the first case the regulator needs to dissipate more power, hence the
temperature is greater than the second case.

Thanks,
 Enric
