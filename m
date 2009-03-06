From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 0/4] timers: framework for migration
	between CPU
Date: Fri, 6 Mar 2009 09:53:33 +0530
Message-ID: <20090306042333.GA9190__34026.7829401002$1236313598$gmane$org@linux.vnet.ibm.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090305161451.0da40645@infradead.org>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090305161451.0da40645@infradead.org>
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
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [2009-03-05 16:14:51]:

> On Wed, 4 Mar 2009 17:42:49 +0530
> Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> > With the timers queued I measure the sleep state residency
> > for a period of 10s.
> > Next, I enable timer migration and measure the sleep state
> > residency period.
> 
> is your table in seconds? Because realistically, at least on PC like
> hardware, doing work to get sleep times over a 100 / 200 msecs or so
> isn't going to save you any amount of measurable power anymore...
>

Hi Arjan,

Yes, the table is in seconds.
Rather than looking at timer migration as a direct means of obtaining
power savings, I would like to see it as one of the mechanisms which
would aid in preventing an almost idle cpu from waking up
unnecessarily, thereby causing power penalty. Otherwise, there is a
chance of all the CPUs in a particular package being idle and the
entire package going into deep sleep.
So we cannot really get big power savings just by doing timer
migration alone.

--arun

> 
> 
> -- 
> Arjan van de Ven 	Intel Open Source Technology Centre
> For development, discussion and tips for power savings, 
> visit http://www.lesswatts.org
