From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v2] PM / Sleep: Timer quiesce in freeze state
Date: Fri, 14 Nov 2014 15:58:13 +0800
Message-ID: <5465B615.8090203@linux.intel.com>
References: <5446787E.60202@linux.intel.com> <20141024153656.GM12706@worktop.programming.kicks-ass.net> <544DE5CF.9040501@linux.intel.com> <20141027074419.GE10501@worktop.programming.kicks-ass.net> <544F4B31.7050308@linux.intel.com> <20141028082503.GN3337@twins.programming.kicks-ass.net> <5450253B.5020802@linux.intel.com> <20141029082432.GV3337@twins.programming.kicks-ass.net> <5451A94F.1090200@linux.intel.com> <alpine.DEB.2.11.1411121558280.3935@nanos> <20141113013707.GQ29390@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1411131008280.3935@nanos> <54648C50.2060104@linux.intel.com> <alpine.DEB.2.11.1411131405370.3935@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41620 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbaKNH6P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Nov 2014 02:58:15 -0500
In-Reply-To: <alpine.DEB.2.11.1411131405370.3935@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

On 2014/11/13 21:06, Thomas Gleixner wrote:
> On Thu, 13 Nov 2014, Li, Aubrey wrote:
> 
>> On 2014/11/13 17:10, Thomas Gleixner wrote:
>>> On Thu, 13 Nov 2014, Peter Zijlstra wrote:
>>>> On Wed, Nov 12, 2014 at 10:09:47PM +0100, Thomas Gleixner wrote:
>>>> But sure, we can add suspend notifiers to stuff to shut down timers; I
>>>> should have a patch for at least one of the offenders somewhere. But I
>>>> really think that we should not be looking at the individual timers for
>>>> this, none of the other suspend modes care about active timers.
>>>
>>> Fair enough.
>>>  
>>
>> If you are okay with the current method to suspend timekeeping entirely,
>> then we can go further to fix the rest concerns.
> 
> I'm fine with that when it's done proper :)
> 

Sure, thanks for the suggestion, let me try my best to make you happy, ;)

> Thanks,
> 
> 	tglx
> 
> 

