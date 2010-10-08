From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 14:11:13 -0400
Message-ID: <1286561473.23994.84.camel__9593.89442946321$1286561690$gmane$org@gandalf.stny.rr.com>
References: <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal> <4CAF4554.7070303@linux.intel.com>
	<1286558495.6661.822.camel@gandalf.stny.rr.com>
	<20101008174914.GD17865@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101008174914.GD17865@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, Masami@smtp1.linux-foundation.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-10-08 at 13:49 -0400, Frank Ch. Eigler wrote:
> Hi -
> 
> On Fri, Oct 08, 2010 at 01:21:35PM -0400, Steven Rostedt wrote:
> > [...]
> > Perhaps we should have "make install" of a kernel also install this
> > library?
> > [...]
> > The app only needs to worry about loading the generic library. The
> > generic library can test for compatible libraries for the kernel.
> > [...]
> 
> If this library were to be distributed with the kernel, what would
> make the generic side of the interface any less permanent than a
> kernel ABI?  That is, if there is a libkernel-internals.so built from
> kernel sources, wouldn't its ABI become necessarily as fixed as any
> old syscall or procfs file?

One thing, the backwards compatibility would reside in user space. The
big advantage to that than for this to be in kernel space is that it is
only there when used. When we have backward compatibility in the kernel,
it's there in memory for everyone, whether you want it or not.

> 
> One can have some backward compatibility with symbol versioning et
> al., but would that be sufficiently powerful to avoid handcuffing
> kernel developers' inclinations to make random future changes?
> 

Sure, also note, that this is a two lib design. We still have
a /usr/lib/libkernel.so that the apps will interface with. This will
need to load in the other kernel versions. When we change interfaces, we
can make the /usr/lib/libkernel.so.1 .2 etc.

Also doing this dynamically from a library, we can check if the kernel
versions work. It can test if the used function is compatible or not,
use an older version, or just tell the user "sorry, please update your
libkernel.so for this kernel." Doing this in userspace will allow a lot
more flexibility. We just need to think hard how these transactions will
work, and make it flexible for future enhancements.

But the kernel is free to do whatever it wants. The libraries will need
to worry about keeping the applications happy ;-)

-- Steve
