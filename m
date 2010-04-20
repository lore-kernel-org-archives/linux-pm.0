From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Mon, 19 Apr 2010 18:00:32 -0700
Message-ID: <20100419180032.15586a90__6511.42242500118$1271725246$gmane$org@infradead.org>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
	<h2u4352991a1004191020q8200399oc8e9f7d8dee934bf@mail.gmail.com>
	<1271703701.1676.235.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1271703701.1676.235.camel@laptop>
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
Cc: Salman Qazi <sqazi@google.com>, akpm@linux-foundation.org, dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Mon, 19 Apr 2010 21:01:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Right, so the IBM folks who were looking at power aware scheduling
> were working on an interface to quantify the amount of power to save.
> 
> But their approach, was an extension of the regular power aware
> load-balancer, which basically groups tasks onto sockets so that whole
> sockets can go idle.
> 
> However Arjan explained to me that your approach, which idles the
> whole machine, has the advantage that also memory banks can go into
> idle mode and save power.
> 
> Still in the interest to cut back on power-saving interfaces it would
> be nice to see if there is anything we can do to merge these things,
> but I really haven't thought much about that yet.

one correction, this is not about power *saving*, it is about power
*capping*. Power capping is pretty much energy inefficient by
definition (and surely in practice), but it's about dealing with
reality about underdimensioned airconditioning or voltage rails....

Due to the reality that socket offlining isn't as good as idle
insertion.. I rather focus on the later...



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
