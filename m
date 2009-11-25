From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime resume of children
Date: Wed, 25 Nov 2009 15:46:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911251542030.2879-100000@iolanthe.rowland.org>
References: <200911251041.14222.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911251041.14222.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 25 Nov 2009, Oliver Neukum wrote:

> Am Montag, 23. November 2009 21:59:12 schrieb Alan Stern:
> > On Mon, 23 Nov 2009, Rafael J. Wysocki wrote:
> > > On Sunday 22 November 2009, Alan Stern wrote:
> > > > Rafael:
> > > > 
> > > > Here's the situation.  Device A has children B1, ..., Bn (possibly
> > > > others too).  I need to guarantee that whenever A is active, so are the
> > > > children.
> > >
> > > 
> > > But it's perfectly valid to have an inactive device under an active
> > > parent, so I guess this is not a general case.
> > 
> > Correct.  It's a specific case that I need to handle for USB.
> 
> Hm. In which way is this different from a system where devices
> share clock lines? It seems to me that groups of devices that
> can be suspended only together are not rare. That in USB these
> devices happen to be all a device's interfaces does not really
> matter.

That's not a good example because there's nothing wrong with suspending
some of the devices while leaving the clock and the others running.  
You'll have to search harder to find a group of devices which really do 
need to be suspended all together.

Alan Stern
