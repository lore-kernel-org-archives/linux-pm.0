From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Resend][PATCH 2/2] PCI PM: Return error codes from
 pci_pm_resume()
Date: Mon, 14 Sep 2009 13:42:10 -0700
Message-ID: <20090914134210.3376e0f7__7643.05509296737$1252961203$gmane$org@jbarnes-g45>
References: <200909092349.59170.rjw@sisk.pl> <200909092351.27178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909092351.27178.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Sep 2009 23:51:27 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently pci_pm_resume() always returns 0, which makes the error
> variable defined in there a bit pointless.  Make pci_pm_resume()
> return error codes obtained from drivers' callbacks.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -689,7 +689,7 @@ static int pci_pm_resume(struct device *
>  		pci_pm_reenable_device(pci_dev);
>  	}
>  
> -	return 0;
> +	return error;
>  }
>  
>  #else /* !CONFIG_SUSPEND */
> 

Applied these two, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
