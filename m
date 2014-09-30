From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Tue, 30 Sep 2014 11:41:19 -0700
Message-ID: <7h8ul1x86o.fsf@deeprootsystems.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
	<1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
	<20140929153154.GF2165@e102568-lin.cambridge.arm.com>
	<7hmw9hypj9.fsf@deeprootsystems.com>
	<alpine.LFD.2.11.1409301349260.5311@knanqh.ubzr>
	<CAMAWPa_ZGxOA3KfAPWhfRhJ8KcYYQvgXM9JwzmNwHKPTbchWSA@mail.gmail.com>
	<alpine.LFD.2.11.1409301428020.5311@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41129 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbaI3SlV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 14:41:21 -0400
In-Reply-To: <alpine.LFD.2.11.1409301428020.5311@knanqh.ubzr> (Nicolas Pitre's
	message of "Tue, 30 Sep 2014 14:30:07 -0400 (EDT)")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "galak@codeaurora.org" <galak@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> On Tue, 30 Sep 2014, Kevin Hilman wrote:
>
>> On Tue, Sep 30, 2014 at 10:51 AM, Nicolas Pitre
>> <nicolas.pitre@linaro.org> wrote:
>> > On Tue, 30 Sep 2014, Kevin Hilman wrote:
>> >
>> >> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

[...]

>> >> > This may be misleading. Call it PlatformWFI or something like that, not WFI if
>> >> > that's not what it is.
>> >>
>> >> This gets at a little pet peeve of mine:
>> >>
>> >> IMO, naming any state with "WFI" is a bit confusing, because typically
>> >> *every* idle state is entered by one (or more) CPU executing WFI, no?
>> >
>> > Agreed.
>> >
>> > The only state called "WFI" should be the one that only executes the WFI
>> > instruction without any other hardware setup around it.
>> 
>> Well, I would go even further in that none of the states should be
>> called WFI, because WFI is used to enter all of them.
>
> Fair enough.
>
> So let's fix this by finding a name for that state that consists of only 
> executing WFI and that every SOC has.
>
> Suggestions?

The DT idle-states binding doc (though seemingly written more with
arm64 and SBSA in mind) uses "standby" for the shallowest idle.

Kevin

