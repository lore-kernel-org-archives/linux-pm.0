From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/18] 2.6.40: x86 idle APM: remove
 deprecated apm_cpu_idle()
Date: Sun, 03 Apr 2011 08:18:56 +0530
Message-ID: <4D97E018.1090504__14561.8361807012$1301799012$gmane$org@linux.vnet.ibm.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
	<20110402124054.49c3a3f4@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1104021529580.18682@x980>
	<20110402220021.74ecdb5b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110402220021.74ecdb5b@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 04/03/2011 02:30 AM, Alan Cox wrote:
>> This patch series was posted in reply to a table of contents
>>
>> https://lkml.org/lkml/2011/4/2/8
>>
>> "By the end of this series, pm_idle is removed as a public
>>   x86 idle-loop registration mechanism.  A few other things are
>>   cleaned up in the process."
>
> Ok so lets rewind a bit - why do we want to remove pm_idle rather than
> just fix up the way registration occurs. It's just a symbol, one trivial
> interface that is exported and perhaps wants the export method tidying up.
>
>> Trinabh also replied to you, pointing one of the previous
>> LKML discussions about the mis-use of pm_idle.
>
> And there are misuses of just about every kernel symbol - kmalloc for
> example causes some people a lot of trouble !

There are other problems too. This design of pm_idle has been copied
by numerous other architectures. arm/blackfin/cris/ia64/m32r/m68knomm
/microblaze/mn10300/sh/sparc all have pm_idle. This will keep spreading
in future I guess.

>
>> We'll create a new APM cpuidle driver in Linux (Trinabh prototyped one),
>> and at the same time, schedule it for removal in a year.  Personally,
>> I think it is make-work, and in real-life it is more likely to do
>> more harm than removing apm_idle, but I don't want to stand in the
>> way of process.
>
> So you could just leave it alone - that's less work, less disruption and
> doesn't do any harm at all.
>
> As I read this the plan at the moment otherwise is
>
> 	- churn up all the code
> 	- remove PM idle hook
> 	- rewrite the APM code
> 	- replace the APM code
>
> whereas you could just leave the symbol exported or even just a hook to
> make people to do it right using:
>
> 	int register_pm_idle(function);

A patch was posted to do exactly this; see
https://lkml.org/lkml/2010/10/19/449 . The problem  is that it
results in two places of registration: cpuidle subsystem and
this. It was pointed that 99.99% of people run cpuidle and
we should directly call cpuidle and use its registration mechanism
rather than duplicate code.

Thanks,
-Trinabh
