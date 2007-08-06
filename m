From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] kexec: fix pci device initialization fail
	after kexec (2.6.23-rc2). (Related to e1000 doesn't resume
	properly from standby)
Date: Mon, 6 Aug 2007 16:50:15 +0200
Message-ID: <200708061650.16555.rjw__6977.90439376167$1186411324$gmane$org@sisk.pl>
References: <b25c3fa70708060642w1b3a326q792a81fdaa3036c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b25c3fa70708060642w1b3a326q792a81fdaa3036c5@mail.gmail.com>
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
To: Joonwoo Park <joonwpark81@gmail.com>
Cc: Simon Arlott <simon@fire.lp0.eu>, "Kok, Auke" <auke-jan.h.kok@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 6 August 2007 15:42, Joonwoo Park wrote:
> Hi.
> I think that the pci_set_power_state() has bug.
> The specification says that some delays is required.

And they are in place, AFAICS (from drivers/pci/pci.c):

	/* Mandatory power management transition delays */
	/* see PCI PM 1.1 5.6.1 table 18 */
	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
		msleep(pci_pm_d3_delay);
	else if (state == PCI_D2 || dev->current_state == PCI_D2)
		udelay(200);

> Simon, please can I know whether it works to you?
> It is seems to the things are related.
> 
> Joonwoo Park.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 37c00f6..9f78064 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -493,8 +493,14 @@ pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>    * restore at least the BARs so that the device will be
>    * accessible to its driver.
>    */
> - if (need_restore)
> + if (need_restore) {
> +   /* The specification also says that "Must ensure that all of
> +    * its PCI signal drivers remain disabled for the duration of
> +    * the D3hot to D0 Uninitialized state transition".
> +    */
> +   msleep(10);

It's too late for the delay.

>     pci_restore_bars(dev);
> + }
> 
>   return 0;
>  }

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
