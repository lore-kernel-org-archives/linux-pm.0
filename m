From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Wed, 18 May 2011 17:14:56 -0700
Message-ID: <BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3930611059377913309=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============3930611059377913309==
Content-Type: multipart/alternative; boundary=bcaec501604d27ce1404a395e5a0

--bcaec501604d27ce1404a395e5a0
Content-Type: text/plain; charset=ISO-8859-1

Hi, Rafael,

I am using Dell E6410 with same AHCI host controller as your system, but
could not reproduce the bug you found out (using Ubuntu 11.04 and 2.6.39-rc6
kernel).
Do you know which config file I need change to perform this testing?

Thanks,
Jian

On Wed, May 18, 2011 at 2:25 PM, Jian Peng <jipeng2005@gmail.com> wrote:

> Sure, Please try this. Thanks,
>
> diff -Naur a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> --- a/drivers/ata/libahci.c 2011-05-18 14:23:36.564665643 -0700
> +++ b/drivers/ata/libahci.c 2011-05-18 14:24:52.564614378 -0700
> @@ -539,27 +539,6 @@
>
>  {
>   void __iomem *port_mmio = ahci_port_base(ap);
>   u32 tmp;
> - u8 status;
> -
> - status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> -
> - /*
> -  * At end of section 10.1 of AHCI spec (rev 1.3), it states
> -  * Software shall not set PxCMD.ST to 1 until it is determined
> -  * that a functoinal device is present on the port as determined by
> -  * PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
> -  *
> -  * Even though most AHCI host controllers work without this check,
>
> -  * specific controller will fail under this condition
> -  */
> - if (status & (ATA_BUSY | ATA_DRQ))
> -  return;
> - else {
> -  ahci_scr_read(&ap->link, SCR_STATUS, &tmp);
> -
> -  if ((tmp & 0xf) != 0x3)
> -   return;
> - }
>
>   /* start DMA */
>   tmp = readl(port_mmio + PORT_CMD);
> @@ -1353,6 +1332,8 @@
>
>
>   ahci_start_engine(ap);
>
> + msleep(5);
> +
>   if (online)
>
>    *class = ahci_dev_classify(ap);
>
>
> 2011/5/18 Rafael J. Wysocki <rjw@sisk.pl>
>
>  On Wednesday, May 18, 2011, Jian Peng wrote:
>> > Hi, Valdis/Rafael/Michael,
>> >
>> > Could you help me test the following change?
>> >
>> > After reverting 81ca7e4, add 5ms delay as follow since that seems also
>> > fixing the issue on my SATA host controller that requires 81ca7e4.
>> >
>> > In drivers/ata/libahci.c, inside ahci_hardreset() function,
>> >
>> >
>> > 1333 <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1333>
>> > ahci_start_engine
>> > <http://lxr.linux.no/linux+*/+code=ahci_start_engine>(ap
>> > <http://lxr.linux.no/linux+*/+code=ap>);
>> >
>> >             msleep(5);1334
>> > <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1334>1335
>> > <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335>        if
>> > (online <http://lxr.linux.no/linux+*/+code=online>)1336
>> > <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336>
>> >   *class <http://lxr.linux.no/linux+*/+code=class> = ahci_dev_classify
>> > <http://lxr.linux.no/linux+*/+code=ahci_dev_classify>(ap
>> > <http://lxr.linux.no/linux+*/+code=ap>);
>> >
>> > Since my host controller requires time to switch internal state to be
>> ready.
>> > Please let me know your testing result.
>>
>> Could you simply post a patch?
>>
>> Rafael
>>
>
>

--bcaec501604d27ce1404a395e5a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Rafael,</div>
<div>=A0</div>
<div>I am using Dell E6410 with same AHCI host controller as your system, b=
ut could not reproduce the bug you found out (using Ubuntu 11.04 and 2.6.39=
-rc6 kernel).</div>
<div>Do you=A0know which config file I need change to perform this testing?=
</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Jian<br><br></div>
<div class=3D"gmail_quote">On Wed, May 18, 2011 at 2:25 PM, Jian Peng <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:jipeng2005@gmail.com">jipeng2005@gmail.c=
om</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Sure, Please try this. Thanks,</div>
<div>=A0</div>
<div>diff -Naur a/drivers/ata/libahci.c b/drivers/ata/libahci.c<br>--- a/dr=
ivers/ata/libahci.c=A02011-05-18 14:23:36.564665643 -0700<br>+++ b/drivers/=
ata/libahci.c=A02011-05-18 14:24:52.564614378 -0700<br>@@ -539,27 +539,6 @@=
=20
<div class=3D"im"><br>=A0{<br>=A0=A0void __iomem *port_mmio =3D ahci_port_b=
ase(ap);<br>=A0=A0u32 tmp;<br>-=A0u8 status;<br>-<br>-=A0status =3D readl(p=
ort_mmio + PORT_TFDATA) &amp; 0xFF;<br>-<br>-=A0/*<br>-=A0 * At end of sect=
ion 10.1 of AHCI spec (rev 1.3), it states<br>
-=A0 * Software shall not set PxCMD.ST to 1 until it is determined<br>-=A0 =
* that a functoinal device is present on the port as determined by<br>-=A0 =
* PxTFD.STS.BSY=3D0, PxTFD.STS.DRQ=3D0 and PxSSTS.DET=3D3h<br>-=A0 *<br></d=
iv>-=A0 * Even though most AHCI host controllers work without this check,=
=20
<div class=3D"im"><br>-=A0 * specific controller will fail under this condi=
tion<br>-=A0 */<br>-=A0if (status &amp; (ATA_BUSY | ATA_DRQ))<br>-=A0=A0ret=
urn;<br>-=A0else {<br>-=A0=A0ahci_scr_read(&amp;ap-&gt;link, SCR_STATUS, &a=
mp;tmp);<br>-<br>
-=A0=A0if ((tmp &amp; 0xf) !=3D 0x3)<br>-=A0=A0=A0return;<br>-=A0}<br>=A0<b=
r>=A0=A0/* start DMA */<br>=A0=A0tmp =3D readl(port_mmio + PORT_CMD);<br></=
div>@@ -1353,6 +1332,8 @@=20
<div class=3D"im"><br>=A0<br>=A0=A0ahci_start_engine(ap);<br>=A0<br>+=A0msl=
eep(5);<br></div>+<br>=A0=A0if (online)=20
<div class=3D"im"><br>=A0=A0=A0*class =3D ahci_dev_classify(ap);<br><br><br=
></div></div>
<div class=3D"gmail_quote">2011/5/18 Rafael J. Wysocki <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rjw@sisk.pl" target=3D"_blank">rjw@sisk.pl</a>&gt;</spa=
n>=20
<div>
<div></div>
<div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>On Wednesday, May 18, 2011, Jian Peng wrote:<br>&gt; Hi, Valdis/Rafael=
/Michael,<br>&gt;<br>&gt; Could you help me test the following change?<br>&=
gt;<br>&gt; After reverting 81ca7e4, add 5ms delay as follow since that see=
ms also<br>
&gt; fixing the issue on my SATA host controller that requires 81ca7e4.<br>=
&gt;<br>&gt; In drivers/ata/libahci.c, inside ahci_hardreset() function,<br=
>&gt;<br>&gt;<br></div>
<div>&gt; 1333 &lt;<a href=3D"http://lxr.linux.no/linux+*/drivers/ata/libah=
ci.c#L1333" target=3D"_blank">http://lxr.linux.no/linux+*/drivers/ata/libah=
ci.c#L1333</a>&gt;<br>&gt; ahci_start_engine<br>&gt; &lt;<a href=3D"http://=
lxr.linux.no/linux+*/+code=3Dahci_start_engine" target=3D"_blank">http://lx=
r.linux.no/linux+*/+code=3Dahci_start_engine</a>&gt;(ap<br>
&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/+code=3Dap" target=3D"_blan=
k">http://lxr.linux.no/linux+*/+code=3Dap</a>&gt;);<br>&gt;<br>&gt; =A0 =A0=
 =A0 =A0 =A0 =A0 msleep(5);1334<br>&gt; &lt;<a href=3D"http://lxr.linux.no/=
linux+*/drivers/ata/libahci.c#L1334" target=3D"_blank">http://lxr.linux.no/=
linux+*/drivers/ata/libahci.c#L1334</a>&gt;1335<br>
&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335=
" target=3D"_blank">http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335=
</a>&gt; =A0 =A0 =A0 =A0if<br>&gt; (online &lt;<a href=3D"http://lxr.linux.=
no/linux+*/+code=3Donline" target=3D"_blank">http://lxr.linux.no/linux+*/+c=
ode=3Donline</a>&gt;)1336<br>
&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336=
" target=3D"_blank">http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336=
</a>&gt;<br>&gt; =A0 *class &lt;<a href=3D"http://lxr.linux.no/linux+*/+cod=
e=3Dclass" target=3D"_blank">http://lxr.linux.no/linux+*/+code=3Dclass</a>&=
gt; =3D ahci_dev_classify<br>
&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/+code=3Dahci_dev_classify" =
target=3D"_blank">http://lxr.linux.no/linux+*/+code=3Dahci_dev_classify</a>=
&gt;(ap<br></div>&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/+code=3Dap=
" target=3D"_blank">http://lxr.linux.no/linux+*/+code=3Dap</a>&gt;);<br>

<div>&gt;<br>&gt; Since my host controller requires time to switch internal=
 state to be ready.<br>&gt; Please let me know your testing result.<br><br>=
</div>Could you simply post a patch?<br><font color=3D"#888888"><br>Rafael<=
br>
</font></blockquote></div></div></div><br></blockquote></div><br>

--bcaec501604d27ce1404a395e5a0--

--===============3930611059377913309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3930611059377913309==--
