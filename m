From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Runtime: Reduce code duplication in
 core helper functions (was: Re: [PATCH] PM: add synchronous ...)
Date: Sat, 2 Oct 2010 10:15:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010021012590.15874-100000__8591.65189690447$1286029206$gmane$org@netrider.rowland.org>
References: <201010020037.55277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010020037.55277.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2 Oct 2010, Rafael J. Wysocki wrote:

> > > > BTW, I like some changes made by your patch that aren't really related to
> > > > the issue at hand, so I think the patch below can be applied regardless of
> > > > the other changes, unless I made a mistake I can see now.
> > > 
> > > It looks like a good change, but you forgot to preserve the assignments 
> > > to dev->power.runtime_error.
> > 
> > That's correct and there's a difference betwee _idle and the other cases
> > because of that.  I'll send updated patch with a changelog shortly.
> 
> Appended as promised.

This looks okay.  In principle you could tell rpm_callback whether or 
not to store the return value in dev->power.runtime_error (by passing 
an extra argument), but it's probably not worthwhile.

Alan Stern
