From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/9] PCI PM: Handling of PCI devices wake-up
	functionality (rev. 3)
Date: Thu, 3 Jul 2008 14:04:57 +0200
Message-ID: <200807031404.58108.rjw@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807012356.26669.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Tobias Diedrich <ranma@tdiedrich.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of July 2008, Rafael J. Wysocki wrote:
> Hi,
> 
> This is a new (3rd) iteration of the series of patches intended to rework the power
> management of PCI devices so that the handling of their wake-up functionality
> is consistent with the other PM operations and so that the user space can
> manage the wake-up functionality of PCI devices using the
> /sys/devices/.../power/wakeup interface regardless of whether the wake-up
> function is based on the native PCI mechanism (PME#), or it is handled by the
> platform (eg. ACPI).
> 
> Apart from the ACPI and PCI changes necessary for this purpose, the series
> includes some clean-ups that are not strictly required, but make the code more
> straightforward and (IMHO) easier to follow.
> 
> The patchset is on top of the linux-next from today.  It contains one
> additional patch [1/9] which is a revert of another patch that shouldn't have
> been put into linux-next (at least not in the way it was done).
> 
> Please review.

FWIW, I have tested this patchset on top of the yesterday's linux-next on a box
with the Asus A8N SLI mainboard and the WOL using Magic Packet works after
hibernation (forcedeth driver).

Full dmesg including boot and one hibernation/resume cycle is at:
http://www.sisk.pl/kernel/debug/20080702/dmesg-A8N-SLI.log

Thanks,
Rafael
