From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/11] PCI PM: Handling of PCI devices wake-up
	functionality
Date: Wed, 25 Jun 2008 15:05:08 -0700
Message-ID: <200806251505.08603.jbarnes@virtuousgeek.org>
References: <200806231934.08565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806231934.08565.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 23, 2008 10:34 am Rafael J. Wysocki wrote:
> Hi,
>
> The purpose of the following series of patches is to rework the power
> management of PCI devices so that the handling of their wake-up
> functionality is consistent with the other PM operations and so that the
> user space can manage the wake-up functionality of PCI devices using the
> /sys/devices/.../power/wakeup interface regardless of whether the wake-up
> function is based on the native PCI mechanism (PME#), or it is handled by
> the platform (eg. ACPI).
>
> Apart from the ACPI and PCI changes necessary for this purpose, the series
> includes some clean-ups that are not strictly required, but make the code
> more straightforward and (IMHO) easier to follow.
>
> Please review.

This patchset looks really nice, and makes pci_enable_wake and such much more 
readable, IMO.  How much testing has it seen?  Do you think it's appropriate 
for 2.6.27?

Thanks,
Jesse
