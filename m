From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 11/13] thermal: qoriq: Do not report invalid
 temperature reading
Date: Fri, 5 Apr 2019 11:30:41 -0700
Message-ID: <CAHQ1cqGohyy=0yFjaVK1Xy=MBDmca9B1Ea+dfDWwmGs65G6uxw@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-12-andrew.smirnov@gmail.com> <6b2bb239-dc98-df92-1999-0ae914732e17@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b2bb239-dc98-df92-1999-0ae914732e17@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 2:05 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Before returning measured temperature data to upper layer we need to
> > make sure that the reading was marked as "valid" to avoid reporting
> > bogus data.
>
> Is it possible to add a comment above the read_poll to describe the
> layout of the register ? That will help to understand the valid bit.
>

Sure, will do.

> Is the valid bit reset after reading the value?
>

It works a bit differently. Here's the description form the datasheet:

Valid measured temperature.
   0    Not valid. Temperature out of sensor range or first
measurement still pending.
   1    Valid.

Thanks,
Andrey Smirnov
