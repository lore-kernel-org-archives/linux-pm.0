From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 19:48:03 +0100
Message-ID: <5388D263.20401@arm.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>	<1401440477-4328-3-git-send-email-thomas.ab@samsung.com>	<20140530130827.GK24233@leverpostej> <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com> <5388CAC5.5010607@gmail.com> <5388D02D.4020209@arm.com> <5388D0EB.1090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33756 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbaE3Sr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 14:47:27 -0400
In-Reply-To: <5388D0EB.1090001@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, Thomas Abraham <ta.omasab@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "nm@ti.com" <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>



On 30/05/14 19:41, Tomasz Figa wrote:
> On 30.05.2014 20:38, Sudeep Holla wrote:
>> On 30/05/14 19:15, Tomasz Figa wrote:
>>> On 30.05.2014 20:05, Thomas Abraham wrote:
>>>> On Fri, May 30, 2014 at 6:38 PM, Mark Rutland <mark.rutland@arm.com>
>>>> wrote:
>
> [snip]
>
>>>>> Why are these in both operating-points and boost-frequencies? It'll be
>>>>> really easy to accidentally forget to mark something as a
>>>>> boost-frequency this way. Why not have a boost-points instead?
>>>>
>>
>> I was told that index is not preferred based on the previous discussions
>> when the OPP bindings were designed. In addition the OPP binding doesn't
>> enforce any ordering. There are thermal bindings that assume otherwise and
>> is broken. So boost-points is not feasible.
>>
>
> My understanding of Mark's comment was that the boost-points property
> would use the same format as operating-points and parsing code would
> just concatenate operating points with boost points after making the
> latter with necessary flag or whatever.
>

Ah, I misunderstood that. That should be fine as it avoids duplication.

Regards,
Sudeep

