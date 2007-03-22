From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 16:32:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703221626540.4990-100000@iolanthe.rowland.org>
References: <200703221220.09679.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221220.09679.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007, David Brownell wrote:

> On Wednesday 21 March 2007 2:39 pm, Pavel Machek wrote:
> =

> > > > USB gets the dependencies right, just copy that.
> > > Does USB include all kinds of dependence, eg non parent-children
> > > dependence?
> > =

> > No, probably not, as USB was designed properly.
> =

> It was designed to work with as few wires as possible:  "minimalist"
> design.  That's not the same as "proper"; not everything works with
> the same design constraints.

Sort of an off-topic side issue:  One of the aspects of USB that I have
found surprisingly "improper" is the way it handles remote wakeup.  =

According to the USB spec, when a device sends a remote wakeup request to
its parent hub, the hub _has_ to resume the device -- or if the hub is
also suspended, it has to pass the wakeup request on up to its own parent,
all the way back to the host computer if necessary.

The point is, the wakeup request must be honored (and fairly quickly,
too); the spec doesn't allow the parent to keep the device suspended.  =

Although presumably nothing terribly bad would happen if it did.

Alan Stern
