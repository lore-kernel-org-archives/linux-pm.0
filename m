From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: ARM: sa1111: Drop suspend and resume bus type callbacks
Date: Thu, 28 Sep 2017 21:09:42 +0200
Message-ID: <CAJZ5v0iuzDk+gT=6KG3fX1d4C9dfzp0s8t-Y0pAM4SsVgaU=0A@mail.gmail.com>
References: <2654085.Tx1JnNWXkX@aspire.rjw.lan> <20170926212812.GS20805@n2100.armlinux.org.uk>
 <CAJZ5v0i1iwBpkUYN=DbpbtVDu+xMKwza=4EbjYNyGr5rs7-D8Q@mail.gmail.com> <20170928094936.GV20805@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:53438 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdI1TJn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2017 15:09:43 -0400
In-Reply-To: <20170928094936.GV20805@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Sep 28, 2017 at 11:49 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Sep 26, 2017 at 11:37:40PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Sep 26, 2017 at 11:28 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Tue, Sep 26, 2017 at 10:47:10PM +0200, Rafael J. Wysocki wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> None of the sa1111 drivers in the tree implements the suspend and
>> >> resume callbacks from struct sa1111_driver, so drop them and drop
>> >> the corresponding callbacks from sa1111_bus_type.
>> >>
>> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > This will conflict with some patches I have - would you like me to queue
>> > it along with my changes?
>>
>> Yes, please.
>>
>> >  When would you like to get this merged?
>>
>> When possible. :-)
>>
>> I would like to drop the legacy suspend/resume callbacks from struct
>> bus_type eventually, as that's long overdue, and this is needed for
>> that purpose.  Not too urgent, though.
>
> Sorry, I'd forgotten that I already had a similar patch:
>
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=sa1100&id=0e4ec3edb1c7e44aba1f48b924ab0c77431fd155
>
> so no need to merge your veresion... I just need to get my version merged.

OK

What about the locomo one?

Thanks,
Rafael
