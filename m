From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Fri, 10 Jun 2011 09:55:29 -0700
Message-ID: <20110610165529.GC2230__26763.0714377903$1307724982$gmane$org@linux.vnet.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
	<BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g@mail.gmail.com>
	<20110610151121.GA2230@linux.vnet.ibm.com>
	<20110610155954.GA25774@srcf.ucam.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110610155954.GA25774@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2011 at 04:59:54PM +0100, Matthew Garrett wrote:
> On Fri, Jun 10, 2011 at 08:11:21AM -0700, Paul E. McKenney wrote:
> 
> > Of course, on a server, you could get similar results by having a very
> > large amount of memory (say 256GB) and a workload that needed all the
> > memory only occasionally for short periods, but could get by with much
> > less (say 8GB) the rest of the time.  I have no idea whether or not
> > anyone actually has such a system.
> 
> For the server case, the low hanging fruit would seem to be 
> finer-grained self-refresh. At best we seem to be able to do that on a 
> per-CPU socket basis right now. The difference between active and 
> self-refresh would seem to be much larger than the difference between 
> self-refresh and powered down.

By "finer-grained self-refresh" you mean turning off refresh for banks
of memory that are not being used, right?  If so, this is supported by
the memory-regions support provided, at least assuming that the regions
can be aligned with the self-refresh boundaries.

Or am I missing your point?

							Thanx, Paul
