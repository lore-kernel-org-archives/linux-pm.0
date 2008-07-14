From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: PCI PM: Fix pci_prepare_to_sleep
Date: Mon, 14 Jul 2008 14:27:33 -0700
Message-ID: <200807141427.34022.jbarnes@virtuousgeek.org>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
	<200807132245.07414.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807132245.07414.rjw@sisk.pl>
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
Cc: Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, July 13, 2008 1:45 pm Rafael J. Wysocki wrote:
> Hi Jesse,
>
> The recently introduced pci_prepare_to_sleep() needs the following fix,
> because there are systems which are not power manageable by ACPI (ie. ACPI
> doesn't provide methods to put the device into low power states and back),
> but require ACPI hooks to be executed for wake-up to work.
>
> Please apply.
>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Fix pci_prepare_to_sleep() to work on systems that are not power
> manageable by ACPI (ie. ACPI doesn't provide methods to put the
> device into low power states and back into the full power state), but
> require ACPI hooks to be executed for wake-up to work.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Based on what you've told me so far about the number of ACPI vs. native wakeup 
methods & problems, I'm starting to get a little worried that making this 
stuff work right will require lots of platform specific quirks.  I guess 
that's just par for the course though, and this patch looks fine, so I just 
applied it to my linux-next branch.

Thanks,
Jesse
