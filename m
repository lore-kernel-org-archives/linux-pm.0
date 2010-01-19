From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
 suspend/resume (was: Re: Memory allocations in .suspend became very
 unreliable)
Date: Tue, 19 Jan 2010 10:13:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001191012160.1437-100000__35059.3403833502$1263914253$gmane$org@iolanthe.rowland.org>
References: <201001182159.25585.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001182159.25585.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Jan 2010, Rafael J. Wysocki wrote:

> On Monday 18 January 2010, Alan Stern wrote:
> > On Mon, 18 Jan 2010, Oliver Neukum wrote:
> > 
> > > Am Montag, 18. Januar 2010 00:00:23 schrieb Rafael J. Wysocki:
> > > > On Sunday 17 January 2010, Benjamin Herrenschmidt wrote:
> > > > > On Sun, 2010-01-17 at 14:27 +0100, Rafael J. Wysocki wrote:
> > > > ...
> > > > > However, it's hard to deal with the case of allocations that have
> > > > > already started waiting for IOs. It might be possible to have some VM
> > > > > hook to make them wakeup, re-evaluate the situation and get out of that
> > > > > code path but in any case it would be tricky.
> > > > 
> > > > In the second version of the patch I used an rwsem that made us wait for these
> > > > allocations to complete before we changed gfp_allowed_mask.
> > > 
> > > This will be a very, very hot semaphore. What's the impact on performance?
> > 
> > Can it be replaced with something having lower overhead, such as SRCU?
> 
> I'm not sure about that.  In principle SRCU shouldn't be used if the reader can
> sleep unpredictably long and the memory allocation sutiation is one of these.

I don't think this matters.  Each SRCU usage has its own domain, and
different domains don't affect one another.  So the only thing that
would be blocked by a long-sleeping reader would be the suspend process
itself, and obviously you won't mind that.

Alan Stern
