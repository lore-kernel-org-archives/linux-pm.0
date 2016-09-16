From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v3 2/5] driver core: Functional dependencies
 tracking support
Date: Fri, 16 Sep 2016 14:06:02 +0200
Message-ID: <CAJZ5v0hmemva3nTHkJRhtiRBCZcN6uCTTF54hTh=_fEposh4ow@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <5257325.y9rG1UM74b@vostro.rjw.lan>
 <CGME20160915220219eucas1p20837df39f0b5248ce27d5fd769604ccd@eucas1p2.samsung.com>
 <2480829.3iNV7K5Pdo@vostro.rjw.lan> <d0780710-9c73-e7d6-7ac3-41d979477fe6@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34230 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756939AbcIPMGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 08:06:04 -0400
In-Reply-To: <d0780710-9c73-e7d6-7ac3-41d979477fe6@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Fri, Sep 16, 2016 at 9:53 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Rafael,
>
>
> On 2016-09-16 00:06, Rafael J. Wysocki wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>

[cut]

>> +/**
>> + * device_links_no_driver - Update links of a device without a driver.
>> + * @dev: Device without a drvier.
>> + *
>> + * Delete all non-persistent links from this device to any suppliers.
>> + *
>> + * Persistent links stay around, but their status is changed to
>> "available",
>> + * unless they already are in the "supplier unbind in progress" state in
>> which
>> + * case they need not be updated.
>> + *
>> + * Links with the DEVICE_LINK_STATELESS flag set are ignored.
>> + */
>> +void device_links_no_driver(struct device *dev)
>> +{
>> +       struct device_link *link, *ln;
>> +
>> +       mutex_lock(&device_links_lock);
>> +
>> +       list_for_each_entry_safe_reverse(link, ln,
>> &dev->links_to_suppliers, c_node)
>
>
> missing "{"
>
>> +               if (link->flags & DEVICE_LINK_STATELESS)
>> +                       continue;
>> +
>> +               if (link->flags & DEVICE_LINK_AUTOREMOVE) {
>> +                       __device_link_del(link);
>> +               } else {
>> +                       spin_lock(&link->lock);
>> +
>> +                       if (link->status != DEVICE_LINK_SUPPLIER_UNBIND)
>> +                               link->status = DEVICE_LINK_AVAILABLE;
>> +
>> +                       spin_unlock(&link->lock);
>> +               }
>
>
> missing "}"
>

Sorry for the breakage and thanks for the fix!

Rafael
