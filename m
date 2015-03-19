From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] driver core / PM: Add callbacks for PM domain initialization/cleanup
Date: Thu, 19 Mar 2015 15:45:07 +0100
Message-ID: <CAPDyKFqmSoKEfbtowk1h0USf4LcJvH1qVYgqkh7VFc7iekyaNQ@mail.gmail.com>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1503191017590.1135-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36237 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbbCSOpJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 10:45:09 -0400
Received: by qcto4 with SMTP id o4so67846851qct.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 07:45:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1503191017590.1135-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 March 2015 at 15:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 19 Mar 2015, Rafael J. Wysocki wrote:
>
>> > This doesn't make sense to me.  A bus just called bus_add_device, it can
>> > do whatever it wanted to right before calling this function, no need for
>> > another callback.
>>
>> The only caller of bus_add_device() is device_add().
>>
>> What do you mean by "bus just called bus_add_device"?  Do you think that
>> the pm_domain pointer should be populated before calling device_add()?
>>
>> That wouldn't work for the ACPI PM domain at least, because ACPI companions
>> are generally added during device_add() and we arguably cannot point a
>> device to the ACPI PM domain before its ACPI companion is set.
>
>
>> There are two alternatives to them.  One is to do PM domain attach/detach in
>> the bus type's ->probe and ->remove, but that's suboptimal, because it is
>> then carried out every time a driver is probed/removed for a device.  The
>> other one would be to have each interested bus type register a bus type
>> notifier for itself, but that would be rather ugly, wouldn't it?
>
> Driver probing and removal is not a hot path.  Successful probes
> usually occur only once for each device.  I don't know how many
> unsuccessful probes there are on average, but probably not many.
>
> Doing the PM domain attach/detach in ->probe and ->remove makes sense
> to me.

Let me elaborate a bit on the current approach, with PM domain
attach/detach in ->probe() and ->remove(). This comes with the
following limitations.

1) If the device gets probed earlier than the PM domain has been
initialized, we can't return -EPROBE_DEFER since we just don't know
anything about the PM domain yet.

2) The PM domain won't be able to operate on a device without having a
driver bound to it, since the device's PM domain pointer is removed at
->remove().

Perhaps Rafael want to add something to these? I don't know whether we
think it's okay to keep these limitations or not.

Kind regards
Uffe
