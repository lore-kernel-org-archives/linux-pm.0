From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 15:30:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011528230.2034-100000__48968.3205647909$1299011566$gmane$org@iolanthe.rowland.org>
References: <AANLkTik5HVxoOCH1ZVj50nUsCA5E04Y0J0RaWw7_KyKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik5HVxoOCH1ZVj50nUsCA5E04Y0J0RaWw7_KyKw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> >> > Other drivers do it, but they use PCI PME# instead of interrupts.
> >> Could you please elaborate?
> >> My understanding is that PCI PME will generate MSI, which translate in
> >> interrupt.
> >
> > It depends on the platform. =A0On systems with ACPI, PCI PME generates =
an
> > ACPI I/O event, which is handled by the ACPI and PM cores. =A0It does n=
ot
> > invoke the device driver's interrupt handler.
> So, let's say, in the ACPI case, if the interrupt handler dont get
> called, how would the driver know that he got a sdcard insert event,
> and trigger a mmc_rescan() ?

When the ACPI and PCI cores process the PME event, they call
pm_runtime_resume().  The driver's runtime_resume routine would read
the device status and see the insert event, which would cause it to
trigger mmc_rescan().

Alan Stern
