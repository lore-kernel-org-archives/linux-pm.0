From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 10:09:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902181006150.3186-100000__46212.3681827963$1234970294$gmane$org@iolanthe.rowland.org>
References: <20090218065158.5efa8536@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090218065158.5efa8536@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Feb 2009, Arjan van de Ven wrote:

> On Wed, 18 Feb 2009 09:53:48 +0100
> Oliver Neukum <oliver@neukum.org> wrote:
> =

> > Am Wednesday 18 February 2009 00:26:53 schrieb Rafael J. Wysocki:
> > > > Another possibility is to set up independent runtime PM for the
> > > > transport and the device. =C2=A0This means allowing the possibility
> > > > that the transport is suspended while its child (the device) is
> > > > not. =C2=A0This is a little simpler (there's only one idle-timeout =
per
> > > > device, since the link is treated as an independent device), but
> > > > it violates the principle of never suspending a parent while
> > > > there is an active child.
> > > =

> > > Well, I think the first approach would be better.
> > =

> > I am afraid it wouldn't be. How do you deal with shared transports?
> > =

> =

> realistically, something like this you need to design like this
> Step 1) Assume the hardware is smart and can do this for you on the fly,
>         but it might need guidance.
>         (For many busses there are platforms that do this)
> Step 2) For hardware that is not smart, emulate the smartness in the
>         driver, with help of the subsystem. These two together have
>         the right knowledge to make such decisions.

Arjan, you're missing the point.  This part of the discussion is =

already focussed on your Step 2.  The question we are concerned with =

is: _How_ shall the driver and subsystem go about emulating the =

smartness?

Oliver's comment is a good one.  The principle of not suspending a
parent with active children has never been set in stone; with care we
should be able to circumvent it.

Alan Stern
