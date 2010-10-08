From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 8 Oct 2010 09:41:56 -0400
Message-ID: <20101008134156.GA28724__20175.242474261$1286545430$gmane$org@Krystal>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CAF19E7.3070103@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Arjan van de Ven (arjan@linux.intel.com) wrote:
>  On 10/8/2010 1:38 AM, Ingo Molnar wrote:
>>
>> The fundamental thing about tracing/instrumentation is that there are no
>> deep ABI needs: it's all about analyzing development kernels (and a few
>> select versions that get the enterprise treatment) but otherwise the
>> half-life of this kind of information is very short.
>>
>> So we dont want to tie ourselves down with excessive ABIs.
>>
>
> ok I'll start working on a second mechanism then to export information  
> that applications need ;-(
> it'll look a lot like tracing I suppose ;-(

What's wrong with doing the compatibility layer in a LGPL library shipped with
the kernel tree under tools/ ? Why does everything *have* to be done in
kernel-space ? Why are you so focused on making your application interact
directly with kernel ABIs ?

I'm being direct because there are trivial solutions to your problem that you
are rejecting without due consideration. (and also I just had one coffee too
many) ;-)

Regards,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
