From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: Re: Runtime PM and device locking
Date: Mon, 8 Aug 2005 18:17:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508081809130.4470-100000@iolanthe.rowland.org>
References: <EA12F909C0431D458B9D18A176BEE4A5017B6CC0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72224346499362824=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5017B6CC0@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============72224346499362824==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 8 Aug 2005, Woodruff, Richard wrote:

> > (Not to mention the
> > fact that in any particular case we never need both pre- and post-
> > notifications.)
> 
> For voltage and frequency scaling in embedded devices we defiantly have
> used both pre and post notifications.
> 
> Tell drivers to 'prepare' for change.  This in some cases means
> suspending master peripheral DMA operations to DDR.  Next the power

Master peripheral?  DDR?

> manager does the DVFS switch.  Finally a "post" notification is sent

DVFS?

> which allows master drivers to resume their DMA accesses.

Master drivers?

> Some devices are part of smarter busses which have some notion of these.
> Others don't.  In general you provide the list entries in the generic
> structure.  Whether a specific device registers a local call back is
> something else all together.

Even without understanding a lot of your terms, I think hat you're talking
about comes closer to system PM than runtime PM, in that involves a
centrally-directed change to an entire subsystem.  It's not a case of one
driver deciding its device can be suspended and then propagating that
information upward.

The situation you described involves a new concept: a driver that cannot 
change its power usage without first asking all its clients to temporarily 
suspend operations.  Note that the messages you described are not the same 
kind of "notifications" as I've been talking about, because they go down 
the tree instead of up.

Alan Stern


--===============72224346499362824==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72224346499362824==--
