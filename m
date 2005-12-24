From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Sat, 24 Dec 2005 01:41:08 +0100
Message-ID: <20051224004108.GD16043@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.44L0.0512231016170.15462-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0512231016170.15462-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On P=E1 23-12-05 10:17:45, Alan Stern wrote:
> On Fri, 23 Dec 2005, Holger Macht wrote:
>=20
> > Hi,
> >=20
> > We implemented device runtime power management in a userspace applica=
tion
> > (the powersave daemon). In this specific case, it means to successive=
ly
> > put pci devices into D3 powersave mode with writing a numerical '3' t=
o the
> > corresponding power state file.
>=20
> > Now that we get more and more votes that this could be very dangerous=
 and
> > problematic because of the current kernel implementation, we decided =
to
> > gather some more comments from involved people and experts in this
> > area. That's the aim of my post to this list. Opinions are welcome!
>=20
> Remember that you're likely to run into trouble if you try to suspend a=
=20
> device that has unsuspended children.

I guess we only want to suspend, leaf PCI devices for now. There's
where the lowest-hanging fruit is.
								Pavel

--=20
Thanks, Sharp!
