From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Introduce function pci_wake_from_d3
	(rev. 2)
Date: Wed, 27 Aug 2008 16:04:59 -0700
Message-ID: <200808271605.01006.jbarnes__21902.6442071938$1219880829$gmane$org@virtuousgeek.org>
References: <200808182057.22501.rjw@sisk.pl> <200808182138.00989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808182138.00989.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 18, 2008 12:38 pm Rafael J. Wysocki wrote:
> [Sorry, it is more useful to define the function so that it takes a second
> argument indicating whether to enable or disable wake-up.]
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> PCI PM: Introduce function pci_wake_from_d3 (rev. 2)
>
> Many device drivers use the following sequence of statements to
> enable the device to wake up the system while being in the D3_hot
> or D3_cold low power state:
>
> 	pci_enable_wake(pdev, PCI_D3hot, 1);
> 	pci_enable_wake(pdev, PCI_D3cold, 1);
>
> However, the second call is not necessary if the first one succeeds
> (the ordering of the statements above doesn't matter here) and it
> may even be harmful, because we are not supposed to enable PME#
> after the wake-up power has been enabled for the device.
>
> To allow drivers to overcome this problem, introduce function
> pci_wake_from_d3() that will enable the device to wake up the system
> from any of D3_hot and D3_cold as long as the wake-up from at least
> one of them is supported.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to linux-next, thanks Rafael.

Jesse
