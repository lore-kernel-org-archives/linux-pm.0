From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: fix a lockdep warning in runtime.c
Date: Wed, 2 Dec 2009 16:36:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912021635070.3041-100000@iolanthe.rowland.org>
References: <200912022215.29098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912022215.29098.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Dec 2009, Rafael J. Wysocki wrote:

> On Wednesday 02 December 2009, Alan Stern wrote:
> > This patch (as1309) fixes a lockdep warning in
> > __pm_runtime_set_status().  This is the one place where the runtime PM
> > framework acquires a nested power.lock, and the nesting is never more
> > than one deep.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> I have a very simila patch queued up already.  The only difference is that it
> uses SINGLE_DEPTH_NESTING instead of the new symbol.  My version is appended
> below.
> 
> > 
> > ---
> > 
> > If anybody is using the runtime PM framework in 2.6.32 then this 
> > should be pushed before the final release.
> 
> I'll push it to Linus, then, if there still is time.  Would you mind if I used
> my version?

That's fine.  I would have used SINGLE_DEPTH_NESTING if I had seen its 
definition.

Alan Stern
