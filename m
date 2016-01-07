From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 7 Jan 2016 15:55:43 +0100
Message-ID: <CAAObsKCBRPLDLztJE4up45KWB+T86td7-wuskBN-iaEdvnacDA@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <20151030225242.GA2480@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38357 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcAGO4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 09:56:04 -0500
In-Reply-To: <20151030225242.GA2480@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On 30 October 2015 at 23:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
>> My idea is to represent a supplier-consumer dependency between devices (or
>> more precisely between device+driver combos) as a "link" object containing
>> pointers to the devices in question, a list node for each of them and some
>> additional information related to the management of those objects, ie.
>> something like:
>>
>> struct device_link {
>>       struct device *supplier;
>>       struct list_head supplier_node;
>>       struct device *consumer;
>>       struct list_head consumer_node;
>>       <flags, status etc>
>> };
>>
>> In general, there will be two lists of those things per device, one list
>> of links to consumers and one list of links to suppliers.
>>
>> In that picture, links will be created by calling, say:
>>
>> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);
>
> At first glance, I like this, nice.  Now to see how well it can be
> implemented :)

Hi Greg,

what's your opinion on using this to order device probes so we don't
try to probe a device that we know it has unfulfilled dependencies?

Regards,

Tomeu
