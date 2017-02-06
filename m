From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3 v2] PM / docs: linux/pm.h kerneldocs update and
 conversion of two docs to reST
Date: Mon, 6 Feb 2017 22:08:44 +0100
Message-ID: <CAJZ5v0jvNSomZ=O0trPG7eJpv0XyMh1dU9noRU0ZKycJjtXK4g@mail.gmail.com>
References: <1741856.1gu5vXgsff@aspire.rjw.lan> <20170206112818.3694cf04@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34033 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdBFVIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 16:08:46 -0500
In-Reply-To: <20170206112818.3694cf04@lwn.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lukas Wunner <lukas@wunner.de>, Alan Stern <stern@rowland.harvard.edu>

On Mon, Feb 6, 2017 at 7:28 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu, 02 Feb 2017 01:30:08 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
>> This is a new (and hopefully final) iteration of the series of patches starting
>> the conversion of power management driver API documentation.
>>
>> Patch [1/3] updates kerneldoc comments in include/linux/pm.h (to make the
>> documentation generated out of them look better), patch [2/3] converts
>> Documentation/power/devices.txt to reST, and patch [3/3] does the same thing
>> to Documentation/power/notifiers.txt (the new files go into the driver-api subdir
>> and are hooked up to that manual).
>>
>> Patch [1/3] has not been changed since the previous iteration.  Patch [2/3]
>> addresses some comments from Lukas and patch [3/3] has been trivially
>> rebased.
>>
>> Please apply unless there are any objections.
>
> Just applied them, thanks.

Thank you!

> One thing I do notice is that, while you update the kerneldoc comments,
> nothing in the associated documentation pulls them in.  That would be a
> good future enhancement...:)

They are pulled in by patch [2/3] via types.rst (AFAICS).

I guess that's a bit confusing (sorry about that), but I wanted to
avoid putting too much stuff into one patch.

Thanks,
Rafael
