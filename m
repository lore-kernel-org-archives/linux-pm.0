From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime resume of children
Date: Mon, 23 Nov 2009 23:11:49 +0100
Message-ID: <200911232311.49110.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911231556500.2958-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911231556500.2958-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 November 2009, Alan Stern wrote:
> On Mon, 23 Nov 2009, Rafael J. Wysocki wrote:
> 
> > On Sunday 22 November 2009, Alan Stern wrote:
> > > Rafael:
> > > 
> > > Here's the situation.  Device A has children B1, ..., Bn (possibly
> > > others too).  I need to guarantee that whenever A is active, so are the
> > > children.
> > 
> > But it's perfectly valid to have an inactive device under an active parent, so
> > I guess this is not a general case.
> 
> Correct.  It's a specific case that I need to handle for USB.
> 
> > > Do you have any ideas on how to approach this?  How about allowing A's
> > > runtime_resume method to set A->power.runtime_status to RPM_ACTIVE,
> > > before it tries to resume the B's?  That would avoid the deadlock.
> > 
> > I don't see a problem with that as long as the A's runtime_resume returns 0 in
> > such a case.
> 
> Should I export a routine from the PM core for doing this or just 
> implement it directly?

Please implement that directly.  If there's any other bus type needing it,
we'll move it to the core.

Thanks,
Rafael
