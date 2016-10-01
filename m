From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/5] driver core: Functional dependencies tracking support
Date: Sun, 2 Oct 2016 01:32:35 +0200
Message-ID: <CAJZ5v0i6LsnCKcgqaPKLyVp9v5ndAZhqAqDXfMqyXZsztZfS_A@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <10860219.QqH5akBVoh@vostro.rjw.lan>
 <1985903.oaAlgI6mU5@vostro.rjw.lan> <20161001074346.GA7215@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35113 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbcJAXci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Oct 2016 19:32:38 -0400
In-Reply-To: <20161001074346.GA7215@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Sat, Oct 1, 2016 at 9:43 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Sep 29, 2016 at 02:38:04AM +0200, Rafael J. Wysocki wrote:
>> +static int device_reorder_to_tail(struct device *dev, void *not_used)
>> +{
>> +     struct device_link *link;
>> +
>> +     /*
>> +      * Devices that have not been registered yet will be put to the ends
>> +      * of the lists during the registratio, so skip them here.
>                                               ^
>                                               n
>
>> +     if (device_is_registered(dev))
>> +             devices_kset_move_last(dev);
>> +
>> +     if (device_pm_initialized(dev))
>> +             device_pm_move_last(dev);
>
> Clever solution to this problem.  So little code!
>
>
>> +/**
>> + * device_links_check_suppliers - Check presence of supplier drivers.
>> + * @dev: Consumer device.
>> + *
>> + * Check links from this device to any suppliers.  Walk the list of the device's
>> + * consumer links and see if all of the suppliers are available.  If not, simply
>       ^^^^^^^^
>      "supplier links and see if all if them are available."
>
>
>> +/*
>> + * Device link flags.
>> + *
>> + * STATELESS: The core won't track the presence of supplier/consumer drivers.
>> + * AUTOREMOVE: Remove this link automatically on cunsumer driver unbind.
>                                                      ^
>                                                      o
>
>
> Apart from these nits patch [2/5] LGTM, so FWIW:
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks for the review, much appreciated!

Cheers,
Rafael
