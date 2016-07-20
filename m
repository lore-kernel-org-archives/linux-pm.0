From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
Date: Wed, 20 Jul 2016 11:38:03 -0700
Message-ID: <20160720183803.GB19216@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
 <d83c43cc-dfa3-684d-9315-e1eec5cd79fe@kernel.org>
 <5782EEBB.1040209@roeck-us.net>
 <af94ec36-b77d-96f8-ff15-2cfbbe89c3fa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36200 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcGTSiH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2016 14:38:07 -0400
Content-Disposition: inline
In-Reply-To: <af94ec36-b77d-96f8-ff15-2cfbbe89c3fa@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 20, 2016 at 04:11:04PM +0100, Jonathan Cameron wrote:
> On 11/07/16 01:56, Guenter Roeck wrote:
> > Hi Jonathan,
> > 
> > On 07/10/2016 09:00 AM, Jonathan Cameron wrote:
> >> On 26/06/16 04:26, Guenter Roeck wrote:
> >>> Up to now, each hwmon driver has to implement its own sysfs attributes.
> >>> This requires a lot of template code, and distracts from the driver's
> >>> core function to read and write chip registers.
> >>>
> >>> To be able to reduce driver complexity, move sensor attribute handling
> >>> and thermal zone registration into the hwmon core. By using the new API,
> >>> driver size is typically reduced by 20-50% depending on driver complexity
> >>> and the number of sysfs attributes supported.
> >>>
> >>> The first patch of the series introduces the API as well as support
> >>> for temperature sensors. Subsequent patches introduce support for
> >>> voltage, current, power, energy, humidity, and fan speed sensors.
> >>>
> >>> The series was tested by converting several drivers (lm75, lm90, tmp102,
> >>> tmp421, ltc4245) to the new API. Testing was done with with real chips
> >>> as well as with the hwmon driver module test code available at
> >>> https://github.com/groeck/module-tests.
> >> Some cool stuff hiding in there :)
> >>
> >> I've only reviewed 1 and 7 and the intermediate ones are really either
> >> correct or they aren't and they look fine to me.
> >>
> > Thanks a lot for your feedback - it is reassuring that it looks sane to you.
> > 
> >>
> >> So what's next? (beyond presumably a lot of driver conversions).
> >>
> > Next steps will be to address your comments, re-test, submit a new series,
> > add to -next after v4.8-rc1 is out, submit the conversions I have done
> > and add to -next. Then, obviously, only accept new drivers using the
> > new API.
> > 
> > Not sure if there is anything else we can or want to do do at this time.
> > Do you have anything in mind ?
> > 
> Was wondering about the bridge to IIO (reverse of iio to hwmon bridge)
> that you mentioned - for that you'd probably need some in kernel interfaces
> for all this stuff.
> 

Depends; maybe it would be sufficient to call devm_iio_device_register() with
a minimum set of channel information. Looks like all we would need is .read_raw
and .write_raw callbacks in struct iio_info, a channel description for each
channel, and the number of channels. Implementing this would not be difficult.
Only question would be if it would be sufficient for most or at least many
use cases.

Thanks,
Guenter
