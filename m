From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Power management for SCSI
Date: Fri, 15 Aug 2008 17:56:27 +0200
Message-ID: <200808151756.28313.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
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
Cc: Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag 15 August 2008 17:25:13 schrieb Alan Stern:
> On Fri, 15 Aug 2008, Oliver Neukum wrote:
> =

> > Am Freitag 15 August 2008 00:25:28 schrieb Alan Stern:
> > > On Thu, 14 Aug 2008, Oliver Neukum wrote:
> > > =

> > > > The core problem is that you insist on a rigid bottom-to-top flow of
> > > > autosuspensions. That's good for systems like USB and PCI which
> > > > are trees for PM purposes. It makes no sense for true busses with
> > > > equal members on the bus.
> > > =

> > > My framework is tree-oriented because it's based on the driver model, =

> > > which uses a tree of devices.
> > =

> > Which uses a tree because PCI and USB are.
> =

> How do you know? =A0Is that just a guess based on some of Greg KH's and
> Pat Mochel's previous activities? =A0Did you ask them?

Greg,

do you remember?

	Regards
		Oliver
