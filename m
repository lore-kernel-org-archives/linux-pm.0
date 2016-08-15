From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 15 Aug 2016 10:06:13 -0600
Message-ID: <20160815160613.GD1401@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
 <20160812123516.GA24194@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36346 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbcHOQGN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2016 12:06:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id h186so18034086pfg.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2016 09:06:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160812123516.GA24194@brendan-thinkstation>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On Fri, Aug 12 2016 at 06:35 -0600, Brendan Jackman wrote:
>> >In general whatever binding we come up must not just address OS
>> >coordinated mode. Also I was thinking to have better coverage in
>> >the description by having a bit more complex system like:
>> >
>> >cluster0
>> >	CLUSTER_RET(Retention)
>> >	CLUSTER_PG(Power Gate)
>> >	core0
>> >		CORE_RET
>> >		CORE_PG
>> >	core1
>> >		CORE_RET
>> >		CORE_PG
>> >
>> >cluster1
>> >	CLUSTER_RET
>> >	CLUSTER_PG
>> >	core0
>> >		CORE_RET
>> >		CORE_PG
>> >	core1
>> >		CORE_RET
>> >		CORE_PG
>> >
>> >Platform Co-ordinate supports the following states and we should
>> >be able to determine that from the binding:
>> >
>> >CORE_RET
>> >CORE_PG
>> >CORE_RET + CLUSTER_RET
>>
>> The problem that we have to sove here is knowing that CORE_RET +
>> CLUSTER_PG (hypothetically) an invalid combination. Kevin and
>> I debated it in the earlier RFC and we dont have a good way to solve
>> this generically for all devices.
>>
>
>
>This is interesting. I had been working on the assumption that a parent
>power domain cannot enter any idle state until its children were all in
>their deepest idle state. I now realise that it's easy to imagine
>platforms where this isn't the case.
>
>However, I don't understand how your current bindings solve this issue
>and why using domain-power-states for all states (i.e. ignoring
>cpu-idle-states and putting CPU idle states in the domain-idle-states of
>a per-CPU power domain - I believe this is what Sudeep is suggesting)
>makes it any more difficult.
>
You are right, my current bindings don't solve it. I imagined one would
solve it by writing their own CPU PM Domain governor. In the context of
platform coordinated, we dont have a choice in Linux. May be the
firmware can assert that intelligence in not choosing those states. So,
we may have states added to cpuidle that are invalid and never get
chosen by the firmware. I am not sure, but may be that is acceptable.

>Could you link to this previous discussion you mentioned? I'm having
>trouble finding it (R.I.P Gmane).
>
Sigh. So hard to search. Let me see where it is, if it in mail or IRC
communication.

Thanks,
Lina

>> >CORE_PG + CLUSTER_RET
>> >CORE_PG + CLUSTER_PG
>> >
>
>Cheers,
>Brendan
