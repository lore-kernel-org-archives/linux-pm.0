From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 9 May 2017 22:04:15 +0300
Message-ID: <CAHp75VfxVeBvo5bXjusi-ANNDEdCG0KAWrr2udu_GueQkhcd+Q@mail.gmail.com>
References: <20170412230854.GA11963@fury> <201705082259.51850@pali>
 <77e4e46f58354e10874ed0515f514fc2@ausx13mpc120.AMER.DELL.COM>
 <201705090017.44210@pali> <3ceae37c323d43f8b1cf6c9aafe55d5e@ausx13mpc120.AMER.DELL.COM>
 <20170509072903.GA22559@pali> <46fe1658d33647559b46c3a390a581ed@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32819 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdEITER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 15:04:17 -0400
In-Reply-To: <46fe1658d33647559b46c3a390a581ed@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, "Brown, Len" <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, May 9, 2017 at 9:10 PM,  <Mario.Limonciello@dell.com> wrote:

>> > > Then took relevant decompression code and it really decompressed that
>> > > binary MOF WMI buffer. But still decompressed format is binary, but I
>> > > now see all WMI GUID encoded in UTF-16. Decompressed BMF file has again
>> > > "FOMB" magic header.
>> >
>> > Well that's great.  Is it possible that this compression is used for every time
>> > a class was declared?
>>
>> Looks like not. That decompressed output seems to be not compressed
>> anymore. Just use same magic header.
> Actually it looks like a new magic header to me after decompressed.
>
> 46 4f 4d 42 54 15 00 00  01 00 00 00 01 00 00 00
> That's now FOMBT

I think you just mistakenly take 0x54 as letter when it looks more like

0x00001554
0x00000001
0x00000001

from the above dump.

-- 
With Best Regards,
Andy Shevchenko
