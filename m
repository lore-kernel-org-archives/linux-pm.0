From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 22 May 2015 11:04:49 -0500
Message-ID: <CAL_JsqK-P=mMsgH27==Mjs2_Ji=uLcYDrecnT7rsDVYk62zmpA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <555D750F.80304@ti.com> <20150522140457.GB7730@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36739 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422691AbbEVQFK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 12:05:10 -0400
In-Reply-To: <20150522140457.GB7730@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: Rob Herring <rob.herring@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Michael Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Fri, May 22, 2015 at 9:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-05-15, 01:02, Nishanth Menon wrote:
>> This argues that clock is an input to the cpu, this is not in-correct,
>> but, it could also be argued that OPP tables are clock dependent.

What piece of h/w is the clock an input to then?

>> For example, with multiple clock source options that a device might
>> choose to select from internally(by some means.. lets not just restrict
>> ourselves to just CPUs here for a moment), the tables might be
>> different. We can always debate that this then is the responsibility of
>> the driver handling the description for that device and we might want
>> possibility of vice versa as well - same OPP table used by different
>> clock source selections as well.
>
> @Rob: Any inputs ?

If you are going to describe this clock mux in DT, then that mux
should be part of the h/w block that controls it. You could always add
entries that describe what parent clock must be used for a given OPP,
but that is a new binding and not part of the existing clock binding.

If things get too complicated, then don't try to describe this in DT.
That is always an option.

Rob
