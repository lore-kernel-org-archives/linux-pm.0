From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v11 07/10] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 23 Mar 2017 05:39:09 -0700
Message-ID: <CAKvHMgSpkfgQxMMLmw7MdLqP_LFMt-V9k63oRg5SsDDXTN5rXQ@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-8-liam@networkimprov.net> <20170323102825.vvxfzvuvvnhyzlna@earth>
 <CAKvHMgQsuTNcGUXZL7qk_YZ+qcdcLJ1+1xPB0zP97DqiitHJXA@mail.gmail.com> <20170323123054.jyngk44mea435cal@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36697 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933321AbdCWMjV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 08:39:21 -0400
Received: by mail-io0-f170.google.com with SMTP id l7so81350030ioe.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 05:39:20 -0700 (PDT)
In-Reply-To: <20170323123054.jyngk44mea435cal@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 23, 2017 at 5:30 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Thu, Mar 23, 2017 at 03:35:33AM -0700, Liam Breck wrote:
>> On Thu, Mar 23, 2017 at 3:28 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > Hi,
>> >
>> > On Mon, Mar 20, 2017 at 02:43:32AM -0700, Liam Breck wrote:
>> >> From: Liam Breck <kernel@networkimprov.net>
>> >>
>> >> Pass actual chip ID into _setup(), which translates it to a group ID,
>> >> to allow support for all chips by the power_supply_battery_info code.
>> >> There are no functional changes to the driver.
>> >>
>> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> >
>> > This is really ugly. If we need chip ID and group ID let's store
>> > them in different variables. For example put the detailed chipid
>> > into di->realchip and then do
>>
>> I tried this in a previous version, and Andrew rejected it as
>> confusing to have two IDs. That was while you were away on business
>> :-)
>
> now we have two IDs in the same variable.
> That definitely more confusing. We can name the second variable
> group to reduce confusion.

I was trying not to rename every instance of di->chip; there's a lot.

But we can pass real_chip as an argument to this function, so that
gets you what you wanted.
