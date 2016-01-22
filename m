From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RFC PATCH v3] POWER/runtime: refining the rpm_suspend function
Date: Fri, 22 Jan 2016 15:35:54 +0800
Message-ID: <CAN2waFtmeuYTJA24ZZy0x10ud-AS-zESfOCgiHuf5dCgtiB4rw@mail.gmail.com>
References: <1453345731-5192-1-git-send-email-zhaoyang.huang@spreadtrum.com>
	<20160121193229.GA13448@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121193229.GA13448@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?B?Wmhhb3lhbmcgSHVhbmcgKOm7hOacnemYsyk=?= <zhaoyang.huang@spreadtrum.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, Serge Broslavsky <serge.broslavsky@linaro.org>, Alex Wang <alex.wang@spreadtrum.com>, Geng Ren <geng.ren@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

On 22 January 2016 at 03:32, Pavel Machek <pavel@ucw.cz> wrote:
>
>> -             goto repeat;
>> +
>> +             /*check expires firstly for auto suspend mode,
>> +             *if not, just go ahead to the async
>> +             */
>
> English, coding style.
>                                                                 Pavel
Hi Pavel,
Thank you for review. I will modify it for next version. So In terms
of readability,
do you think if the patch improves a little or not?

>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
