From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [demo patch/RFC] sleepy linux
Date: Thu, 28 Feb 2008 19:13:57 +0100
Message-ID: <20080228181357.GA6050@elf.ucw.cz>
References: <20080226102652.GA1830@elf.ucw.cz> <20080226085422.6408fc4a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755890AbYB1SNo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080226085422.6408fc4a.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Is this limited to UP and only one disk?

Yes... for now.

> [comments below]

Thanks!

> > --- /dev/null
> > +++ b/Documentation/power/sleepy.txt
> > @@ -0,0 +1,55 @@
> > +		Sleepy Linux
> > +		~~~~~~~~~~~~
> > +
> > +Copyright 2007 Pavel Machek <pavel@suse.cz>
> > +	  GPLv2
> > +
> > +Current Linux versions can enter suspend-to-RAM just fine, but only
> > +can do it on explicit request. But suspend-to-RAM is important, eating
> 
>   Usually "can only do it" AFAIK.
> 
> > +something like 10% of power needed for idle system. Starting suspend
> > +manually is not too convinient; it is not an option on multiuser
> 
>                        convenient;

Spelling applied.

> > +Then, enable SCSI powersave by something like:
> > +
> > +mount /sys
> 
> Isn't /sys auto-mounted by kernel?

No.

> > +/* The host and its devices are all idle so we can autosuspend */
> > +static int autosuspend(struct Scsi_Host *host)
> > +{
> > +	if (my_pdev && autosuspend_enabled) {
> > +		printk("ahci: should autosuspend\n");
> 
> Use printk() KERN_* levels (multiple places).

Well, code obviously needs a lot of work... I said it was ugly ;-).

> > @@ -1820,6 +1858,10 @@ static void ahci_thaw(struct ata_port *a
> >  
> >  static void ahci_error_handler(struct ata_port *ap)
> >  {
> > +	struct ata_host *host = ap->host;
> > +	int rc;
> > +	extern int slept;
> 
> Eh?

Pavel in hack mode ;-). Yes, I'll clean it up once I fix the
fundamental issues -- like UP only etc... 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
