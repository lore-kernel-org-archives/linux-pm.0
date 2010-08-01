From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 13:11:17 -0700
Message-ID: <20100801201117.GO2470__1338.60411956466$1280693538$gmane$org@linux.vnet.ibm.com>
References: <20100801043610.GF2470@linux.vnet.ibm.com>
	<Pine.LNX.4.44L0.1008011521390.20420-100000@netrider.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1008011521390.20420-100000@netrider.rowland.org>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 01, 2010 at 03:41:57PM -0400, Alan Stern wrote:
> > > > o	"Power-aware application" are applications that are permitted
> > > > 	to acquire suspend blockers on Android.  Verion 8 of the
> > > > 	suspend-blocker patch seems to use group permissions to determine
> > > > 	which applications are classified as power aware.
> > > > 
> > > > 	More generally, power-aware applications seem to be those that
> > > > 	have permission to exert some control over the system's
> > > > 	power state.
> > > 
> > > Notice that these definitions allow a program to be both power-naive
> > > and power-aware.  In addition, "power-awareness" isn't an inherent
> > > property of the application itself, since users are allowed to decide
> > > which programs may exert control over the system's power state.  The 
> > > same application could be power-aware on one system and non-power-aware 
> > > on another.
> 
> I should have made a stronger point: "power-aware" is _not_ a good
> term for these applications.  "power-enabled" would be better but
> still not ideal.  Maybe "power-permitted"?  The definition is that
> they are _permitted_ to do something (acquire suspend blockers), not
> that they actually _do_ something.

How about "PM-driving applications", as Rafael suggested?

> > > > REQUIREMENTS
> > > > 
> > > > o	Reduce the system's power consumption in order to (1) extend
> > > > 	battery life and (2) preserve state until AC power can be obtained.
> > > 
> > > External power, not necessarily AC power (a very minor point).
> > 
> > A good one, though.
> 
> Arjan's point here is well taken.  Even systems that always run on
> external power have motivation for conserving energy (e.g., they may
> be required by government regulation to do so).

Indeed!  However, my observation is that many of the battery-powered
embedded folks are much more aggressive in pursuit of energy efficiency
than are most of the server/desktop/laptop folks.  Both have motivation,
but the degree of motivation can differ.

> > > > o	In order to avoid overrunning hardware and/or kernel buffers,
> > > > 	input events must be delivered to the corresponding application
> > > > 	in a timely fashion.  The application might or might not be
> > > > 	required to actually process the events in a timely fashion,
> > > > 	depending on the specific application.
> > > 
> > > This goes well beyond overrunning buffers!  Events must be delivered in
> > > a timely fashion so that the system isn't perceived to be inoperative.
> > 
> > Agreed for power-aware applications.  For power-naive applications,
> > the last event delivered can be buffered by the application with no
> > response if I understand correctly.  If there is a subsequent event
> > for that same application, then the prior event can be processed.
> 
> I was agreeing with the requirement but disagreeing with the reason
> given for it.  Even when buffers are large enough that the danger of
> overrunning them is infinitesimal, delays in input event delivery are
> still undesirable.
> 
> Besides, the Android kernel doesn't vary its behavior based on whether
> the recipient is power-permitted or power-naive; it _always_ delivers
> input events in a timely fashion.

True, the difference between the two classes of applications is in
whether or not the application is permitted to process the event.

I added "and to minimize response latencies" to the requirement.
Does that capture it?

> > > > o	If a power-aware application receives user input, then that
> > > > 	application must be given the opportunity to process that
> > > > 	input.
> > > 
> > > A better way to put this is: The API must provide a means for
> > > power-aware applications receiving user input to keep themselves
> > > running until they have been able to process the input.
> > 
> > Good point!  Would it also make sense to say "events" in general rather
> > than "input" in particular?
> 
> Sure.

K, done.

> > > > o	Power-naive applications must be prohibited from controlling
> > > > 	the system power state.  One acceptable approach is through
> > > > 	use of group permissions on a special power-control device.
> > > 
> > > You mean non-power-aware applications, not power-naive applications.  
> > > But then the statement is redundant; it follows directly from the
> > > definition of "power-aware".
> > 
> > I see your point, but I don't feel comfortable deleting this requirement.
> > My rationale is that the definition needs some enforcement mechanism,
> > and this requirement is calling out the need for such a mechanism.
> 
> Then state it immediately after the definition as an implication of
> the definition, not as a separate system requirement.

I am OK with that, and have moved it.

> > > > o	When a power-aware application is preventing the system from
> > > > 	shutting down, and is also waiting on a power-naive application,
> > > > 	the power-aware application must set a timeout to handle
> > > > 	the possibility that the power-naive application might halt
> > > > 	or otherwise fail.  (Such timeouts are also used to limit the
> > > > 	number of kernel modifications required.)
> > > 
> > > No, this is not a requirement.  A power-optimized application would do 
> > > this, of course, by definition.  But a power-aware application doesn't 
> > > have to.
> > 
> > I am not sure we agree on the definition of "power-optimized application".
> > But leaving that aside, I thought that Arve and Brian explicitly
> > stated this as a requirement on power-aware applications -- one of the
> > responsibilities that came with the power to block suspend.
> 
> No.  There are _no_ requirements on power-permitted (or power-aware if
> you prefer) applications, other than that the user decides to give it
> the appropriate permission.
> 
> Internally, of course, Android may enforce this rule on their own
> software.  But it has no force in regard to external applications.

So should this be moved to a new "ANDROID POLICY" section or some such?

> > > > o	If no power-aware or power-optimized application are indicating
> > > > 	a need for the system to remain operating, the system is permitted
> > > > 	(even encouraged!) to suspend all execution, even if power-naive
> > > > 	applications are runnable.  (This requirement did appear to be
> > > > 	somewhat controversial.)
> > > 
> > > The controversy was not over the basic point but rather over the 
> > > detailed meaning of "runnable".  A technical matter, related to the 
> > > implementation of the scheduler.
> > 
> > OK, what would you suggest for the wording of this requirement?
> 
> Change the last phrase to "regardless of the state of power-naive
> applications".

Done!

							Thanx, Paul
