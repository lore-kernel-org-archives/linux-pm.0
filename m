From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works,
	does ACPI magic
Date: Mon, 21 May 2007 11:34:36 -0600
Message-ID: <200705211134.36578.bjorn.helgaas__13356.9025704221$1179769001$gmane$org@hp.com>
References: <200705091222.29561.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705091222.29561.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 May 2007 01:22:29 pm David Brownell wrote:
>  static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
> ...
> +	switch (state) {
> +	case PCI_D0:
> +	case PCI_D1:
> +	case PCI_D2:
> +	case PCI_D3hot:
> +	case PCI_D3cold:
> +		return acpi_bus_set_power(handle, state_conv[state]);
> +	}
> +
> +	return -EINVAL;
>  }

Did you account for the fact that PCI works on a per-function basis,
but ACPI power management works on a per-slot basis?

We had a bug[1] a while back where e1000 would suspend a device and
call pci_power_state(), which used ACPI to turn off the slot.  The
only problem was that this was a dual-port card and the other port
was still active when the lights went out.

Maybe you deal with this already; it just wasn't obvious to me from
a quick glance through your patch.

Bjorn


[1] https://bugzilla.novell.com/show_bug.cgi?id=162320
