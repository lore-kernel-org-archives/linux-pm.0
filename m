From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Wed, 11 Feb 2009 23:26:22 +0100
Message-ID: <200902112326.23637.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0902082148420.24968-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902082148420.24968-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 February 2009, Alan Stern wrote:
> On Sun, 8 Feb 2009, Arve Hj=F8nnev=E5g wrote:
> =

> > How do you handle devices that should be in a low power mode when
> > closed, and a high(er) power mode when open. While adding
> > early-suspend hooks to a driver may be ugly, it does not need any more
> > support than open and close does.
> =

> This illustrates some of the problems of differing outlooks.  In an =

> embedded system, the set of devices is limited and the set of available =

> power states is known beforehand.  In other settings neither of these =

> is true.
> =

> Early-suspend is an example of a partially-functional system state.  =

> In your Android-centric approach, early-suspend is centered around the =

> screen.  But other sorts of systems way well have other requirements =

> and may want their partially-functional system state to be centered =

> around something else.  Or they may want to have more than one =

> partially-functional system state.
> =

> What we need is a mechanism capable of accomodating all these different
> requirements.  Presumably the core kernel would provide the hooks but
> the implementation details would be left up to platform-specific code.  =

> There should be a generic scheme for representing partially-functional
> system states, together with a list of devices to be put in low-power
> mode for each state and an indication of which low-power mode to use
> (since a device can have more than one low-power mode).  Device drivers
> should have an interface for going into a particular low-power state.
> =

> The extent to which all of this needs to be split between the kernel
> and userspace isn't immediately clear.  Latency issues might force a
> large part of it to live in the kernel.  On the other hand, if the list
> of devices & modes can be pushed out to userspace, then the in-kernel
> portion could end up being nothing more than a runtime-PM mechanism of
> the sort we have been discussing for years.

Agreed.

Thanks,
Rafael
