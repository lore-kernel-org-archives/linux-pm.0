From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Wed, 4 Apr 2007 22:05:27 -0700
Message-ID: <200704042205.28200.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704041144.15300.david-b@pacbell.net>
	<1175723399.7388.47.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175723399.7388.47.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 04 April 2007 2:49 pm, Johannes Berg wrote:
> On Wed, 2007-04-04 at 11:44 -0700, David Brownell wrote:
> =

> > I'm not sure I understand the question.  ACPI has a special "acpi_devic=
e"
> > node (not backed by any "real" device, PNPACPI etc) with a driver that
> > hooks up to the input subsystem.  Same is true for a couple other fixed
> > function buttons.  I'd expect non-ACPI platforms would do something very
> > similar, except using platform_device and looking less cryptic.
> =

> No, the thing is more: how would we represent the lid as a device in
> sysfs? =


As a platform_device.


> Currently, our PMU only has a sysdev because it doesn't need =

> more. Would you suggest doing a PMU-bus and than hanging "lid" off of
> that?

Avoid doing a new bus_type unless you **really, really** need one.

- Dave
