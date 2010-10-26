From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 13:15:31 -0500
Message-ID: <AANLkTikAGsdm7HS7Au-6CHw5n0OC1c1L_j2AJgZKE_=K__27821.9091509984$1288117095$gmane$org@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	<4CC6FC03.708@linux.intel.com>
	<AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
	<1288115894.3673.12.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288115894.3673.12.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 26, 2010 at 12:58 PM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
>>
>> + =A0 =A0 =A0 trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_=
count)+1);
>> =A0 =A0 =A0 =A0 atomic_inc(&dev->power.usage_count);
>
> That's terribly racy..
>
I know. I'm not proud of this.. As I said, this is preliminary patch.
We dont really need to have this prev_usage. This is just for debug.
It mayprobably endup with something like:

         atomic_inc(&dev->power.usage_count);
+       trace_power_device_usage(dev);

-- =

Pierre
