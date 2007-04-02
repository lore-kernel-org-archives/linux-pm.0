From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Power Mangement Interfaces
Date: Mon, 2 Apr 2007 20:40:39 +0100
Message-ID: <20070402194039.GA8044__6936.33263367719$1175542897$gmane$org@srcf.ucam.org>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<1175509422.5321.37.camel@localhost.localdomain>
	<200704021124.21926.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704021124.21926.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 02, 2007 at 11:24:21AM -0700, David Brownell wrote:

> I don't follow this at all.  Most of the relevant devices have a PCI
> device driver, not an ACPI device driver.  Surely you aren't proposing
> that PCI drivers should incorporate lots of ACPI-specific code (which
> won't be useful on non-ACPI platforms) before they start to work right?

PCI devices have a handle to their ACPI object in platform_data, so it's =

easy enough to have generic code that interacts with both objects.

> For a PCI device driver, pci_enable_wake() is all the hook that it should
> ever need.  If ACPI magic is needed, it should be called from inside that
> routine.

Yeah, I don't see that being a problem.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
