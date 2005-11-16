From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
Date: Tue, 15 Nov 2005 22:31:26 -0800
Message-ID: <20051116063125.GE31375@suse.de>
References: <1132111902.9809.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030197AbVKPGrT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132111902.9809.59.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:42PM -0500, Adam Belay wrote:
> This patch makes some improvements to pci_save_state and
> pci_restore_state.  Instead of saving and restoring all standard
> registers (even read-only ones), it only restores necessary registers.
> Also, the command register is handled more carefully.  Let me know if
> I'm missing anything important.
> 
> 
> --- a/drivers/pci/pm.c	2005-11-13 20:32:24.000000000 -0500
> +++ b/drivers/pci/pm.c	2005-11-13 20:29:32.000000000 -0500
> @@ -53,10 +53,13 @@
>   */
>  int pci_save_state(struct pci_dev *dev)
>  {
> -	int i;
> -	/* XXX: 100% dword access ok here? */
> -	for (i = 0; i < 16; i++)
> -		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
> +	struct pci_dev_config * conf = &dev->saved_config;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
> +	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
> +	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_line);

Why are we saving and restoring smaller ammounts of config space now?

thanks,

greg k-h
