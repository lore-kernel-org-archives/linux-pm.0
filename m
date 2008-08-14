From: "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH 3/3] Adapt the e100 driver to the reworked
	PCI PM
Date: Thu, 14 Aug 2008 16:56:54 -0700
Message-ID: <9929d2390808141656g1896657fm6802c520b036cacc__14005.4745170803$1218811143$gmane$org@mail.gmail.com>
References: <200808142335.56644.rjw@sisk.pl> <200808142340.25574.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808142340.25574.rjw@sisk.pl>
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
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, Stephen Hemminger <stephen.hemminger@vyatta.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 14, 2008 at 2:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> [Note: I have no hardware to test this patch, but it seems pretty
> straightforward.]
>
> Adapt the e100 driver to the reworked PCI PM
>
> * Use device_set_wakeup_enable() and friends as needed
> * Use pci_pme_active() to clear PME_Status and disable PME#
> * Use the observation that it is sufficient to call pci_enable_wake()
>  once, unless it fails
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/net/e100.c |   20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>

We have tested the patch in our labs and systems wake from S5 just fine.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
Cheers,
Jeff
