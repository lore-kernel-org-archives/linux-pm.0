From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Something like devm_pm_runtime_enable desirable?
Date: Tue, 28 Nov 2017 22:12:24 +0100
Message-ID: <56506e45-c19f-66c8-0e4b-4d82afbace7a@gmail.com>
References: <66504d0c-1b30-8b36-fd11-bd9abc2eb41a@gmail.com>
 <CAJZ5v0g_vg+ojdZs7fNwyPF3RVOMWW0aHB9jDKTV0nt5ivP7_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:46184 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdK1VMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Nov 2017 16:12:34 -0500
Received: by mail-wm0-f49.google.com with SMTP id r78so2214169wme.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2017 13:12:34 -0800 (PST)
In-Reply-To: <CAJZ5v0g_vg+ojdZs7fNwyPF3RVOMWW0aHB9jDKTV0nt5ivP7_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

Am 27.11.2017 um 02:21 schrieb Rafael J. Wysocki:
> On Mon, Nov 27, 2017 at 12:13 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> I have a runtime pm enabled driver which uses device-managed resources
>> only and therefore wouldn't need a remove callback. The remove callback
>> does pm_runtime_disable only.
>> Therefore I'm wondering whether something like devm_pm_runtime_enable
>> would be desirable doing the pm_runtime_disable automagically.
>>
>> I can't really imagine that I'm the first one with this idea so I
>> guess there is some reason why it doesn't exist yet ..
> 
> You also need to ensure that the device is left in the state in which
> your driver will expect it to be in on the next probe in case the
> driver module is unloaded and loaded again.  I'm not sure if devm_ can
> do that generically enough.
> 
Sure, the device state needs to be managed properly. I just see that lots
of drivers which have the reversed rpm calls in their probe error path and
in remove, what in several cases could be simplified by using the devm
mechanism.
I see this at least for the following function pairs:
pm_runtime_enable -> pm_runtime_disable
pm_runtime_use_autosuspend -> pm_runtime_dont_use_autosuspend

One example would be drivers/i2c/busses/i2c-omap.c, with some IMO
uncritical reordering of rpm calls.

> Thanks,
> Rafael
> 
Rgds, Heiner
