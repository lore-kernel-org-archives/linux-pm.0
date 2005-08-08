From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Re: Runtime PM and device locking
Date: Mon, 8 Aug 2005 17:45:55 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A501851AED@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4853347491604505=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============4853347491604505==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> On Mon, 8 Aug 2005, Alan Stern wrote:
>
> > Tell drivers to 'prepare' for change.  This in some cases means
> > suspending master peripheral DMA operations to DDR.  Next the power
> 
> Master peripheral?  DDR?

Master peripheral: meaning a peripheral which can do DMA to main memory.
This may be using a centralized or private DMA interface.  

DDR just being DDR-SDRAM (double data rate - synchronous dynamic ram).

> > manager does the DVFS switch.  Finally a "post" notification is sent
> 
> DVFS?

Dynamic Voltage Frequency Scaling

> > which allows master drivers to resume their DMA accesses.
> 
> Master drivers?

A driver which controls an entity which can access memory or other
shared resource with out control processor (CPU) intervention.

> > Some devices are part of smarter busses which have some notion of
these.
> > Others don't.  In general you provide the list entries in the
generic
> > structure.  Whether a specific device registers a local call back is
> > something else all together.
> 
> Even without understanding a lot of your terms, I think hat you're
talking
> about comes closer to system PM than runtime PM, in that involves a
> centrally-directed change to an entire subsystem.  It's not a case of
one
> driver deciding its device can be suspended and then propagating that
> information upward.

Yes, I'm talking about what it takes to do runtime power management of
shared clocks.  It at times does take a central coordinator to allow a
clock change.

Devices can auto idle at times or ask for gating of their local clocks.
This is the kind of thing which you must be thinking of.   Along with
idling/gating devices can scale their clocks to save power.

With scaling the CPU is the device which comes to mind first but need
not be the only case.  For many embedded systems, scaling the CPU also
means adjusting device clock notions.  In order to due this you need
coordination.  

A device can also request a clock speed change which also forces the
need for a sub tree recalculation if the request changes a common clock.
Related drivers may be able to react by adjusting local dividers if
given a chance.

> The situation you described involves a new concept: a driver that
cannot
> change its power usage without first asking all its clients to
temporarily
> suspend operations.  Note that the messages you described are not the
same
> kind of "notifications" as I've been talking about, because they go
down
> the tree instead of up.

Yes.  That is true.  I'm presently looking at some clock code, and going
up and down trees is an issue.  There are few possible use cases from
devices wanting a change which requires a notification going up which
cause a change coming back down to other drivers.  

To do run time frequency scaling of the CPU requires a notification
structure down to the drivers.  Why not use the same or extended
structure to propagate clock request from drivers.

Regards,
Richard W.



--===============4853347491604505==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4853347491604505==--
