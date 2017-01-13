From: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v5 2/5] powernv:stop: Uniformly rename power9 to arch300
Date: Fri, 13 Jan 2017 14:46:07 +1100
Message-ID: <CAOSf1CET-A+E1FkS4hOJLQapnih=Sx51U6BdgjqXy--xJ9nytw@mail.gmail.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-3-git-send-email-ego@linux.vnet.ibm.com> <20170112094733.GC3006@localhost.localdomain>
 <20170113034418.GA10844@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33163 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdAMDqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 22:46:08 -0500
In-Reply-To: <20170113034418.GA10844@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com

On Fri, Jan 13, 2017 at 2:44 PM, Gautham R Shenoy
<ego@linux.vnet.ibm.com> wrote:
> On Thu, Jan 12, 2017 at 03:17:33PM +0530, Balbir Singh wrote:
>> On Tue, Jan 10, 2017 at 02:37:01PM +0530, Gautham R. Shenoy wrote:
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> > Balbir pointed out that in idle_book3s.S and powernv/idle.c some
>> > functions and variables had power9 in their names while some others
>> > had arch300.
>> >
>>
>> I would prefer power9 to arch300
>>
>
>
> I don't have a strong preference for arch300 vs power9, will change it
> to power9 if that looks better.

Personally I think we should be as descriptive as possible and use
power_9_arch_300_the_bikeshed_is_red_dammit.

Oliver
