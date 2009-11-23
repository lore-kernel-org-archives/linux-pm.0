From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime resume of children
Date: Mon, 23 Nov 2009 15:59:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911231556500.2958-100000@iolanthe.rowland.org>
References: <200911232144.31499.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911232144.31499.rjw@sisk.pl>
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

On Mon, 23 Nov 2009, Rafael J. Wysocki wrote:

> On Sunday 22 November 2009, Alan Stern wrote:
> > Rafael:
> > 
> > Here's the situation.  Device A has children B1, ..., Bn (possibly
> > others too).  I need to guarantee that whenever A is active, so are the
> > children.
> 
> But it's perfectly valid to have an inactive device under an active parent, so
> I guess this is not a general case.

Correct.  It's a specific case that I need to handle for USB.

> > Do you have any ideas on how to approach this?  How about allowing A's
> > runtime_resume method to set A->power.runtime_status to RPM_ACTIVE,
> > before it tries to resume the B's?  That would avoid the deadlock.
> 
> I don't see a problem with that as long as the A's runtime_resume returns 0 in
> such a case.

Should I export a routine from the PM core for doing this or just 
implement it directly?

Alan Stern
