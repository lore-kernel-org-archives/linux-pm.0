From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Wed, 17 Jun 2015 08:47:35 -0500
Message-ID: <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org> <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com> <20150617133314.GB15153@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34013 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbbFQNr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 09:47:56 -0400
In-Reply-To: <20150617133314.GB15153@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>

On Wed, Jun 17, 2015 at 8:33 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-06-15, 08:23, Rob Herring wrote:
>> > +                       operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
>>
>> You've made a fundamental change here in that this can now be a list
>> of phandles. There should be some description on what a list means
>> (merge the tables?, select one?).
>
> Did you miss the description I wrote few lines earlier or are you
> asking for something else? This is what I wrote earlier:
>
>> > +Devices may want to choose OPP tables at runtime and so can provide a list of
>> > +phandles here. But only *one* of them should be chosen at runtime.
>
> So, clearly only ONE of the tables should be used.

Yes, never mind.

>
>> I think this needs to have a defined order and the platform should
>> know what that is. For example, if you read the efuses and decide you
>> need the "slow" table, you know to pick the first entry. Then you
>> don't need opp-name. Does that work for QCom?
>
> Why forcing on the order here? For example, consider a case where the
> platform can have four tables, A B C D. Now DT is free to pass all
> four or just a subset of those. Like, for some boards table B doesn't
> stand valid. And so it may wanna pass just A C D. And so keeping these
> tables in order is going to break for sure. Flexibility is probably
> better in this case.

Defined order is a key part of DT bindings. We solve the variable
length problem with name lists associated with variable length
property like:

operating-point-names = "slow", "fast";

I'm not a fan of doing this if we can avoid it, but we should at least
follow the same pattern. Don't send me a patch with that yet, I want
to hear from Stephen.

You can also use "status" to disable specific tables rather than
removing from the list.

Rob
