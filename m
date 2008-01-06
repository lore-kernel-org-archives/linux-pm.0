From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/7] Suspend: Introduce open() and
	close() callbacks
Date: Sun, 6 Jan 2008 14:15:46 +0100
Message-ID: <200801061415.47557.rjw__24328.3641328619$1199625303$gmane$org@sisk.pl>
References: <200801052332.44500.rjw@sisk.pl> <200801052338.52923.rjw@sisk.pl>
	<200801051631.19629.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801051631.19629.david-b@pacbell.net>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 6 of January 2008, David Brownell wrote:
> On Saturday 05 January 2008, Rafael J. Wysocki wrote:
> > + * @open: Initialise a transition to given system sleep state.
> > + *=A0=A0=A0=A0=A0@open() is executed right prior to suspending devic=
es. =A0The information
> > + *=A0=A0=A0=A0=A0conveyed to the platform code by @open() should be =
disregarded by it as
> > + *=A0=A0=A0=A0=A0soon as @close() is executed. =A0If @open() fails (=
ie. returns nonzero),
> > =A0 *=A0=A0=A0=A0=A0@prepare(), @enter() and @finish() will not be ca=
lled by the PM core.
> > =A0 *=A0=A0=A0=A0=A0This callback is optional. =A0However, if it is i=
mplemented, the argument
> > =A0 *=A0=A0=A0=A0=A0passed to @enter() is meaningless and should be i=
gnored.
>                                 ^^^^^^^^^^^
> Surely this should say "redundant", not "meaningless"?  =20
>=20
>=20
> > + * @close: Called by the PM core right after resuming devices, to in=
dicate to
> > + *=A0=A0=A0=A0=A0the platform that the system has returned to the wo=
rking state.
>=20
> Or the state transition has aborted ...
>=20
> > + *=A0=A0=A0=A0=A0This callback is optional, but should be implemente=
d by the platforms
> > + *=A0=A0=A0=A0=A0that implement @open().
>=20
> "..., but platforms which implement @open() should also provide a @clos=
e()
> which cleans up transitions which aborted before @enter()."
>=20
> Otherwise it seems rather unclear why this exists, since all platforms =
know
> that things are "normal" as soon as enter() gets back from its transiti=
on.
> (What can I say ... I like to see things be clear!)  Yes, systems may d=
o more
> than that when it gets this call; but the minimum involves just that cl=
eanup.

Thanks for the comments.  They will be taken into account in the final ve=
rsion
of the patch.

Greetings,
Rafael
