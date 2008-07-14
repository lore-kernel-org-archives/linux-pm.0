From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PCI PM: Fix pci_prepare_to_sleep
Date: Mon, 14 Jul 2008 23:40:04 +0200
Message-ID: <200807142340.05484.rjw__34680.1053187393$1216071611$gmane$org@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl> <200807132245.07414.rjw@sisk.pl>
	<200807141427.34022.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807141427.34022.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of July 2008, Jesse Barnes wrote:
> On Sunday, July 13, 2008 1:45 pm Rafael J. Wysocki wrote:
> > Hi Jesse,
> >
> > The recently introduced pci_prepare_to_sleep() needs the following fix,
> > because there are systems which are not power manageable by ACPI (ie. ACPI
> > doesn't provide methods to put the device into low power states and back),
> > but require ACPI hooks to be executed for wake-up to work.
> >
> > Please apply.
> >
> > Thanks,
> > Rafael
> >
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Fix pci_prepare_to_sleep() to work on systems that are not power
> > manageable by ACPI (ie. ACPI doesn't provide methods to put the
> > device into low power states and back into the full power state), but
> > require ACPI hooks to be executed for wake-up to work.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Based on what you've told me so far about the number of ACPI vs. native wakeup 
> methods & problems, I'm starting to get a little worried that making this 
> stuff work right will require lots of platform specific quirks.

Yes, this is likely.

Also, having looked at several network adapters' suspend and resume routines,
I think we'll need to do some fine tuning here and there.

> I guess that's just par for the course though, and this patch looks fine, so
> I just applied it to my linux-next branch.

Thanks!

Rafael
