From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 22:48:32 +0100
Message-ID: <200902162248.34287.rjw__44010.6703703806$1234821187$gmane$org@sisk.pl>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090215164456.34aef7e8@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Arjan van de Ven wrote:
> On Mon, 16 Feb 2009 00:10:15 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > The recent descussion about the Android PM patches sent by Arve shows
> > that there is a need to introduce a mechanism allowing us to:
> > (1) automatically put the system as a whole into a sleep state (eg.
> > suspend to RAM) when it is found to be "idle", where the meaning of
> > "idle" has to be defined too,
> > (2) put given subset of devices into low power states whenever they
> > are not used, without putting the entire system into a sleep state.
> 
> 
> For (2), for me the answer is very obvious:
> 
> The Device Driver needs to make the decision to put the device to sleep.
> There are no ifs and buts about this.
> 
> It's the driver who 
> a) knows if there's any activity, such as open users
> and 
> b) is in the right position to know how to put things to sleep.
> 
> Of course, the subsystem the driver belongs to can provide helpers
> (such as generic activity timeout handlers etc).

While I generally agree, there is a difficulty that the driver itself need not
have control over all of the bits needed to power manage the device.  For
example, we're going to make the PCI bus type handle the changing of PCI
devices' power states, so the registers used for this purpose will be
controlled by the PCI subsystem rather than by individual drivers.

In such cases we may need a mechanism by which the drivers can notify the
higher layer that the device is inactive, so that the higher layer can put it
into a low power state.

> For many cases, the drivers do this today already.
> There are cases where doing this has side effects, mostly in terms of
> latency. It is reasonable to have a general mechanism that provides a
> central mechanism to track tolerable latencies; in fact PMQOS provides
> this on a high level, and I can imagine that PMQOS needs to be extended
> to provide a wider range of type of latencies.

That indeed would be useful.

> Userland should never ever control the state of a device like this
> directly. It should do so by a) closing the device and b) setting
> latency / functional requirements.

The user, however, may want to forcibly put a device into a low power state
without stopping all of the applications that depend on it (eg. have it open).
Do you think that we shouldn't allow users to do such things?

Rafael
