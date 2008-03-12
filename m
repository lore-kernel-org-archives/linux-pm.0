From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
	callbacks (highest level) - updated
Date: Wed, 12 Mar 2008 22:22:36 +0100
Message-ID: <200803122222.37024.rjw__13926.484125159$1205357141$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803092219290.31643-100000@netrider.rowland.org>
	<200803101758.01826.rjw@sisk.pl>
	<200803120237.24857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803120237.24857.david-b@pacbell.net>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 12 of March 2008, David Brownell wrote:
> On Monday 10 March 2008, Rafael J. Wysocki wrote:
> > + * @poweroff: Hibernation-specific, executed after saving a hibernatio=
n image.
> > + *=A0=A0=A0=A0=A0Quiesce the device, put it into a low power state app=
ropriate for the
> > + *=A0=A0=A0=A0=A0upcoming system state (such as PCI_D3hot), and enable=
 wakeup events as
> > + *=A0=A0=A0=A0=A0appropriate.
> =

> This seems uncomfortably similar to device_driver.shutdown().
> The only obvious difference is wakeup event handling, and even
> that is already a function of the target system state.
> =

> Are both methods needed?
> =

> Shouldn't this be more generic, not "hibernation-specific"?

Well, let's not make restrictions at this point.  There's nothing wrong with
pointing both at the same function and if everyone turns out to do that, we=
'll
remove one callback.

Thanks,
Rafael
