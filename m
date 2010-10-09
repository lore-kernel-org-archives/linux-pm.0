From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 9 Oct 2010 11:36:50 -0700
Message-ID: <AANLkTimT5Or7gLDMnmLqSzmUoPux0pXrPxUZQpFon+6___9029.46604551307$1286650042$gmane$org@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	<AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 9, 2010 at 1:14 AM, Pierre Tardy <tardyp@gmail.com> wrote:
> On Sat, Oct 9, 2010 at 8:28 AM, Ingo Molnar <mingo@elte.hu> wrote:
>>
>
>> The thing is, Arjan is 100% right that a library for this is not a
>> 'solution', it's an unnecessary complication.
> Yes. sounds like overengineering.

I also want to remind people that backwards compatibility should
always absolutely be the #1 priority. Using libraries to "hide"
differences is a totally moronic thing to do, because if you can do a
compatibility library with good interfaces, then damn it, the kernel
interface should already _be_ that good interface.

And no, even if you interact purely with open source programs, the
backwards compatibility requirement doesn't go away. It's a damn pain
in the ass to have to recompile, and it means that you have a much
harder time mixing and matching, and just updating the kernel on top
of a standard distribution.

So changing kernel interfaces that get exported to user space is
always a disaster. Anybody who _designs_ for that kind of disaster
shouldn't be participating in kernel development, because they've
shown themselves to be unable to understand the pain and suffering.

Yes, we do it. Sometimes we change interfaces because not changing
them is too damn painful. But it should absolutely not be the design
model.

                            Linus
