From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Documentation: power: reset: move gpio-{poweroff|restart}
 to proper place
Date: Fri, 15 Apr 2016 11:53:46 -0500
Message-ID: <CAL_JsqKK1QmGdyae-P9SoP2-7JiLK1XCyskxbd-wrn+7CidMJw@mail.gmail.com>
References: <1460476853-3306-1-git-send-email-wsa@the-dreams.de> <CACRpkdaUj5w3zkjWVf1GML3reeDnRpT8avOPkRB6_qFXB6EGjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaUj5w3zkjWVf1GML3reeDnRpT8avOPkRB6_qFXB6EGjw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 15, 2016 at 2:48 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 12, 2016 at 6:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> I did only find them after a fuzzy search, so let them be where one
>> would expect them.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I saw this the other day too I agree.
> Sebastian: are you OK that I move this by committing the patch to the GPIO tree?
> DT maintainers: OK?

Acked-by: Rob Herring <robh@kernel.org>

Seems like this should go thru my tree though, but I don't have the patch.

Rob
