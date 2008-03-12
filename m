From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
	callbacks (highest level) - updated
Date: Wed, 12 Mar 2008 01:37:24 -0800
Message-ID: <200803120237.24857.david-b__35778.34174871$1205314873$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803092219290.31643-100000@netrider.rowland.org>
	<200803101758.01826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803101758.01826.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Monday 10 March 2008, Rafael J. Wysocki wrote:
> + * @poweroff: Hibernation-specific, executed after saving a hibernation =
image.
> + *=A0=A0=A0=A0=A0Quiesce the device, put it into a low power state appro=
priate for the
> + *=A0=A0=A0=A0=A0upcoming system state (such as PCI_D3hot), and enable w=
akeup events as
> + *=A0=A0=A0=A0=A0appropriate.

This seems uncomfortably similar to device_driver.shutdown().
The only obvious difference is wakeup event handling, and even
that is already a function of the target system state.

Are both methods needed?

Shouldn't this be more generic, not "hibernation-specific"?
