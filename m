From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 3/7] PM / sleep: Make async suspend/resume of
 devices use device links
Date: Sun, 11 Sep 2016 00:12:30 +0200
Message-ID: <CAJZ5v0g2GxrsgtsBq8XmNSk-HrjYPAVtHgnFfJ9-jWFKaHY27g@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <7606779.dc8E4l7vTo@vostro.rjw.lan>
 <20160910133145.GA29744@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33966 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbcIJWMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 18:12:33 -0400
In-Reply-To: <20160910133145.GA29744@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Sat, Sep 10, 2016 at 3:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Sep 08, 2016 at 11:28:33PM +0200, Rafael J. Wysocki wrote:
>> Make the device suspend/resume part of the core system
>> suspend/resume code use device links to ensure that supplier
>> and consumer devices will be suspended and resumed in the right
>> order in case of async suspend/resume.
>>
>> The idea, roughly, is to use dpm_wait() to wait for all consumers
>> before a supplier device suspend and to wait for all suppliers
>> before a consumer device resume.
>
> For devices with a parent/child relationship, if the child does not
> utilize direct_complete, the parent is not allowed to utilize it
> either and is runtime resumed upon system sleep.
>
> Don't we need the same for supplier/consumer relationships?
>
> The code enforcing this is in __device_suspend() and looks like this:
>
>         if (parent) {
>                 spin_lock_irq(&parent->power.lock);
>
>                 dev->parent->power.direct_complete = false;
>                 if (dev->power.wakeup_path
>                     && !dev->parent->power.ignore_children)
>                         dev->parent->power.wakeup_path = true;
>
>                 spin_unlock_irq(&parent->power.lock);
>         }
>
> I guess we need to iterate over the suppliers here and execute
> the block for each of them.

You are right about the direct_complete thing, but the wakeup_path
thing is another matter.  It is about forwarding wakeup signals up the
hierarchy and I'd confine it to parents at least for the time being.

Thanks,
Rafael
