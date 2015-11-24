From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 24 Nov 2015 14:56:45 +0100
Message-ID: <56546C9D.3090206@samsung.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <564B224D.3050904@samsung.com>
 <20151117135549.GR31303@sirena.org.uk> <564D7145.40300@samsung.com>
 <20151121140428.GJ26072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151121140428.GJ26072@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 11/21/2015 03:04 PM, Mark Brown wrote:
> On Thu, Nov 19, 2015 at 07:50:45AM +0100, Andrzej Hajda wrote:
>> On 11/17/2015 02:55 PM, Mark Brown wrote:
>>> This is going to be really common but I'm not sure I see a problem with
>>> it in terms of what Raphael is proposing - could you go into more detail
>>> on the problem you see here?
>> If clock provider is not a device driver and it depends on clocks of
>> another clock
>> provider you cannot 'translate' this dependency as dependency between
>> devices,
> What makes you say that this is the case?  There should be nothing
> stopping us having dependencies between two devices of the same type.

To be clear I described situation that one clock provider uses clock
of another clock provider and consumer is not modeled as device.


>
>> so this RFD does not cover them.
>> Additionally if you look into kernel there are many calls in form
>> 'clk_get(NULL, name)',
>> it suggests that not only clock providers are consumers without
>> underlying device driver.
> Like I said in my earlier reply:
>
> | > - many clock providers, irq domains are not provided by devices,
>
> | That seems like something we can and possibly should change if we want.
>
> This applies just as much to consumers as to providers.

OK, then it is just something to do :)

Regards
Andrzej
