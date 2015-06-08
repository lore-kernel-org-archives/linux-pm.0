From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Mon, 08 Jun 2015 20:18:40 +0200
Message-ID: <5575DC80.4040608@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com> <556F5C24.1030101@linaro.org> <5570B783.1050808@ahsoftware.de> <557589D9.1050008@melag.de> <5575DB8D.50000@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5575DB8D.50000@ahsoftware.de>
Sender: linux-gpio-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rob Herring <robherring2@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <stephane.marchesin@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dan Williams <dan.j.williams@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-clk@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel>
List-Id: linux-pm@vger.kernel.org

Am 08.06.2015 um 20:14 schrieb Alexander Holler:
> Am 08.06.2015 um 14:26 schrieb Enrico Weigelt, metux IT consult:
>> Am 04.06.2015 um 22:39 schrieb Alexander Holler:
>>
>>  > As it seems to have been forgotten or overread, I've mentioned in my
>>> series of patches last year that, with a few changes, it's possible to
>>> let the algorithm I've used (dfs) to spit out all drivers which can be
>>> initialized in parallel.
>>
>> Unfortunately, I've missed that ... could you please resend you patches?
>> Boot time reduction is one of the topics on my 2do in several weeks.
>
> https://lkml.org/lkml/2014/5/12/452
>

And don't forget patch 10/9 which fixed a bug in my previous patch 
series and which alos was the reason for the large difference in boot 
times with and without deps:

https://lkml.org/lkml/2014/5/13/567
