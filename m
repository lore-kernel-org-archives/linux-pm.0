From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Mon, 2 Apr 2007 14:31:04 -0700
Message-ID: <200704021431.05096.david-b__21626.3251183138$1175549495$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704021124.21926.david-b@pacbell.net>
	<20070402194039.GA8044@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070402194039.GA8044@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 02 April 2007 12:40 pm, Matthew Garrett wrote:
> On Mon, Apr 02, 2007 at 11:24:21AM -0700, David Brownell wrote:
> =

> > I don't follow this at all.  Most of the relevant devices have a PCI
> > device driver, not an ACPI device driver.  Surely you aren't proposing
> > that PCI drivers should incorporate lots of ACPI-specific code (which
> > won't be useful on non-ACPI platforms) before they start to work right?
> =

> PCI devices have a handle to their ACPI object in platform_data,

Good to know.  I was under the impression that was still in the
planning stage, not yet the working/reliable stage.  But I do see
some ACPI code doing that; maybe I'll take more of a look.


> so it's  =

> easy enough to have generic code that interacts with both objects.

Well, not really "generic" if it knows about ACPI.
But at least not device-specific.


> > For a PCI device driver, pci_enable_wake() is all the hook that it shou=
ld
> > ever need.  If ACPI magic is needed, it should be called from inside th=
at
> > routine.
> =

> Yeah, I don't see that being a problem.

Except for not yet working that way! ;)

- Dave
