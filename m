From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v3] USB: Force disconnect Huawei 4G modem during suspend
Date: Tue, 24 Oct 2017 12:16:04 +0800
Message-ID: <CAD8Lp47eCDkYX8gOQx2YYnt_hubqkmMjZ5U75t9gPSy6B=5MDw@mail.gmail.com>
References: <20171018071501.4900-1-drake@endlessm.com> <1508319080.8211.2.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:53031 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdJXEQF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2017 00:16:05 -0400
Received: by mail-oi0-f47.google.com with SMTP id c202so34665817oih.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2017 21:16:05 -0700 (PDT)
In-Reply-To: <1508319080.8211.2.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Chiu <chiu@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>, Alan Stern <stern@rowland.harvard.edu>, Linux PM <linux-pm@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>

Hi Oliver,

On Wed, Oct 18, 2017 at 5:31 PM, Oliver Neukum <oneukum@suse.com> wrote:
> Am Mittwoch, den 18.10.2017, 15:15 +0800 schrieb Daniel Drake:
>> Notes:
>>     v2:
>>     - Handle quirk later in suspend, to avoid interfering with other parts
>>       of the suspend routine.
>>     - Don't do the disconnect on runtime suspend, only for S3 suspend
>
> well, can we effectively runtime suspend these devices?

How can I test for effective runtime suspend?

> Furthermore, it seems to me that we indeed cannot do a runtime
> suspend on external devices needing this quirk, but what about
> internal devices?

In this case the modem is an internal device.

Daniel
