From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Fri, 2 Oct 2015 10:40:49 +0200
Message-ID: <CAPDyKFrDO37Tuy3QosWXxogG2WSrwr79yxr_894TvWk6EO7T8w@mail.gmail.com>
References: <1443770071-2570-1-git-send-email-tomeu.vizoso@collabora.com>
	<1443770071-2570-4-git-send-email-tomeu.vizoso@collabora.com>
	<CAPDyKFo_tqf_ism-YYNw2L7Wp=EnqztbggU52aX_Azwn4OJLMg@mail.gmail.com>
	<CAAObsKBM2tto0cFAu-pyvatGQevB6ynvuuSNghHNQGQSgfLzdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35786 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbJBIku (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 04:40:50 -0400
Received: by wicge5 with SMTP id ge5so22894354wic.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2015 01:40:49 -0700 (PDT)
In-Reply-To: <CAAObsKBM2tto0cFAu-pyvatGQevB6ynvuuSNghHNQGQSgfLzdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On 2 October 2015 at 10:10, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 2 October 2015 at 09:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 2 October 2015 at 09:14, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>> If a suitable prepare callback cannot be found for a given device and
>>> its driver has no PM callbacks at all, assume that it can go direct to
>>> complete when the system goes to sleep.
>>>
>>> The reason for this is that there's lots of devices in a system that do
>>> no PM at all and there's no reason for them to prevent their ancestors
>>> to do direct_complete if they can support it.
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> ---
>>>
>>> Changes in v8:
>>> - Move no_pm_callbacks field into CONFIG_PM_SLEEP
>>> - Call device_check_pm_callbacks only after a device is bound or unbound
>>
>> Devices that don't use a driver, will not get this feature for "free".
>> I expect in those cases, they will have to call
>> device_check_pm_callbacks() themselves, right?
>
> You are right, but wonder if we shouldn't go back to calling
> device_check_pm_callbacks() from device_pm_add() and
> dev_pm_domain_set() so they don't have to.

That seems reasonable to me, and I didn't quite understand why you
decided to remove it. :-)

Kind regards
Uffe

[...]
