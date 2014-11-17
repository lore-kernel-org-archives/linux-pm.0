From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 11:17:55 -0800
Message-ID: <20141117191755.GA5258@dtor-ws>
References: <7hd28l3clz.fsf@deeprootsystems.com>
 <Pine.LNX.4.44L0.1411171400540.885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:63841 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaKQTSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 14:18:00 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411171400540.885-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>



On Mon, Nov 17, 2014 at 11:06 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 17 Nov 2014, Kevin Hilman wrote:
>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > The amba bus, amba drivers and a vast amount of platform drivers which
>> > enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
>> > their devices.
>> >
>> > Instead, once they have turned on their PM resourses during ->probe()
>> > and are ready to handle I/O, these invokes pm_runtime_set_active() to
>> > synchronize its state towards the runtime PM core.
>> >
>> > From a runtime PM point of view this behavior is perfectly acceptable,
>>
>> In the context of PM domains that can be dynamically powered on/off, I'm
>> not so sure it's perfectly acceptable anymore.
>>
>> Why doesn't the bus do a _get_sync() instead of a _get_noresume()
>> followed by a _set_active().
>>
>> By using the _get_noresume() you're bypassing the paths that would bring
>> up your PM domain.
>
> This probably comes about because devices that are part of a power
> domain need special treatment.  Before the driver's probe routine gets
> called, the bus ought to resume the entire power domain.  For that,
> some sort of _get_sync() is needed.
>
> For devices that aren't part of a power domain, things are simpler.
> The bus does _get_noresume() to make sure the device won't be runtime
> suspended while the probe routine is running.  It doesn't do
> _get_sync(), because that would end up calling the driver's
> runtime_resume routine before the driver was bound to the device.  (The
> bus could prevent that from happening by taking special precautions,
> like PCI does, but in general it's a nuisance.)

That's why I think we need some new call that would mean "make sure the
device is powered" which would properly handle power domain and bus, but
ignore all driver stuff since it may not be initialized yet. And similar
call for asking to put device and maybe domain in powered down state in
case probing failed.

Thanks.

-- 
Dmitry
