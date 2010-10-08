From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 09:22:44 -0700
Message-ID: <4CAF4554.7070303__16056.2287121595$1286555313$gmane$org@linux.intel.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101008134156.GA28724@Krystal>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

  On 10/8/2010 6:41 AM, Mathieu Desnoyers wrote:
> * Arjan van de Ven (arjan@linux.intel.com) wrote:
>>   On 10/8/2010 1:38 AM, Ingo Molnar wrote:
>>> The fundamental thing about tracing/instrumentation is that there are no
>>> deep ABI needs: it's all about analyzing development kernels (and a few
>>> select versions that get the enterprise treatment) but otherwise the
>>> half-life of this kind of information is very short.
>>>
>>> So we dont want to tie ourselves down with excessive ABIs.
>>>
>> ok I'll start working on a second mechanism then to export information
>> that applications need ;-(
>> it'll look a lot like tracing I suppose ;-(
> What's wrong with doing the compatibility layer in a LGPL library shipped with
> the kernel tree under tools/ ?

because that is not workable... at least nobody has shown to be able to 
make this work.
libraries (after compilation) live in /lib or /usr/lib (or lib64 I 
suppose).....
what mechanism ensures that a user who compiles his kernel gets a 
library compatible with that kernel in /usr/lib?
and can said library deal with older kernels too? And distro kernels?

> Why does everything *have* to be done in
> kernel-space
it doesn't. but the alternative must be workable.
>   Why are you so focused on making your application interact
> directly with kernel ABIs ?
>
> I'm being direct because there are trivial solutions to your problem that you
> are rejecting without due consideration. (and also I just had one coffee too
> many) ;-)

since you seem to think that dealing with such a library is trivial... 
how about you do it for one function even, to
show that the deployment/use-in-an-app is workable.
I'd be more than happy to use it if it's workable and the API is at 
least halfway sane.
