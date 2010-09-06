From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Mon, 6 Sep 2010 12:42:59 +0200
Message-ID: <201009061243.00479.trenn__5964.08821079439$1283769874$gmane$org@suse.de>
References: <AANLkTikvbn3+JPc7pnGZk-H4B71MHTu+-vjuzfJw_7PC@mail.gmail.com>
	<20100904081801.GA19876@elte.hu>
	<AANLkTinrRoi6y1fKUevu2O-Diac5B2r8RftTWUigQZOh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinrRoi6y1fKUevu2O-Diac5B2r8RftTWUigQZOh@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 September 2010 10:56:50 Jean Pihet wrote:
> Hi,
> 
> Thanks for the feedback!
> 
> > On Friday 03 September 2010 21:55:55 Ingo Molnar wrote:
> >Well, the patch that got posted:
> >
> > [PATCH] tracing, perf: add more power related events
> >
> >Only adds tracepoints to power.h, but doesnt actually use them anywhere
> >...
> >
> >Is there a companion patch i missed?
> I will re-start a thread with the full patch and with both lkml and
> linux-omap in Cc.
discuss@lesswatts.org and linux-pm@lists.linux-foundation.org
are also lists where people could be interested in such stuff.

Could you explain a bit what these ARM specific power domains are then, please.

One idea I had after seeing these:
Would it make sense to additionally add one or several device power perf event(s)?
bluetooth, wireless, usb, cameras, whatever, could register it by name,
like you've done it with the power domains.
E.g. I had a problem with 2.6.31 where bluetooth was powered up/activated at
boot time, while it got activated ondemand before. Cost me some Watts and quite
some time to find that out.
Showing perf power events when bluetooth gets activated and put into lower power
states again (and the same for other devices), sounds like a good idea?

     Thomas
