From: David Brownell <david-b@pacbell.net>
Subject: Re: Information in PM messages
Date: Tue, 13 Jun 2006 10:25:34 -0700
Message-ID: <200606131025.35106.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606091018160.16847-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606091018160.16847-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday 09 June 2006 7:24 am, Alan Stern wrote:
> On Thu, 8 Jun 2006, David Brownell wrote:
> =

> > > 	A message whose source is USER or DRIVER should not be
> > > 	allowed to resume a device that was suspended by a message
> > > 	whose source was SYSTEM.  In other words, runtime PM and
> > > 	autoresume should not interfere with a system sleep transition.
> > =

> > Why wouldn't that be entirely the driver's responsibility, and
> > something they don't need API changes to achieve?
> =

> Perhaps we don't need to worry about this.
> =

> After all, in most cases it's impossible for a device which is suspended
> as part of a system-sleep transition to get either a runtime-PM resume or
> an autoresume request.  It can only happen in situations where the
> system-sleep did not first freeze all tasks.  In those situations people
> may agree that it is acceptable for the sleep transition to be aborted by
> a user request or an autoresume.
> =

> If that is so then yes, we don't need to alter the PM message structures
> in this way.

I think that's pretty much what I was saying by insisting that the driver's
PM state transitions have to be correct... invalid transtions will always
be invalid, regardless of whether or not the API gets complexified!  :)

- Dave
