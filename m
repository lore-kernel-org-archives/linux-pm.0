From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Fri, 21 Mar 2008 17:23:16 +0100
Message-ID: <200803211723.17685.rjw__6187.91365200213$1206116853$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
	<200803210247.18686.rjw@sisk.pl>
	<200803210115.04210.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210115.04210.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 21 of March 2008, David Brownell wrote:
> On Thursday 20 March 2008, Rafael J. Wysocki wrote:
> > Is there any reason why pci_choose_state() should try to figure out wha=
t kind
> > of operation is being performed by the driver and tailor its output to =
that?
> =

> It's always been specified to do that ... but it's always done
> that in a buggy way.  (Which is why USB never used it.)

I hope you realize that your change will affect all drivers calling
pci_choose_state() on ACPI systems on FREEZE/PRETHAW in a hard to predict
way?  Perhaps some of them actually rely on getting D3hot on FREEZE, for
example?

> > I don't think so. =A0Rather, the driver should know what it's doing and=
 either
> > call pci_choose_state() or not. =A0If the state of the device is not to=
 be
> > changed, there's no reason to call pci_choose_state() at all.
> =

> You seem to object to letting drivers offload this particular
> bit of work to infrastructure.

No, I don't.  I just don't think it's a good idea to change the existing and
widely used function for this purpose.  If I needed some specific functiona=
lity
at the infrastructure level, I'd add a new function for that with a new
changelog etc.  Then, made drivers switch to that and remove the old one.

> What's the dividing line between being OK to offload vs not eing OK?  Why=
 not
> let the drivers make that choice?
> =

> =

> > 	[Note that with the new suspend/hibernation callbacks there
> > won't be the pm_message_t argument to pass to pci_choose_state().]
> =

> The pm_message_t will necessarily linger until all drivers have
> been converted and re-tested.  Which can't be an overnight thing.

No, it can't.  Still, suppose a driver is using the new callbacks.  How is =
it
supposed to use pci_choose_state()?

Rafael
