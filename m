From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v7 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Thu, 31 Mar 2016 14:54:28 +0200
Message-ID: <56FD1E04.8050808@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
 <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
 <56FD13D2.1050300@samsung.com>
 <CAGTfZH0mgxyQPKBTX=ZXgtSn=bQ2zAMSNMHfO+OXh3U5qrUr4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGTfZH0mgxyQPKBTX=ZXgtSn=bQ2zAMSNMHfO+OXh3U5qrUr4g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anand Moon <linux.amoon@gmail.com>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vg>
List-Id: linux-pm@vger.kernel.org

On 03/31/2016 02:28 PM, Chanwoo Choi wrote:
>> > You should use IS_ERR() instead of IS_ERR_OR_NULL(), since functions
>> > of which the return value is being tested return only ERR_PTR() values.
>> > IS_ERR_OR_NULL() suggest NULL values are possible and then constructs
>> > like
>> >         if (IS_ERR_OR_NULL(result))
>> >                 return PTR_ERR(result);
>> >
>> > are not correct anyway.
>
> OK. I'll use IS_ERR() instead of IS_ERR_OR_NULL()

Thanks, I forgot to mention there is similar issue in patches
5/20 and 6/20.

--
Regards
Sylwester
