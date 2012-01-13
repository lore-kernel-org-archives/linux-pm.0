From: Antti P Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Fri, 13 Jan 2012 18:17:06 +0200
Message-ID: <87pqenwpa5.fsf@amiettinen-lnx.nvidia.com>
References: <1326459559-5436-1-git-send-email-amiettinen@nvidia.com>
	<20120113152445.GA3005@mgross-G62>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

mark gross <markgross@thegnar.org> writes:
> just a quick note: ever since I lost my mgross@linux.intel.com email
> I've started using markgross@thegnar.org

Sorry - I picked the @linux.intel.com address from git blame. Hmm.. is
the mark.gross@intelc.om in MAINTAINERS still valid?

> FWIW if this works the way I hope it does then, its a feature we need
> for different reasons than interactivity.  So thanks for working on
> this!

Thanks - I appreciate the feedback!

>> V2:
>> * split min and max to separate commits
>> * handle PM QoS min above max as max
>> * handle PM QoS max below min as min
>
> A qos to constrain how slow the cpu goes is ok.
> A qos to constrain how fast it is allowed to go is not a PM_QOS thing.

Thanks - I appreciate the feedback :-)

As I said earlier, I think the maximum frequency can act as a level of
energy efficiency request. If a workload knows that a certain level of
performance is adequate, the maximum frequency request can prevent
e.g. ondemand unnecessarily raising the frequency.

	--Antti

