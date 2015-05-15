From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 15 May 2015 12:27:13 -0500
Message-ID: <CAL_JsqL2CpRu51=t_kacMxb1AfpJnep8vnkzF2YQuCXSCvJFFg@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk> <20150514003201.20636.83883@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33274 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933041AbbEOR1e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 13:27:34 -0400
In-Reply-To: <20150514003201.20636.83883@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Wed, May 13, 2015 at 7:32 PM, Michael Turquette
<mike.turquette@linaro.org> wrote:
> Quoting Mark Brown (2015-05-13 04:03:57)
>> On Wed, May 13, 2015 at 02:25:28PM +0530, Viresh Kumar wrote:
>> > On 12-05-15, 14:42, Michael Turquette wrote:
>> > > Quoting Viresh Kumar (2015-04-30 05:07:59)
>> >
>> > > Why should this new binding exist?
>>
>> > The answer to this particular query is perhaps simple, i.e. we have
>> > unsolved problems that we wanted to solve in a generic way.
>>
>> > But probably the bigger question is "Should we really put the OPPs
>> > (new or old bindings) in DT".
>>
>> And also is trying to do this in a completely generic manner the right
>> way of going about things - do we really understand the problem area
>> well enough to create a completely generic solution for all cases,
>> bearing in mind that once things go into a DT binding they become an ABI?
>
> No, we don't understand the problem space well enough to form an ABI.
> And even if we did understand it perfectly today, the constraints and
> expressions will change tomorrow.
>
> Putting this stuff in C without any philosophical constraints on whether
> or not we can change it later is the way to go.

Having a binding does not preclude you from doing your own thing in C.
You can choose to ignore it (or parts of it). It also doesn't mean you
have to use a generic driver with a generic binding.

While yes, we could do the same thing in C, the reality is that we
often don't force common data into common structures. This leads to
obfuscating what are the real h/w differences because everyone does
things their own way. Conveniently, struct dev_pm_opp is a perfect
example here. We already know that just freq and volt alone are not
enough, yet that is all the kernel structure has.

The way you avoid the ABI issue is you create a new one which is what
we've done here. I'm not saying we want 10 different OPP bindings. If
we are back here in a year with v3, then yes you are probably right.
But I believe v2 is a framework that can last. Most of the review
issues have resulted in simply dropping properties (until needed)
without otherwise changing the binding. I think that demonstrates this
bindiing is flexible and extendable.

Rob
