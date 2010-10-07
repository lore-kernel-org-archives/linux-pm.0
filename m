From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:56:16 +0200
Message-ID: <AANLkTin6Hm1w_tjZOWjm7ceJrkqZunai4Zcd83bo8qHS__38399.7017438107$1286467363$gmane$org@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<201010071749.35235.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010071749.35235.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Thomas,

On Thu, Oct 7, 2010 at 5:49 PM, Thomas Renninger <trenn@suse.de> wrote:
> On Thursday 07 October 2010 17:08:25 Mathieu Desnoyers wrote:
>> [ Adding a few more CCs, since this discussion is about a tracepoint
>> =A0 userspace ABI policy, which is a topic of general interest. ]
>>
> ...
>> Yes, sadly this debate running in circles hurts contributors.
>>
>> Thanks for the summary!
> Thanks for yours!
>
> So you (and Peter Zijlstra and some others) prefer the solution I
> posted with these two patches:
> [PATCH 1/2] PERF(kernel): Cleanup power events
My latest patch [1/4] is a rework of your patch. It adds:
- adaptation to linux-2.6-tip
- change of a wrong permission intel_idle.c
- light changes in the API (correction of trace printks ...)

I would prefer to use that version if you are ok.

> [PATCH 2/2] PERF(userspace): Adjust perf timechart to the new power events
>
> Those should be fine.
> Ingo, can you merge them, so that Jean can finally put his ARM
> specific implementation on top.
>
> Thanks,
>
> =A0 =A0Thomas
>

Jean
