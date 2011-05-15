From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Sat, 14 May 2011 23:19:07 -0700
Message-ID: <BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl> <201105132244.29605.rjw@sisk.pl>
	<20110514101807.GA23665@htj.dyndns.org>
	<20110514102804.GB23665@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0220797296675021177=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110514102804.GB23665@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Michael Leun <lkml20100708@newton.leun.net>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============0220797296675021177==
Content-Type: multipart/alternative; boundary=20cf307f3ac636819b04a34a845f

--20cf307f3ac636819b04a34a845f
Content-Type: text/plain; charset=ISO-8859-1

Hi, Michael/Rafael/Gu,

Could you help me understand the testing environme? I like to reproduce it
if it is possible and debug it. The host controller this patch dealing with
is not used on PC so my testing environment is quite different.

Thanks,
Jian

On Sat, May 14, 2011 at 3:28 AM, Tejun Heo <tj@kernel.org> wrote:

> This reverts commit 270dac35c26433d06a89150c51e75ca0181ca7e4.
>
> The commits causes command timeouts on AC plug/unplug.  It isn't yet
> clear why.  As the commit was for a single rather obscure controller,
> revert the change for now.
>
> The problem was reported and bisected by Gu Rui in bug#34692.
>
>  https://bugzilla.kernel.org/show_bug.cgi?id=34692
>
> Also, reported by Rafael and Michael in the following thread.
>
>  http://thread.gmane.org/gmane.linux.kernel/1138771
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Gu Rui <chaos.proton@gmail.com>
> Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-by: Michael Leun <lkml20100708@newton.leun.net>
> Cc: Jian Peng <jipeng2005@gmail.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> ---
> As we're already in -rc7, I'm sending the revert patch to both Jeff
> and Linus.
>
> Thank you.
>
>  drivers/ata/libahci.c |   21 ---------------------
>  1 files changed, 0 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ff9d832..d38c40f 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -561,27 +561,6 @@ void ahci_start_engine(struct ata_port *ap)
>  {
>        void __iomem *port_mmio = ahci_port_base(ap);
>        u32 tmp;
> -       u8 status;
> -
> -       status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> -
> -       /*
> -        * At end of section 10.1 of AHCI spec (rev 1.3), it states
> -        * Software shall not set PxCMD.ST to 1 until it is determined
> -        * that a functoinal device is present on the port as determined by
> -        * PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
> -        *
> -        * Even though most AHCI host controllers work without this check,
> -        * specific controller will fail under this condition
> -        */
> -       if (status & (ATA_BUSY | ATA_DRQ))
> -               return;
> -       else {
> -               ahci_scr_read(&ap->link, SCR_STATUS, &tmp);
> -
> -               if ((tmp & 0xf) != 0x3)
> -                       return;
> -       }
>
>        /* start DMA */
>        tmp = readl(port_mmio + PORT_CMD);
> --
> 1.7.1
>
>

--20cf307f3ac636819b04a34a845f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Michael/Rafael/Gu,</div>
<div>=A0</div>
<div>Could you help me understand the testing environme? I like to reproduc=
e it if it is possible=A0and debug it. The host controller this patch deali=
ng with is not used on PC so my testing environment is quite different.</di=
v>

<div>=A0</div>
<div>Thanks,</div>
<div>Jian<br><br></div>
<div class=3D"gmail_quote">On Sat, May 14, 2011 at 3:28 AM, Tejun Heo <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:tj@kernel.org">tj@kernel.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">This reverts commit 270dac35c264=
33d06a89150c51e75ca0181ca7e4.<br><br>The commits causes command timeouts on=
 AC plug/unplug. =A0It isn&#39;t yet<br>
clear why. =A0As the commit was for a single rather obscure controller,<br>=
revert the change for now.<br><br>The problem was reported and bisected by =
Gu Rui in bug#34692.<br><br>=A0<a href=3D"https://bugzilla.kernel.org/show_=
bug.cgi?id=3D34692" target=3D"_blank">https://bugzilla.kernel.org/show_bug.=
cgi?id=3D34692</a><br>
<br>Also, reported by Rafael and Michael in the following thread.<br><br>=
=A0<a href=3D"http://thread.gmane.org/gmane.linux.kernel/1138771" target=3D=
"_blank">http://thread.gmane.org/gmane.linux.kernel/1138771</a><br><br>Sign=
ed-off-by: Tejun Heo &lt;<a href=3D"mailto:tj@kernel.org">tj@kernel.org</a>=
&gt;<br>
Reported-by: Gu Rui &lt;<a href=3D"mailto:chaos.proton@gmail.com">chaos.pro=
ton@gmail.com</a>&gt;<br>Reported-by: Rafael J. Wysocki &lt;<a href=3D"mail=
to:rjw@sisk.pl">rjw@sisk.pl</a>&gt;<br>Reported-by: Michael Leun &lt;<a hre=
f=3D"mailto:lkml20100708@newton.leun.net">lkml20100708@newton.leun.net</a>&=
gt;<br>
Cc: Jian Peng &lt;<a href=3D"mailto:jipeng2005@gmail.com">jipeng2005@gmail.=
com</a>&gt;<br>Cc: Jeff Garzik &lt;<a href=3D"mailto:jgarzik@pobox.com">jga=
rzik@pobox.com</a>&gt;<br>---<br>As we&#39;re already in -rc7, I&#39;m send=
ing the revert patch to both Jeff<br>
and Linus.<br><br>Thank you.<br><br>=A0drivers/ata/libahci.c | =A0 21 -----=
----------------<br>=A01 files changed, 0 insertions(+), 21 deletions(-)<br=
><br>diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c<br>index ff=
9d832..d38c40f 100644<br>
--- a/drivers/ata/libahci.c<br>+++ b/drivers/ata/libahci.c<br>@@ -561,27 +5=
61,6 @@ void ahci_start_engine(struct ata_port *ap)<br>=A0{<br>=A0 =A0 =A0 =
=A0void __iomem *port_mmio =3D ahci_port_base(ap);<br>=A0 =A0 =A0 =A0u32 tm=
p;<br>- =A0 =A0 =A0 u8 status;<br>
-<br>- =A0 =A0 =A0 status =3D readl(port_mmio + PORT_TFDATA) &amp; 0xFF;<br=
>-<br>- =A0 =A0 =A0 /*<br>- =A0 =A0 =A0 =A0* At end of section 10.1 of AHCI=
 spec (rev 1.3), it states<br>- =A0 =A0 =A0 =A0* Software shall not set PxC=
MD.ST to 1 until it is determined<br>
- =A0 =A0 =A0 =A0* that a functoinal device is present on the port as deter=
mined by<br>- =A0 =A0 =A0 =A0* PxTFD.STS.BSY=3D0, PxTFD.STS.DRQ=3D0 and PxS=
STS.DET=3D3h<br>- =A0 =A0 =A0 =A0*<br>- =A0 =A0 =A0 =A0* Even though most A=
HCI host controllers work without this check,<br>
- =A0 =A0 =A0 =A0* specific controller will fail under this condition<br>- =
=A0 =A0 =A0 =A0*/<br>- =A0 =A0 =A0 if (status &amp; (ATA_BUSY | ATA_DRQ))<b=
r>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>- =A0 =A0 =A0 else {<br>- =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ahci_scr_read(&amp;ap-&gt;link, SCR_STATUS, &amp;tm=
p);<br>
-<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tmp &amp; 0xf) !=3D 0x3)<br>- =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>- =A0 =A0 =A0 }<br><br>=
=A0 =A0 =A0 =A0/* start DMA */<br>=A0 =A0 =A0 =A0tmp =3D readl(port_mmio + =
PORT_CMD);<br><font color=3D"#888888">--<br>1.7.1<br><br></font></blockquot=
e>
</div><br>

--20cf307f3ac636819b04a34a845f--

--===============0220797296675021177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0220797296675021177==--
