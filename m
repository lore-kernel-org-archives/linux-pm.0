From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 22 Nov 2017 11:17:50 +0000
Message-ID: <051f2be1-ba04-be52-509e-95410050e2bf@arm.com>
References: <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org> <5A144CB3.50806@gmail.com>
 <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
 <20171121165703.GA2499@localhost.localdomain>
 <20171121180006.GA26638@localhost>
 <20171121181222.GA4075@localhost.localdomain>
 <a9f9e968-c93f-4f84-453c-03914263ac04@arm.com>
 <20171122111013.GB4084@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdKVLR5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Nov 2017 06:17:57 -0500
In-Reply-To: <20171122111013.GB4084@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba <llu.ker.dev@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On 22/11/17 11:10, Viresh Kumar wrote:
> On 22-11-17, 10:59, Sudeep Holla wrote:
>> IMO, if the $subject code is expected to be used on Juno, then my answer
>> is no if one can't test it reliably and also prove that static power
>> really matters on Juno. So far, I have heard both the above is not
>> possible. So please delete the code if Juno is the only user in
>> short and mid term. We can get the code back if we find any users in
>> longer term.
> 
> Its funny that the $subject patch receives few Acks and Nacks every day now :)
> 

If Nacks are depending on Juno, then you can convert them to Ack on my
behalf ;) as that won't happen unless someone disproves all the known
facts so far and provides a solid test case we can depend on to test
regressions.

-- 
Regards,
Sudeep
