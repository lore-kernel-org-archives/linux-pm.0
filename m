From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: question: concerning disabling suspend of individual devices
Date: Tue, 9 Jan 2018 23:08:30 +0100
Message-ID: <CAJZ5v0j-mzNZvgnToiyGt7CuumF1_Ap_1QQ30W+YLbuXPCkDiw@mail.gmail.com>
References: <CAFY_6qoHuBUJ=SqWGKLb=QRm+RqQ0sY_LYiT4h-5Yi1HXz=LZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:34780 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbeAIWIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 17:08:31 -0500
Received: by mail-ot0-f175.google.com with SMTP id p16so10027213otf.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 14:08:30 -0800 (PST)
In-Reply-To: <CAFY_6qoHuBUJ=SqWGKLb=QRm+RqQ0sY_LYiT4h-5Yi1HXz=LZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Samuel Morris <samorris@lexmark.com>
Cc: Linux PM <linux-pm@vger.kernel.org>

On Tue, Jan 9, 2018 at 10:28 PM, Samuel Morris <samorris@lexmark.com> wrote:
> Hello,
>
> Unless I am mistaken, there does not seem to be a way to disable system suspend
> of an individual device, either through sysfs or a probe time config.

The only way you could do that would be for the device to fail one of
its callbacks, but that would abort the entire suspend transition of
the system.

> I've encountered cases in the past where either the suspend behavior of a device is
> buggy, or functionally it just does not do what I want. For example, I had an
> led I wanted to keep on during system suspend.

That may ot may not be doable depending on the configuration of the
whole platform.

The whole idea of system suspend is that everything suspends and
devices depend on each other in general, so it may not be possible to
avoid suspending just one of them.

But it seems that what you really would like to do is to be able to
say that power should be provided to the device while suspended (which
is different from disabling suspend).

> Nearly all LED class devices turn
> off during suspend, and offer userspace no method of preventing that. This
> doesn't seem like a quality of service thing,

But it may be regarded as such.

We have a PM QoS flag for similar things which currently is used for
runtime PM only, but in principle it may also be used during
system-wide transitions.  It is called PM_QOS_FLAG_NO_POWER_OFF.

> the led just does not have the
> suspend behavior I want. I am in the process of making that particular case
> configurable, but why not just add the option to disable suspend for each
> individual device as with runtime_pm?

I'm afraid that that can't work the way you seem to be wanting it to work.

>  Would this be a worthwhile feature to work on?

Not really.

I'd rather think about maybe using PM_QOS_FLAG_NO_POWER_OFF.

Thanks,
Rafael
