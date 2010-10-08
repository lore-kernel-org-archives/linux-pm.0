From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 13:21:35 -0400
Message-ID: <1286558495.6661.822.camel__48583.1052101732$1286558655$gmane$org@gandalf.stny.rr.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal>  <4CAF4554.7070303@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CAF4554.7070303@linux.intel.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Torvalds <torvalds@linux-foundation.org>, Jean Pihet <jean.pihet@newoldbits.com>, Masami@smtp1.linux-foundation.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-10-08 at 09:22 -0700, Arjan van de Ven wrote:
> On 10/8/2010 6:41 AM, Mathieu Desnoyers wrote:

> because that is not workable... at least nobody has shown to be able to 
> make this work.
> libraries (after compilation) live in /lib or /usr/lib (or lib64 I 
> suppose).....
> what mechanism ensures that a user who compiles his kernel gets a 
> library compatible with that kernel in /usr/lib?
> and can said library deal with older kernels too? And distro kernels?

Perhaps we should have "make install" of a kernel also install this
library?

Have two libraries? One that is linked to the app, the other that can
search for another library to link on load too (like a kernel.ld.so)

Then we could see the kernel version, and search for a library that is
compatible, and load that one.

The app only needs to worry about loading the generic library. The
generic library can test for compatible libraries for the kernel.

Could just be..

  libkernel.ld.so  which then loads..

  /lib/modules/2.6.36/libkernel.so


Just a little brain storming.

-- Steve
