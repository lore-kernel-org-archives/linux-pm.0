From: Greg KH <greg@kroah.com>
Subject: Re: Power management for SCSI
Date: Fri, 15 Aug 2008 22:24:44 -0700
Message-ID: <20080816052444.GA20161@kroah.com>
References: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
	<200808151756.28313.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808151756.28313.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 15, 2008 at 05:56:27PM +0200, Oliver Neukum wrote:
> Am Freitag 15 August 2008 17:25:13 schrieb Alan Stern:
> > On Fri, 15 Aug 2008, Oliver Neukum wrote:
> > =

> > > Am Freitag 15 August 2008 00:25:28 schrieb Alan Stern:
> > > > On Thu, 14 Aug 2008, Oliver Neukum wrote:
> > > > =

> > > > > The core problem is that you insist on a rigid bottom-to-top flow=
 of
> > > > > autosuspensions. That's good for systems like USB and PCI which
> > > > > are trees for PM purposes. It makes no sense for true busses with
> > > > > equal members on the bus.
> > > > =

> > > > My framework is tree-oriented because it's based on the driver mode=
l, =

> > > > which uses a tree of devices.
> > > =

> > > Which uses a tree because PCI and USB are.
> > =

> > How do you know? =A0Is that just a guess based on some of Greg KH's and
> > Pat Mochel's previous activities? =A0Did you ask them?
> =

> Greg,
> =

> do you remember?

I'm not quite sure what you are asking here.

Is it why the driver model uses a tree instead of something else?  If
so, what else would it use?

We have a tree because that fits the types of devices we support.  And
on some of them, the children are "equal" members at the same level,
right?  This is true even for PCI and USB.

The current model structure came out of the trees of devices that we had
before the driver model.  ACPI and openfirmware described systems of
devices in a tree, as does PNP I think.  USB and PCI had trees, and so
did SCSI to a point.  USB and PCI were the first two subsystems to use
the driver model, so it does reflect a lot of what those two busses
required.

Or am I confused as to what you are asking?

thanks,

greg k-h
