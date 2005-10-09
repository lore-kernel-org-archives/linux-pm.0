From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Sun, 9 Oct 2005 22:15:34 +0200
Message-ID: <20051009201534.GC11389@openzaurus.ucw.cz>
References: <20051008170017.GC10865@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0510091044060.27612-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============88425555367088426=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510091044060.27612-100000@netrider.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============88425555367088426==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I think they need to go in one-after-one, anyway... Adding parameter
> > to resume() should definitely be separate patch, because it needs to
> > change all drivers *at once*.  Removing power_state usage can be
> > done incrementally...
> 
> I suppose it could be done like that.  It would mean keeping the
> power_state member in the structure until all the drivers are updated,
> even though the core wouldn't use it any more.

Yes... small price for being able to fix stuff incrementally.

> Another question: Initially most drivers won't set up an array of named
> states.  We could have the core treat such devices as though they were
> using a generic two-entry array: "on" and "suspend".  That would provide
> by default essentially the same functionality we have now, and it would
> allow many drivers to use the new runtime PM scheme with (almost) no
> changes.  Do you see anything wrong with that?

It will be broken for most existing drivers, anyway... I'd only enable
it if driver provided states.

> Third question: Is there a usable PCI core routine for choosing power
> states?  If not, should a PCI ->suspend method usually use the
> lowest-power available state?  I have a feeling this should involve ACPI,
> but it looks like the code hasn't been written yet.

pci_choose_state()? It even has some acpi hooks.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============88425555367088426==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============88425555367088426==--
