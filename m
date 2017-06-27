From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] kernel/power/suspend: use CONFIG_HAVE_SET_MEMORY for
 include condition
Date: Tue, 27 Jun 2017 21:57:58 +1000
Message-ID: <CAKTCnz=1AixH3BVV8PuRLTwn6DZ=Lj9rM697K0sKTo3sypM0MQ@mail.gmail.com>
References: <20170603105232.6436-1-bsingharora@gmail.com> <20170603132747.GA18185@amd>
 <CAKTCnzk2bhFr3BvgQSzQr8TK9DB+bW7TyCtfzq7537F9Ym8QKw@mail.gmail.com> <1602211.zd022FB7i2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35666 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdF0L6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 07:58:04 -0400
In-Reply-To: <1602211.zd022FB7i2@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Jun 27, 2017 at 7:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 26, 2017 01:34:52 PM Balbir Singh wrote:
>> On Sat, Jun 3, 2017 at 11:27 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Sat 2017-06-03 20:52:32, Balbir Singh wrote:
>> >> Kbuild reported a build failure when CONFIG_STRICT_KERNEL_RWX was
>> >> enabled on powerpc. We don't yet have ARCH_HAS_SET_MEMORY and ppc32
>> >> saw a build failure.
>> >>
>> >> fixes(50327dd kernel/power/snapshot.c: use set_memory.h header)
>> >>
>> >> I've only done a basic compile test with a config that has
>> >> hibernation enabled.
>> >>
>> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> >> Cc: Len Brown <len.brown@intel.com>
>> > Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>> Ping. Could we please pick this up? it breaks any attempt to support
>> STRICT_KERNEL_RWX on powerpc
>
> Yes, I'm going to pick it up for 4.13.

Thanks,
Balbir Singh.
