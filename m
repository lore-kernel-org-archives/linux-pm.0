From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Fri, 8 Jan 2016 08:28:15 +0100
Message-ID: <CAAObsKDZ07i-gMiGr2t1+H2k80n+=r0mKbavt5-ZhMmqxT1WaA@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <20151030225242.GA2480@kroah.com>
 <CAAObsKCBRPLDLztJE4up45KWB+T86td7-wuskBN-iaEdvnacDA@mail.gmail.com> <20160107212924.GA3899@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107212924.GA3899@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 7 January 2016 at 22:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jan 07, 2016 at 03:55:43PM +0100, Tomeu Vizoso wrote:
>> On 30 October 2015 at 23:52, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
>> >> My idea is to represent a supplier-consumer dependency between devices (or
>> >> more precisely between device+driver combos) as a "link" object containing
>> >> pointers to the devices in question, a list node for each of them and some
>> >> additional information related to the management of those objects, ie.
>> >> something like:
>> >>
>> >> struct device_link {
>> >>       struct device *supplier;
>> >>       struct list_head supplier_node;
>> >>       struct device *consumer;
>> >>       struct list_head consumer_node;
>> >>       <flags, status etc>
>> >> };
>> >>
>> >> In general, there will be two lists of those things per device, one list
>> >> of links to consumers and one list of links to suppliers.
>> >>
>> >> In that picture, links will be created by calling, say:
>> >>
>> >> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);
>> >
>> > At first glance, I like this, nice.  Now to see how well it can be
>> > implemented :)
>>
>> Hi Greg,
>>
>> what's your opinion on using this to order device probes so we don't
>> try to probe a device that we know it has unfulfilled dependencies?
>
> Why would that matter, unless you can prove it's faster, I wouldn't
> bother.

I gave you the bootlog you asked in the post below, could you please
comment there?

https://lkml.kernel.org/g/562A280A.3040002@collabora.com

Thanks,

Tomeu
