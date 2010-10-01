From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 1 Oct 2010 18:29:53 +0200
Message-ID: <201010011829.53523.trenn__16999.9127080247$1285950662$gmane$org@suse.de>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<4CA60385.6040405@linux.intel.com> <20101001155823.GD5338@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101001155823.GD5338@nowhere>
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
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Friday 01 October 2010 17:58:25 Frederic Weisbecker wrote:
> On Fri, Oct 01, 2010 at 08:51:33AM -0700, Arjan van de Ven wrote:
> >
> > As before, strong NACK from me before, this is an ABI break.
Please suggest another way to get this cleaned up then.

> Yeah. I wish we can keep power_start and power_end events,
> at least for some time.
Try to document these events and their attributes.
You will then see that the whole interfaces absolutely make
no sense and you can't even put their meaning into words.

> I know this is very ugly, but this is the only solution if
> we want to conciliate forward progress and backward
> compatibility.
So you vote for the double event solution in kernel I posted
previously?

I'd like to have a decision how this will get cleaned up!

As ARM is going to make use of this stuff, there may show up
some more tools and they should not make use of an insane interface.

So can someone who is going to merge this then, telling me how
the cleanup will be done.

I'd prefer this approach over the one I posted before which allows
compatibility with old userspace apps.

Thanks,

     Thomas
