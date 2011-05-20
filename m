From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 10:02:56 -0700
Message-ID: <BANLkTi=iNjWsaYCJqP057FkhAXtab5nS=Q@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
	<20110520154341.GL31426@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6613348369660252964=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110520154341.GL31426@htj.dyndns.org>
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
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============6613348369660252964==
Content-Type: multipart/alternative; boundary=20cf307f38f6d842a904a3b81730

--20cf307f38f6d842a904a3b81730
Content-Type: text/plain; charset=ISO-8859-1

Hi, Tejun/Valdis,

Since this is an interoperability issue of SATA host controller, the first
step I want to try it to make sure the tweak that MAKE my controller WORK
does not break other controllers.
You are both right that adding this majic 5ms delay at this place should not
be the final solution.

If this magic 5ms delay works on other affected systems, I plan to post a
new patch that inside ahci_start_engine(), still perform same check, and
show warning message if failed, but will set a flag, then still set START
bit, and if there is such failure flag, add 5ms delay.

Valdis, could you apply the following patch and retest it?

Tejun, please review it.

--- a/drivers/ata/libahci.c 2011-05-18 14:23:36.564665643 -0700
+++ c/drivers/ata/libahci.c 2011-05-20 09:48:06.194663506 -0700
@@ -540,6 +540,7 @@
  void __iomem *port_mmio = ahci_port_base(ap);
  u32 tmp;
  u8 status;
+ int err = 0;

  status = readl(port_mmio + PORT_TFDATA) & 0xFF;

@@ -553,12 +554,12 @@
   * specific controller will fail under this condition
   */
  if (status & (ATA_BUSY | ATA_DRQ))
-  return;
+  err = 1;
  else {
   ahci_scr_read(&ap->link, SCR_STATUS, &tmp);

   if ((tmp & 0xf) != 0x3)
-   return;
+   err = 1;
  }

  /* start DMA */
@@ -566,6 +567,13 @@
  tmp |= PORT_CMD_START;
  writel(tmp, port_mmio + PORT_CMD);
  readl(port_mmio + PORT_CMD); /* flush */
+
+ /* Some controllers need longer time to be ready */
+ if(err) {
+  printk(KERN_WARNING
+   "Controller in wrong state when setting START bit\n");
+  msleep(5);
+ }
 }
 EXPORT_SYMBOL_GPL(ahci_start_engine);




On Fri, May 20, 2011 at 8:43 AM, Tejun Heo <tj@kernel.org> wrote:

>  On Fri, May 20, 2011 at 11:40:20AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 18 May 2011 17:14:56 PDT, Jian Peng said:
> >
> > > > @@ -1353,6 +1332,8 @@
> > > >
> > > >
> > > >   ahci_start_engine(ap);
> > > >
> > > > + msleep(5);
> > > > +
> > > >   if (online)
> > > >
> > > >    *class = ahci_dev_classify(ap);
> > > >
> >
> > It may very well be that adding a magic msleep(5) here just Makes It
> Work, but
> > I have a gut feeling that it's in the wrong place (for starters, 'online'
> can't change
> > during the msleep() unless somebody *else* sets it - in which case the
> locking
> > is screwed up as we're not forcing a re-read of the value).  The msleep()
> probably
> > needs to be before something else further down in the code (but I have no
> idea
> > exactly what).
>
> At this point, I think it would be better to simply add a flag and
> enable the check for the affected controller.
>
> Thanks.
>
> --
> tejun
>

--20cf307f38f6d842a904a3b81730
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Tejun/Valdis,</div>
<div>=A0</div>
<div>Since this is an interoperability issue of SATA host controller, the f=
irst step I want to try it to make sure the tweak that MAKE my controller W=
ORK does not break other controllers.</div>
<div>You are both right that adding this majic 5ms delay at this place shou=
ld not be the final solution.</div>
<div>=A0</div>
<div>If this magic 5ms delay works on other affected systems, I plan to pos=
t a new patch that inside ahci_start_engine(), still perform same check, an=
d show warning message if failed, but will set a flag, then still set START=
 bit, and if there is such failure flag, add 5ms delay.</div>

<div>=A0</div>
<div>Valdis, could you apply the following patch and retest it?</div>
<div>=A0</div>
<div>Tejun, please review it.</div>
<div>=A0</div>
<div>--- a/drivers/ata/libahci.c=A02011-05-18 14:23:36.564665643 -0700<br>+=
++ c/drivers/ata/libahci.c=A02011-05-20 09:48:06.194663506 -0700<br>@@ -540=
,6 +540,7 @@<br>=A0=A0void __iomem *port_mmio =3D ahci_port_base(ap);<br>=
=A0=A0u32 tmp;<br>
=A0=A0u8 status;<br>+=A0int err =3D 0;<br>=A0<br>=A0=A0status =3D readl(por=
t_mmio + PORT_TFDATA) &amp; 0xFF;<br>=A0<br>@@ -553,12 +554,12 @@<br>=A0=A0=
 * specific controller will fail under this condition<br>=A0=A0 */<br>=A0=
=A0if (status &amp; (ATA_BUSY | ATA_DRQ))<br>
-=A0=A0return;<br>+=A0=A0err =3D 1;<br>=A0=A0else {<br>=A0=A0=A0ahci_scr_re=
ad(&amp;ap-&gt;link, SCR_STATUS, &amp;tmp);<br>=A0<br>=A0=A0=A0if ((tmp &am=
p; 0xf) !=3D 0x3)<br>-=A0=A0=A0return;<br>+=A0=A0=A0err =3D 1;<br>=A0=A0}<b=
r>=A0<br>=A0=A0/* start DMA */<br>@@ -566,6 +567,13 @@<br>
=A0=A0tmp |=3D PORT_CMD_START;<br>=A0=A0writel(tmp, port_mmio + PORT_CMD);<=
br>=A0=A0readl(port_mmio + PORT_CMD); /* flush */<br>+<br>+=A0/* Some contr=
ollers need longer time to be ready */<br>+=A0if(err) {<br>+=A0=A0printk(KE=
RN_WARNING <br>+=A0=A0=A0&quot;Controller in wrong state when setting START=
 bit\n&quot;);<br>
+=A0=A0msleep(5);<br>+=A0}=A0<br>=A0}<br>=A0EXPORT_SYMBOL_GPL(ahci_start_en=
gine);<br>=A0<br></div>
<div>=A0</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">On Fri, May 20, 2011 at 8:43 AM, Tejun Heo <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:tj@kernel.org">tj@kernel.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Fri, May 20, 2011 at 11:40:20AM -0400, <a href=3D"mail=
to:Valdis.Kletnieks@vt.edu">Valdis.Kletnieks@vt.edu</a> wrote:<br>&gt; On W=
ed, 18 May 2011 17:14:56 PDT, Jian Peng said:<br>&gt;<br>&gt; &gt; &gt; @@ =
-1353,6 +1332,8 @@<br>
&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =A0 ahci_start_engine(ap=
);<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; + msleep(5);<br>&gt; &gt; &gt; +<br>=
&gt; &gt; &gt; =A0 if (online)<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =A0 =A0*=
class =3D ahci_dev_classify(ap);<br>
&gt; &gt; &gt;<br>&gt;<br>&gt; It may very well be that adding a magic msle=
ep(5) here just Makes It Work, but<br>&gt; I have a gut feeling that it&#39=
;s in the wrong place (for starters, &#39;online&#39; can&#39;t change<br>
&gt; during the msleep() unless somebody *else* sets it - in which case the=
 locking<br>&gt; is screwed up as we&#39;re not forcing a re-read of the va=
lue). =A0The msleep() probably<br>&gt; needs to be before something else fu=
rther down in the code (but I have no idea<br>
&gt; exactly what).<br><br></div></div>At this point, I think it would be b=
etter to simply add a flag and<br>enable the check for the affected control=
ler.<br><br>Thanks.<br><br>--<br><font color=3D"#888888">tejun<br></font></=
blockquote>
</div><br>

--20cf307f38f6d842a904a3b81730--

--===============6613348369660252964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6613348369660252964==--
