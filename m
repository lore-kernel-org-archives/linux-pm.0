From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 18:16:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008011810300.22928-100000__22760.7992165305$1280701090$gmane$org@netrider.rowland.org>
References: <20100801201117.GO2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801201117.GO2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, 1 Aug 2010, Paul E. McKenney wrote:

> > I should have made a stronger point: "power-aware" is _not_ a good
> > term for these applications.  "power-enabled" would be better but
> > still not ideal.  Maybe "power-permitted"?  The definition is that
> > they are _permitted_ to do something (acquire suspend blockers), not
> > that they actually _do_ something.
> 
> How about "PM-driving applications", as Rafael suggested?

Perhaps.  But it's a little misleading, since what these applications
are permitted to do is to _prevent_ the system from going to low power.  
So in a real sense they don't drive PM -- they block it.  (Indeed,
that's what inspired the name "suspend blocker".)  Of course, the same 
objection applies to "power-permitted".

> > I was agreeing with the requirement but disagreeing with the reason
> > given for it.  Even when buffers are large enough that the danger of
> > overrunning them is infinitesimal, delays in input event delivery are
> > still undesirable.
> > 
> > Besides, the Android kernel doesn't vary its behavior based on whether
> > the recipient is power-permitted or power-naive; it _always_ delivers
> > input events in a timely fashion.
> 
> True, the difference between the two classes of applications is in
> whether or not the application is permitted to process the event.
> 
> I added "and to minimize response latencies" to the requirement.
> Does that capture it?

Yes.

> > > But leaving that aside, I thought that Arve and Brian explicitly
> > > stated this as a requirement on power-aware applications -- one of the
> > > responsibilities that came with the power to block suspend.
> > 
> > No.  There are _no_ requirements on power-permitted (or power-aware if
> > you prefer) applications, other than that the user decides to give it
> > the appropriate permission.
> > 
> > Internally, of course, Android may enforce this rule on their own
> > software.  But it has no force in regard to external applications.
> 
> So should this be moved to a new "ANDROID POLICY" section or some such?

Or DESIRED BEHAVIOR, or some such.

Alan Stern
