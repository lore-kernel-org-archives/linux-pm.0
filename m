From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 2/2] libata: PM code cleanup for ata port
Date: Fri, 25 Jan 2013 13:29:10 +0100
Message-ID: <1512636.TS44I6d7Dq@vostro.rjw.lan>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com> <510226F9.5000709@intel.com> <51026D90.7040309@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <51026D90.7040309@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, January 25, 2013 03:33:36 PM Sergei Shtylyov wrote:
> Hello.
> 
> On 25-01-2013 10:32, Aaron Lu wrote:
> 
> > For system freeze, if the port is already runtime suspended, leave it
> > alone and just return. The port will be resumed on thaw before it will
> > be used.
> 
> > And since we will call get_noresume for every device during prepare
> > phase, and the port is resumed during thaw phase, it can't be in runtime
> > suspended state during the poweroff phase. So remove the
> > runtime_suspended check in poweroff callback.
> 
> > And for all suspend(freeze/suspend/poweroff/etc.), there is no need to
> > touch the device, so set no_autopsy and no_recovery for them all.
> 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> >   drivers/ata/libata-core.c | 16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 6a5ef86..439c608 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -5334,9 +5334,6 @@ static int ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
> >
> >   static int __ata_port_suspend_common(struct ata_port *ap, pm_message_t mesg, int *async)
> >   {
> > -	unsigned int ehi_flags = ATA_EHI_QUIET;
> > -	int rc;
> > -
> >   	/*
> >   	 * On some hardware, device fails to respond after spun down
> >   	 * for suspend.  As the device won't be used before being
> > @@ -5345,11 +5342,9 @@ static int __ata_port_suspend_common(struct ata_port *ap, pm_message_t mesg, int
> >   	 *
> >   	 * http://thread.gmane.org/gmane.linux.ide/46764
> >   	 */
> > -	if (mesg.event & PM_EVENT_SUSPEND)
> > -		ehi_flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_NO_RECOVERY;
> > -
> > -	rc = ata_port_request_pm(ap, mesg, 0, ehi_flags, async);
> > -	return rc;
> > +	unsigned int ehi_flags = ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY |
> > +				 ATA_EHI_NO_RECOVERY;
> 
>     Please keep the existing coding style and insert empty line after 
> declarations.
>     Wait, you don't need this variable at all...

Well, I suppose Aaron just wanted to avoid ugly line breaks in the return
line below and whether or not to keep the empty line in this case is a matter
of taste IMHO.

In my personal opinion it would be cleaner with the empty line.

> > +	return ata_port_request_pm(ap, mesg, 0, ehi_flags, async);
> >   }

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
