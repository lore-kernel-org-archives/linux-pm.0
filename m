From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Tue, 20 Apr 2010 10:30:13 +0530
Message-ID: <20100420050013.GC2915__32707.5638612316$1271739706$gmane$org@dirshya.in.ibm.com>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
	<h2u4352991a1004191020q8200399oc8e9f7d8dee934bf@mail.gmail.com>
	<1271703701.1676.235.camel@laptop>
	<20100419180032.15586a90@infradead.org>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100419180032.15586a90@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Salman Qazi <sqazi@google.com>, akpm@linux-foundation.org, ranjitm@google.com, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [2010-04-19 18:00:32]:

> On Mon, 19 Apr 2010 21:01:41 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Right, so the IBM folks who were looking at power aware scheduling
> > were working on an interface to quantify the amount of power to save.
> > 
> > But their approach, was an extension of the regular power aware
> > load-balancer, which basically groups tasks onto sockets so that whole
> > sockets can go idle.
> > 
> > However Arjan explained to me that your approach, which idles the
> > whole machine, has the advantage that also memory banks can go into
> > idle mode and save power.
> > 
> > Still in the interest to cut back on power-saving interfaces it would
> > be nice to see if there is anything we can do to merge these things,
> > but I really haven't thought much about that yet.
> 
> one correction, this is not about power *saving*, it is about power
> *capping*. Power capping is pretty much energy inefficient by
> definition (and surely in practice), but it's about dealing with
> reality about underdimensioned airconditioning or voltage rails....
> 
> Due to the reality that socket offlining isn't as good as idle
> insertion.. I rather focus on the later...

The power reduction benefit is architecture and topology dependent.
Like on POWER platform, socket offlining could provide better power
reduction than idle injection.

As mentioned by Arjan, these approaches help reduce average power
consumption to meet power and cooling limitation over a short
interval.  These are not general optimizations to improve operating
efficiency, however when use at certain workload and utilization
levels, these can potentially provide overall energy savings.

Having the SMP load balancer pull jobs away form a core or socket to
allow it to remain idle  for short burst of time will be an good
implementation.

--Vaidy
