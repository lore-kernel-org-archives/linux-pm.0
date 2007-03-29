From: Maxim <maximlevitsky@gmail.com>
Subject: Re: [ PATCH] Add suspend/resume for HPET was: Re: [3/6] 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 15:31:17 +0200
Message-ID: <200703291531.18253.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703290747.28929.maximlevitsky@gmail.com> <460BBD1B.4040308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <460BBD1B.4040308@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 March 2007 15:20:27 Sergei Shtylyov wrote:
> Hello.
> 
> Maxim wrote:
> 
> > ---
> > This adds support of suspend/resume on i386 for HPET
> 
>    The part after usually "---" gets cut off, the patch description and 
> signoff should actially *precede* it.
> 
> > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> 
> > diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
> > index 0fd9fba..7c67780 100644
> > --- a/arch/i386/kernel/hpet.c
> > +++ b/arch/i386/kernel/hpet.c
> [...]
> > +static __init int hpet_register_sysfs(void)
> > +{
> > +	int err;
> > +
> > +	if (!is_hpet_capable())
> > +		return 0;
> > +
> > +	err = sysdev_class_register(&hpet_class);
> > +
> > +	if (!err) {
> > +		sysdev_register(&hpet_device);
> > +		if (err)
> > +			sysdev_class_unregister(&hpet_class);
> 
>     This doesn't make sense, err will always be 0.  Perhaps you actually 
> intended to check the result of sysdev_register()?
> 
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +device_initcall(hpet_register_sysfs);
> > +
> > +#endif
> 
> WBR, Sergei
> 

Hi,
	Big thanks for pointing this out,
		I will resend that updated patch.

	Best regards,
		Maxim Levitsky

