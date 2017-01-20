From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 20 Jan 2017 08:54:07 +0100
Message-ID: <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170120041400.GA24617-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 20.01.2017, at 05:14, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> Hello Martin,
> 
> On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> Add basic thermal driver for bcm2835 SOC.
>> 
>> This driver currently relies on the firmware setting up the
>> tsense HW block and does not set it up itself.
>> 
>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>> 
> 
> <cut>
> 
>> +
>> +static const struct of_device_id bcm2835_thermal_of_match_table[] = {
>> +	{
>> +		.compatible = "brcm,bcm2835-thermal",
>> +		.data = &(struct bcm2835_thermal_info) {
>> +			.offset = 407000,
>> +			.slope = -538,
>> +			.trip_temp = 80000
>> +		}
>> +	},
>> +	{
>> +		.compatible = "brcm,bcm2836-thermal",
>> +		.data = &(struct bcm2835_thermal_info) {
>> +			.offset = 407000,
>> +			.slope = -538,
>> +			.trip_temp = 80000
>> +		}
>> +	},
>> +	{
>> +		.compatible = "brcm,bcm2837-thermal",
>> +		.data = &(struct bcm2835_thermal_info) {
>> +			/* the bcm2837 needs adjustment of +5C */
>> +			.offset = 407000 + 5000,
>> +			.slope = -538,
>> +			.trip_temp = 80000
>> +		}
>> +	},
>> +	{},
> 
> Just for the same of clarification, is there anything preventing this
> driver of using of-thermal API? the above data (slope, offset, and
> trip_temps) would be in DT the place where they are supposed to be,
> instead of code.
> 

As the DT changes, that only define compatible strings, have already gone
in without any such properties set, we need to define defaults for the 
slope/offset and trip_temp values.

I guess (for newer SOC) you still can use the values in the DT,
as (I guess) these are parsed and set in thermal_zone_device_register
after the defaults are set in thermal_zone_params.

Martin
