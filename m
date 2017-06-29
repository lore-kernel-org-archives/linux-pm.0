From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH fixes v3] pinctrl: Really force states during suspend/resume
Date: Fri, 30 Jun 2017 00:25:27 +0200
Message-ID: <CACRpkdZbbgUcj149aE=N-RX4BLjVNsiOqvRDzWFDELyaKr_Z4Q@mail.gmail.com>
References: <20170301183257.6554-1-f.fainelli@gmail.com> <CAHp75VdWVq3E3qrgtvvJK=A4yxK+yM_q3ZJd1hNnFBTj-H4Mxw@mail.gmail.com>
 <304fb86d-0862-992b-4563-61151b37d060@gmail.com> <CACRpkdb-_oTuRyGWtH9Rb2g2w_J9VM=m3mXK94OYbCXy+E0XLw@mail.gmail.com>
 <18ca4418-8b62-a1c9-1282-0c468f2aefb2@gmail.com> <CACRpkdZBrYT=vXhR77W+v_hN=t6zYACVPm5HR==kC7nmDYJLQA@mail.gmail.com>
 <5e61618b-cfb0-ddff-3d87-bf512521e669@gmail.com> <CACRpkdbGza+vYTSqBRPbUGGnUsuNQS-6oKkweSch5Pwpku=CEg@mail.gmail.com>
 <37d75c89-883f-1c58-23e8-7e0213935986@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <37d75c89-883f-1c58-23e8-7e0213935986@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, Al Cooper <alcooperx@gmail.com>, "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 29, 2017 at 9:38 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/29/2017 02:17 AM, Linus Walleij wrote:

>> So if it is not desireable to have every driver know which exact
>> state it came from like S3 this or S2 that and on this laptop
>> we have S2' which is slightly different and such mess (that you
>> predict IIUC) what we really need to know is pretty simple:
>> did the hardware loose its state or not?
>
> That information is inherently platform specific though, so on platforms
> where pinctrl-single is used, you won't necessarily know whether the
> state should be restored (conversely saved) so maybe that means we
> should have the possibility for a platform to define a wrapper around
> pinctrl-single whose purpose is to implement platform specific
> suspend/r/resume functions and just that really? Is there such a driver
> already that uses pinctrl-single more as a "library" than anything else?

pinctrl-single maye not be the easiest in cases like this, but Tony
et al have bolted in a few OMAP specifics to pinctrl-single in the
past so I don't see why this would be a problem.

commit 02e483f66deb6bd8df6af450726574614eb53be3
"pinctrl: single: Prepare for supporting SoC specific features"
etc.

Yours,
Linus Walleij
