From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 10:42:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28730825533184046=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============28730825533184046==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 5 Jan 2006, Patrick Mochel wrote:

> On Fri, 6 Jan 2006, Pavel Machek wrote:
> 
> > On 05-01-06 16:04:07, Patrick Mochel wrote:
> 
> > > A better point, and one that would actually be useful, would be to remove
> > > the file altogether. Let Dominik export a power file, with complete
> > > control over the values, for each pcmcia device. Then you never have to
> > > worry about breaking PCMCIA again.
> >
> > Fine with me.
> 
> ACK, you beat me to it.
> 
> And, appended is a patch to export PM controls for PCI devices. The file
> "pm_possible_states" exports the states a device supports, and "pm_state"
> exports the current state (and provides the interface for entering a
> state).
> 
> Eventually, some drivers will want to fix up those values so that it can
> mask of states that it doesn't support, as well as offer possible device-
> specific states.
> 
> What's interesting is that with this patch, I can see that two more
> devices on my system support D1 and D2 -- the cardbus controllers, which
> are actually bridges whose PM capabilities aren't exported via lspci.

This trend is extremely alarming!!

It's a very bad idea to make bus drivers export and manage the syfs power 
interface.  It means that lots of code gets repeated and different buses 
do things differently.

Already we have PCI exporting "pm_possible_states" and "pm_state" while 
PCMCIA exports "suspend".  How many other different schemes are going to 
crop up?  How much bus-specific information will have to be built into a 
user utility?

If possible states are represented as arrays of pointers to strings, then 
the PM core can easily supply the sysfs interface.  If Patrick's patch 
were re-written so that the sysfs interface were moved into the PM core, 
leaving only the PCI-specific portions in the PCI drivers, I would be much 
happier.  This would also mean that Dominik's patch could be replaced by 
something a good deal smaller.

And it wouldn't hurt to add some mechanism for indicating which of the 
possible states is the generic "suspend" state (usually D3 for PCI 
devices, but not necessarily).

Alan Stern



--===============28730825533184046==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28730825533184046==--
