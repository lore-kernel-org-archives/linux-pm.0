From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 9 May 2017 22:26:31 +0300
Message-ID: <CAHp75Vc0rXwYKega9nJMrMe0tua6hrM7GTKOOJNsTNYR7KfGOA@mail.gmail.com>
References: <20170412230854.GA11963@fury> <201705082259.51850@pali>
 <77e4e46f58354e10874ed0515f514fc2@ausx13mpc120.AMER.DELL.COM>
 <201705090017.44210@pali> <3ceae37c323d43f8b1cf6c9aafe55d5e@ausx13mpc120.AMER.DELL.COM>
 <20170509072903.GA22559@pali> <46fe1658d33647559b46c3a390a581ed@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VfxVeBvo5bXjusi-ANNDEdCG0KAWrr2udu_GueQkhcd+Q@mail.gmail.com> <738221cbaca94d10a0de7c03116df60e@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <738221cbaca94d10a0de7c03116df60e@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, "Brown, Len" <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 9, 2017 at 10:16 PM,  <Mario.Limonciello@dell.com> wrote:


>> > 46 4f 4d 42 54 15 00 00  01 00 00 00 01 00 00 00
>> > That's now FOMBT
>>
>> I think you just mistakenly take 0x54 as letter when it looks more like
>>

>> 0x00001554

This one looks like offset (or size 5460)

>> 0x00000001
>> 0x00000001
>>
>> from the above dump.
> Ah, that's true, but second word is different than original was main point.
> We didn't know what that represented (maybe it's part of magic header).
>

> 46 4f 4d 42 01 00 00 00  ed 04 00 00 d8 15 00 00
> 0x00000001

0x000015d8

Again, looks like offset (or size).

0x000004ed



-- 
With Best Regards,
Andy Shevchenko
