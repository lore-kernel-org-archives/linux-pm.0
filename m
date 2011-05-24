From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Mon, 23 May 2011 18:04:23 -0700
Message-ID: <BANLkTinJxu9+kSgb3jYBEBMy9igg0vp1FQ__14238.6449887001$1306199233$gmane$org@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
	<20110520154341.GL31426@htj.dyndns.org>
	<BANLkTi=iNjWsaYCJqP057FkhAXtab5nS=Q@mail.gmail.com>
	<20110523121310.GA24439@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110523121310.GA24439@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Hi, Tejun,

Defintely. I will clarify it as much as possible and meanwhile, wait
for it to be tested by reporters.

Thanks,
Jian

On Mon, May 23, 2011 at 5:13 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Fri, May 20, 2011 at 10:02:56AM -0700, Jian Peng wrote:
>> Hi, Tejun/Valdis,
>>
>> Since this is an interoperability issue of SATA host controller, the fir=
st
>> step I want to try it to make sure the tweak that MAKE my controller WORK
>> does not break other controllers.
>> You are both right that adding this majic 5ms delay at this place should=
 not
>> be the final solution.
>>
>> If this magic 5ms delay works on other affected systems, I plan to post a
>> new patch that inside ahci_start_engine(), still perform same check, and
>> show warning message if failed, but will set a flag, then still set START
>> bit, and if there is such failure flag, add 5ms delay.
>
> Yeah, sounds like a plan but please add ample comment explaining
> what's going on for which controller including link to the mailing
> list threads. =A0As we're basically adding a black magic, I would still
> like to enable it only for the affected controllers so that we don't
> have to worry whether there are controllers which are affected by this
> problem but we don't know about.
>
>> --- a/drivers/ata/libahci.c 2011-05-18 14:23:36.564665643 -0700
>> +++ c/drivers/ata/libahci.c 2011-05-20 09:48:06.194663506 -0700
>> @@ -540,6 +540,7 @@
>> =A0 void __iomem *port_mmio =3D ahci_port_base(ap);
>> =A0 u32 tmp;
>> =A0 u8 status;
>> + int err =3D 0;
>
> I think
>
> =A0bool stat_failed =3D false;
>
> would be more in line with recent coding style.
>
>> =A0 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;
>>
>> @@ -553,12 +554,12 @@
>> =A0 =A0* specific controller will fail under this condition
>> =A0 =A0*/
>> =A0 if (status & (ATA_BUSY | ATA_DRQ))
>> - =A0return;
>> + =A0err =3D 1;
>> =A0 else {
>> =A0 =A0ahci_scr_read(&ap->link, SCR_STATUS, &tmp);
>>
>> =A0 =A0if ((tmp & 0xf) !=3D 0x3)
>> - =A0 return;
>> + =A0 err =3D 1;
>> =A0 }
>>
>> =A0 /* start DMA */
>> @@ -566,6 +567,13 @@
>> =A0 tmp |=3D PORT_CMD_START;
>> =A0 writel(tmp, port_mmio + PORT_CMD);
>> =A0 readl(port_mmio + PORT_CMD); /* flush */
>> +
>> + /* Some controllers need longer time to be ready */
>> + if(err) {
>> + =A0printk(KERN_WARNING
>> + =A0 "Controller in wrong state when setting START bit\n");
>> + =A0msleep(5);
>
> =A0ata_port_printk()?
>
> Thanks.
>
> --
> tejun
>
