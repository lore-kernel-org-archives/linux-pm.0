From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Thu, 9 Sep 2010 09:54:03 +0200
Message-ID: <20100909075403.GA10798__44897.8555425585$1284018915$gmane$org@elte.hu>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<20100908065333.GG3439@elte.hu>
	<AANLkTikpwSA411XRTi7Ybj_19URnW0mEMrf6pFYNpxVF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikpwSA411XRTi7Ybj_19URnW0mEMrf6pFYNpxVF@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org


* Jean Pihet <jean.pihet@newoldbits.com> wrote:

> On Wed, Sep 8, 2010 at 8:53 AM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Jean Pihet <jean.pihet@newoldbits.com> wrote:
> >
> >> Hi,
> >>
> >> Here is a patch proposal for adding new trace events for power management.
> >> Note: thread restarted after the initial discussions on LKML.
> >
> > Also mind including the ACPI tracepoints we talked about? That way a lot
> > more people could test it, etc.
>
> I think the ACPI tracepoints can be added on top of the proposed 
> patch. Is that ok?

Yeah - and the OMAP thing can be split up too if the OMAP folks prefer 
it that way, but we still want to _see_ all the patches in this thread 
together so that we have a critical mass of people interested in all 
this ...

Thanks,

	Ingo
