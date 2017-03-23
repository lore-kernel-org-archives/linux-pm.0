From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Thu, 23 Mar 2017 12:05:37 -0700
Message-ID: <CAKvHMgQCq0zBeYXHL9hkbvtndEbrNocPzuPeRcPfKEON0+W4zA@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth> <CAKvHMgS4oRCYRRgqo8GbeYxC5uhwgLPqe2j3ZBHQJMDBRYeA_w@mail.gmail.com>
 <20170323133729.jexsnpwrmbxswn26@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33486 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdCWTFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 15:05:39 -0400
Received: by mail-io0-f173.google.com with SMTP id f84so3573968ioj.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 12:05:39 -0700 (PDT)
In-Reply-To: <20170323133729.jexsnpwrmbxswn26@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Thu, Mar 23, 2017 at 6:37 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Thu, Mar 23, 2017 at 04:31:50AM -0700, Liam Breck wrote:
>>> That still leaves the health status reading, though. From
>>> userspace's point-of-view this should be merged into the
>>> battery device, if fuel-gauge can't provide that information.
>>
>> I think the bigger issue is that multiple sysfs devices for what is
>> conceptually one power supply is awkward. With the addition of static
>> battery object, we have yet another set of properties which belong to
>> that supply.
>
> The simple-battery is consumed by the fuel-gauge, so not a problem.
>
>> A solution to this would be a core registry which allows various
>> drivers to submit properties to a named supply. Properties with the
>> same id (e.g. health) are OK given a tag (input-V, NTC-1, battery-V)
>> to differentiate them. Duplicates would be dropped (e.g. both drivers
>> submit monitored-battery stats). The result would be represented in
>> sysfs as a single device, where each property would appear as a file
>> or directory as necessary. And perhaps also as a file "health_summary"
>> which indicates whether there's trouble below decks.
>
> Yes, that would be the proper solution. Might become important, if
> more platforms with multiple chips providing battery information
> appear. Since I don't think you want to implement your suggestion,

If you're genuinely interested, I could probably ask Matt to work on this...

> I suggest sticking to the custom "bat_fault" sysfs property. That
> should already be exposed for the charger device as far as I can
> see.
