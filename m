From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Thu, 6 Oct 2005 13:00:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510061257170.6024-100000@iolanthe.rowland.org>
References: <200510051624.40033.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70924721833354187=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510051624.40033.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============70924721833354187==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 5 Oct 2005, David Brownell wrote:

> On Wednesday 05 October 2005 12:44 am, Adam Belay wrote:
> > On Tue, Oct 04, 2005 at 11:04:35PM -0700, David Brownell wrote: 
> > > 
> > > The PM core should just tell drivers to become compatible with some
> > > new constraint (like ACPI S3, generally implying devices in PCI D2
> > > or D3; while S1 doesn't) ... and not worry about whether that involves
> > > a state change or not.
> > > 
> > > Maybe they're already _in_ that state for example.
> > 
> > Yeah, the thought occurred to me.  One way of approaching the problem is to
> > have the PM core use logical states such as the following:
> > 
> > 1.) ON
> > 2.) FREEZE
> > 3.) SUSPEND
> > 
> > others?
> > 
> > This is similar to our current implementation.
> 
> Which is a problem, as I've described before.  The logical states
> must be system-specific.  Some systems have more states than just
> those three ... and in particular, the states have ** SOLID **
> and ** PRECISE ** definitions.  Unlike those three.
> 
> At the risk of sounding like a broken record, I'll give the
> same example I've given before:  some states may not support
> particular clocks, like the 48 MHz USB clock.  So the driver
> needs to know which ** PRECISE ** system-specific state is
> being entered ... so it can turn off the clock if need be.

We can make it easy for a platform to define new or extra system states.  
Things like ON, FREEZE, and SUSPEND can be represented by new PM_EVENT_xxx
codes, which the relevant drivers would understand.  Other drivers would
have to be smart enough to ignore the any event codes they don't
recognize.

Alan Stern


--===============70924721833354187==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70924721833354187==--
