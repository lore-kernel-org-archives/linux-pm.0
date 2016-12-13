From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Tue, 13 Dec 2016 15:53:50 +0200
Message-ID: <CAJKOXPdEy5N3qR3YGWJi41wD3uRDONmd16gC5LuayZ4_krT6YA@mail.gmail.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <c956e27e-7e01-2a2f-0e35-796c4a6556ae@xs4all.nl> <b34f49c8-6b37-cabf-2a0f-c8d465c53159@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <b34f49c8-6b37-cabf-2a0f-c8d465c53159@xs4all.nl>
Sender: linux-mmc-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, tjakobi@math.uni-bielefeld.de, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 13, 2016 at 2:34 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Try again, this time with Krzysztof's new email address...
>
>
> On 13/12/16 13:20, Hans Verkuil wrote:
>>
>> Hi Krzysztof,
>>
>> This still seems to be broken with the latest 4.9 kernel, right?
>>
>> Has there been any progress on this? Do you have an updated patch series
>> for me to use?

Hi,

I think it is not fixed. Still. I left this work to others. AFAIK,
Peter Chen is working on a new generic approach:
https://lwn.net/Articles/703556/
On top of his patchset, Odroid would need some DTS code as well (and
maybe something in usb3503). However I do not plan to work on this
anymore as I do not have Odroid U3 anymore. Marek and Bartlomiej from
Samsung Poland are in CC-list so maybe they would like to continue the
work?

Best regards,
Krzysztof
