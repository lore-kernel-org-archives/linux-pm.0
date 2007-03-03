From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] [PATCH 2/2 -stable] libata: add missing CONFIG_PM
	in LLDs
Date: Sat, 03 Mar 2007 16:34:25 +1100
Message-ID: <1172900065.18544.119.camel@nigel.suspend2.net>
References: <20061122172841.0b90f042@localhost.localdomain>
	 <Pine.LNX.4.60.0702262150460.5079@poirot.grange>
	 <Pine.LNX.4.60.0702282201250.8832@poirot.grange>
	 <Pine.LNX.4.60.0703012305030.7351@poirot.grange>
	 <20070302084530.GN20322@htj.dyndns.org>
	 <20070302084649.GO20322@htj.dyndns.org>
	 <1172881095.18544.108.camel@nigel.suspend2.net>
	 <45E8E983.5030109@gmail.com>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <45E8E983.5030109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-ide@vger.kernel.org, jgarzik@pobox.com, linux-pm@lists.osdl.org, stable@kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2007-03-03 at 12:20 +0900, Tejun Heo wrote:
> Hello, Nigel.
> 
> Nigel Cunningham wrote:
> >> Index: work1/drivers/ata/ahci.c
> >> ===================================================================
> >> --- work1.orig/drivers/ata/ahci.c
> >> +++ work1/drivers/ata/ahci.c
> >> @@ -225,10 +225,12 @@ static void ahci_thaw(struct ata_port *a
> >>  static void ahci_error_handler(struct ata_port *ap);
> >>  static void ahci_vt8251_error_handler(struct ata_port *ap);
> >>  static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
> >> +#ifdef CONFIG_PM
> >>  static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
> >>  static int ahci_port_resume(struct ata_port *ap);
> >>  static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
> >>  static int ahci_pci_device_resume(struct pci_dev *pdev);
> > 
> > Wouldn't it be simpler to add
> > 
> > #else
> > #define ahci_port_suspend(port, message) (NULL)
> > 
> > etc (or something similar)?
> 
> ahci_port_suspend() is used to fill ata_port_ops vector, so it needs to
> be a function.  If you're talking about defining NULL function, yeah,
> that will remove half of CONFIG_PMs but would require dummy definitions
> for all functions.  I think both are ugly.  :-)

Yeah, I didn't look really carefully; an empty static function would
have been what I'd have written if I'd paid more attention.

> I'm working on a linker trick.  Please take a look at the following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/16475

Not familiar with fancy things like that, so I'll just pipe down and
leave you to it :).

Regards,

Nigel

