From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH] PCI PM: Fix handling of devices without PM
 support by pci_target_state()
Date: Tue, 16 Jun 2009 12:18:28 -0700
Message-ID: <20090616121828.2a7a8677__7256.37922664664$1245179975$gmane$org@jbarnes-g45>
References: <200906142125.03418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906142125.03418.rjw@sisk.pl>
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
Cc: Andreas Mohr <andim2@users.sourceforge.net>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 14 Jun 2009 21:25:02 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If a PCI device is not power-manageable either by the platform, or
> with the help of the native PCI PM interface, pci_target_state() will
> return either PCI_D3hot, or PCI_POWER_ERROR for it, depending on
> whether or not the device is configured to wake up the system.  Alas,
> none of these return values is correct, because each of them causes
> pci_prepare_to_sleep() to return error code, although it should
> complete successfully in such a case.
> 
> Fix this problem by making pci_target_state() always return PCI_D0
> for devices that cannot be power managed.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> Hi Jesse,
> 
> I think this is 2.6.31 material, probably -stable too.

Applied to my linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
