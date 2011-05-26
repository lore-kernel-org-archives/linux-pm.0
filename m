From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] introduce intel_rapl driver
Date: Thu, 26 May 2011 12:21:39 +0200
Message-ID: <1306405299.1200.51.camel__39540.7620272183$1306405398$gmane$org@twins>
References: <1306398857.2207.157.camel@rui> <1306403003.1200.41.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306403003.1200.41.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matt Fleming <matt@console-pimps.org>, ming.m.lin@intel.com, LKML <linux-kernel@vger.kernel.org>, acme@redhat.com, linux-pm <linux-pm@lists.linux-foundation.org>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-05-26 at 11:43 +0200, Peter Zijlstra wrote:
> > +     for(id = 0; id < RAPL_DOMAIN_MAX; id++)
> > +             if (rapl_domains[id].valid)
> > +                     perf_pmu_register(&(rapl_domains[id].pmu), rapl_domains[id].pmu.name, PERF_TYPE_SOFTWARE);
> 
> Uhm, hell no!, you get to use type = -1. 

Also, you don't need a struct pmu per domain.
