From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 8 Oct 2010 13:49:14 -0400
Message-ID: <20101008174914.GD17865__43683.7813504555$1286563796$gmane$org@redhat.com>
References: <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal> <4CAF4554.7070303@linux.intel.com>
	<1286558495.6661.822.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1286558495.6661.822.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi -

On Fri, Oct 08, 2010 at 01:21:35PM -0400, Steven Rostedt wrote:
> [...]
> Perhaps we should have "make install" of a kernel also install this
> library?
> [...]
> The app only needs to worry about loading the generic library. The
> generic library can test for compatible libraries for the kernel.
> [...]

If this library were to be distributed with the kernel, what would
make the generic side of the interface any less permanent than a
kernel ABI?  That is, if there is a libkernel-internals.so built from
kernel sources, wouldn't its ABI become necessarily as fixed as any
old syscall or procfs file?

One can have some backward compatibility with symbol versioning et
al., but would that be sufficiently powerful to avoid handcuffing
kernel developers' inclinations to make random future changes?

- FChE
