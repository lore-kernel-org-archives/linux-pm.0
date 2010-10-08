From: Tejun Heo <tj@kernel.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 10:14:40 +0200
Message-ID: <4CAED2F0.9080801__21438.0482714207$1286525858$gmane$org@kernel.org>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101007155816.GA5351@nowhere>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

Hello,

On 10/07/2010 05:58 PM, Frederic Weisbecker wrote:
> I really feel uncomfortable with this tracepoint/ABI problem....
> Mathieu suggested we start a user library that could handle these
> changes when they are really necessary.
> 
> Thoughts?
> 
> (Adding Tejun in Cc).

Given that tracepoints are supposed to make internal operation
visible.  I don't think it's a good idea to make it part of fixed ABI.
Maybe some core part can be put in stone but I think things like
internal workqueue implementation should be changeable without
worrying about ABI issues.

Thanks.

-- 
tejun
