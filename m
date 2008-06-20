From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH 0/3] PCI PM: Rework pci_set_power_state
Date: Fri, 20 Jun 2008 01:45:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200143250.22284__32977.3178943016$1213941078$gmane$org@localhost.localdomain>
References: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200806170206.26616.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org



> I've recently discovered that pci_set_power_state() calls the platform
> callback intended for changing the state of the device after it has done
> that using the native PCI mechanism.  In my opinion this is not correct,
> because, for example, if the device is being put into D0 from a low power
> state, it may require some platform-controlled power resources to be turned
> on before that (in theory).
> 
> The following series of patches changes this function so that the platform
> callback is performed first and then the native mechanism is used.
> Additionally, however, it checks if the devices is power manageable by the
> platform and only in that case the platform callback is invoked.  For this
> purpose, I needed to add an ACPI function allowing PCI to check the power
> manageability of given device.

We have 3 cases
1. device has PCI PM only
2. device has ACPI PM only
3. device has both PCI and ACPI PM

For #1 and #2, order is moot.
For #3, how can we be sure that the new order is better than the old 
order?  Is this a theoretical patch, or is there a failure case?

thanks,
-Len
