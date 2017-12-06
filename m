From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive & negative pstates
Date: Wed, 06 Dec 2017 23:41:32 +1100
Message-ID: <87lgigdo5f.fsf@concordia.ellerman.id.au>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <87r2s8dt3w.fsf@concordia.ellerman.id.au> <20171206111944.GB22880@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:35905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbdLFMle (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Dec 2017 07:41:34 -0500
In-Reply-To: <20171206111944.GB22880@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, huntbag@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:

> Hi Michael,
>
> On Wed, Dec 06, 2017 at 09:54:27PM +1100, Michael Ellerman wrote:
>> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> 
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> > Pstates are 8bit values but on POWER8 they are negative and on POWER9
>> > they are positive. This patch adds helper routines to differentiate
>> > the sign to read the correct pstate value.
>> 
>> This sounds like it could be a bad bug, but I can't really tell from the
>> change log. What is the actual impact of not having this patch?
>
> On some POWER9 platforms, there can be more than 128 pstates. 
>
> Without this patch, on such platforms, if the value of the current
> frequency corresponds to a pstate greater than 128, then the code will
> interpret it as a negative number, and report that the "pstate is out
> of bound" while returning a nominal frequency.

OK, that's good detail to have in the change log, please include it.

>> Should it have a Fixes/Cc-stable tag?
>
> This doesn't fix any prior commit, but is fixes a newly discovered
> bug.

OK. You could say it "fixes" the commit that added Power9 support to the
driver, but it seems there wasn't really a commit that did that
specifically.

> I will resend the patch Cc'ing stable.

You don't have to Cc stable, that was just a suggestion. Though it
sounds like the symptoms are probably bad enough to warrant it.

cheers
