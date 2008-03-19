From: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 3/3] PM: New suspend and hibernation
	callbacks for	PCI bus type
Date: Tue, 18 Mar 2008 17:55:08 -0700
Message-ID: <20080319005508.GD8298@kroah.com>
References: <200803170020.55473.rjw@sisk.pl> <200803170025.16149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803170025.16149.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 17, 2008 at 12:25:15AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Implement new suspend and hibernation callbacks for the PCI busi type.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-driver.c |  497 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pci.h      |    2 
>  2 files changed, 453 insertions(+), 46 deletions(-)

Hm, that's a lot of code added.  What additional functionality did we
just get?

Are we going to have to create a noirq version for every driver and bus
type now?

thanks,

greg k-h
