From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Wed, 18 May 2011 12:23:05 -0700
Message-ID: <BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl> <201105132244.29605.rjw@sisk.pl>
	<20110514101807.GA23665@htj.dyndns.org>
	<20110514102804.GB23665@htj.dyndns.org>
	<20633.1305565337@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2522563763557948155=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20633.1305565337@localhost>
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
To: Valdis.Kletnieks@vt.edu
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>
List-Id: linux-pm@vger.kernel.org

--===============2522563763557948155==
Content-Type: multipart/alternative; boundary=20cf3071ca6269c5c304a391d154

--20cf3071ca6269c5c304a391d154
Content-Type: text/plain; charset=ISO-8859-1

Hi, Valdis/Rafael/Michael,

Could you help me test the following change?

After reverting 81ca7e4, add 5ms delay as follow since that seems also
fixing the issue on my SATA host controller that requires 81ca7e4.

In drivers/ata/libahci.c, inside ahci_hardreset() function,


1333 <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1333>
ahci_start_engine
<http://lxr.linux.no/linux+*/+code=ahci_start_engine>(ap
<http://lxr.linux.no/linux+*/+code=ap>);

            msleep(5);1334
<http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1334>1335
<http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335>        if
(online <http://lxr.linux.no/linux+*/+code=online>)1336
<http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336>
  *class <http://lxr.linux.no/linux+*/+code=class> = ahci_dev_classify
<http://lxr.linux.no/linux+*/+code=ahci_dev_classify>(ap
<http://lxr.linux.no/linux+*/+code=ap>);

Since my host controller requires time to switch internal state to be ready.
Please let me know your testing result.

Thanks,
Jian



On Mon, May 16, 2011 at 10:02 AM, <Valdis.Kletnieks@vt.edu> wrote:

> On Sat, 14 May 2011 12:28:04 +0200, Tejun Heo said:
> > This reverts commit 270dac35c26433d06a89150c51e75ca0181ca7e4.
> >
> > The commits causes command timeouts on AC plug/unplug.  It isn't yet
> > clear why.  As the commit was for a single rather obscure controller,
> > revert the change for now.
> >
> > The problem was reported and bisected by Gu Rui in bug#34692.
> >
> >  https://bugzilla.kernel.org/show_bug.cgi?id=34692
> >
> > Also, reported by Rafael and Michael in the following thread.
> >
> >  http://thread.gmane.org/gmane.linux.kernel/1138771
>
> This also fixes the issue I had with a 10-second pause on my Dell Latitude
> E6500
> laptop at boot while detecting the CD/DVD drive.
>

--20cf3071ca6269c5c304a391d154
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Valdis/Rafael/Michael,</div>
<div>=A0</div>
<div>Could you help me test the following change?</div>
<div>=A0</div>
<div>After reverting 81ca7e4, add 5ms delay as follow since that seems also=
 fixing the issue on my SATA host controller that requires 81ca7e4. </div>
<div>=A0</div>
<div>In drivers/ata/libahci.c, inside ahci_hardreset() function,</div>
<div>=A0</div>
<div><pre class=3D"done" id=3D"c6/af/e7aed28a961ff966e17e17a85266dede2fa3_3=
/1000"><a class=3D"line" id=3D"L1333" href=3D"http://lxr.linux.no/linux+*/d=
rivers/ata/libahci.c#L1333" name=3D"L1333">1333</a>        <a class=3D"sref=
" href=3D"http://lxr.linux.no/linux+*/+code=3Dahci_start_engine">ahci_start=
_engine</a>(<a class=3D"sref" href=3D"http://lxr.linux.no/linux+*/+code=3Da=
p">ap</a>);</pre>
<pre class=3D"done">            msleep(5);
<a class=3D"line" id=3D"L1334" href=3D"http://lxr.linux.no/linux+*/drivers/=
ata/libahci.c#L1334" name=3D"L1334">1334</a>
<a class=3D"line" id=3D"L1335" href=3D"http://lxr.linux.no/linux+*/drivers/=
ata/libahci.c#L1335" name=3D"L1335">1335</a>        if (<a class=3D"sref" h=
ref=3D"http://lxr.linux.no/linux+*/+code=3Donline">online</a>)
<a class=3D"line" id=3D"L1336" href=3D"http://lxr.linux.no/linux+*/drivers/=
ata/libahci.c#L1336" name=3D"L1336">1336</a>                *<a class=3D"sr=
ef" href=3D"http://lxr.linux.no/linux+*/+code=3Dclass">class</a> =3D <a cla=
ss=3D"sref" href=3D"http://lxr.linux.no/linux+*/+code=3Dahci_dev_classify">=
ahci_dev_classify</a>(<a class=3D"sref" href=3D"http://lxr.linux.no/linux+*=
/+code=3Dap">ap</a>);
</pre></div>
<div>Since my host controller requires time to switch internal state to be =
ready. Please let me know your testing result.</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Jian</div>
<div>=A0</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">On Mon, May 16, 2011 at 10:02 AM, <span dir=3D"l=
tr">&lt;<a href=3D"mailto:Valdis.Kletnieks@vt.edu">Valdis.Kletnieks@vt.edu<=
/a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Sat, 14 May 2011 12:28:04 +0200, Tejun Heo said:<br>&g=
t; This reverts commit 270dac35c26433d06a89150c51e75ca0181ca7e4.<br>&gt;<br=
>&gt; The commits causes command timeouts on AC plug/unplug. =A0It isn&#39;=
t yet<br>
&gt; clear why. =A0As the commit was for a single rather obscure controller=
,<br>&gt; revert the change for now.<br>&gt;<br>&gt; The problem was report=
ed and bisected by Gu Rui in bug#34692.<br>&gt;<br>&gt; =A0<a href=3D"https=
://bugzilla.kernel.org/show_bug.cgi?id=3D34692" target=3D"_blank">https://b=
ugzilla.kernel.org/show_bug.cgi?id=3D34692</a><br>
&gt;<br>&gt; Also, reported by Rafael and Michael in the following thread.<=
br>&gt;<br>&gt; =A0<a href=3D"http://thread.gmane.org/gmane.linux.kernel/11=
38771" target=3D"_blank">http://thread.gmane.org/gmane.linux.kernel/1138771=
</a><br>
<br></div>This also fixes the issue I had with a 10-second pause on my Dell=
 Latitude E6500<br>laptop at boot while detecting the CD/DVD drive.<br></bl=
ockquote></div><br>

--20cf3071ca6269c5c304a391d154--

--===============2522563763557948155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2522563763557948155==--
