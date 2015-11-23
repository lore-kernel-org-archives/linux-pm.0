From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: Re: [PATCH v1 2/2] intel_pstate: Change the setpoint for the cores
Date: Mon, 23 Nov 2015 14:45:55 +0100
Message-ID: <56531893.4000607@linux.intel.com>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
 <1446542840-14982-2-git-send-email-philippe.longepe@linux.intel.com>
 <001801d12478$ceb35630$6c1a0290$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65146 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbKWNoz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:44:55 -0500
In-Reply-To: <001801d12478$ceb35630$6c1a0290$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org



On 21/11/2015 17:22, Doug Smythies wrote:
> On 2015.11.03 01:27 Philippe Longepe wrote:
>
>> Change the setpoint to 60 accordingly to the new core busy scaled formula.
>> The new formaula is based on the number of cycles per seconds
>> (average frequency) divided by the requested frequency. So, we need to
>> chose a setpoint more aggressive to improve performance.
> Myself, and so as to improve response to some games and such that use
> many threads and such but often a lower overall CPU load, I think the setpoint should be set a little lower.
I have an idea to address these oscillating workload. I'm testing a 
patch on Android that detects these
use cases (mainly GLThreads migrating are responsible for these 
oscillation).
I'll submit it as soon as it gives the best power and performance trade-off.

>
> There is a tradeoff in reducing the setpoint further as it increases the noise
> and tendency to oscillate in the response curve. Ultimately, it may be desirable
> to introduce a little slope in the load / CPU frequency response curve.
>
> I have a bunch of graphs comparing response curves. [1]
>
>> Measured with this parameter, we noticed an improvement in Browsermark
>> for power and perf compared to the old formula:
> I would like to try this test on my system. What is the exact test?
> Do I understand correctly, that I need a browser to do the test?
> (my test system is a server, and it doesn't have a browser.)
Yes, for browsermark, you can use this link but you need a browser:
http://web.basemark.com/
Else you can try some gaming workloads (I was using CandyCrush on 
Android) to
evaluate the power gain.
>
>> Score without the patch: 3517
>> Power without the patch: 6856 mW
>>
>> Score with the patch: 3719
>> Power with the patch: 6265 mW
> There are some other Phoronix tests that we (the original maintainer and
> the a couple of others working with him used to use. See [1].
>
> Please be aware that the last time I tried to bring back load based calculations,
> Kristen tested the proposed solution on some intel "specpower test bed and
> experienced a regression on haswell based server platforms vs.  Dirks
> algorithm." I don't have any details.
> Your response curve, and in particular your step function response time,
> is different, so it might worth re-testing.
>    
> References:
>
> [1] double u double u double u dot smythies dot com/~doug/linux/intel_pstate/philippe_longepe/index.html
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

