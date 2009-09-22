From: kevin granade <kevin.granade@gmail.com>
Subject: Re: [PATCH] PCI PM: Read device power state from
	register after updating it (rev. 2)
Date: Tue, 22 Sep 2009 14:56:55 -0500
Message-ID: <7004b08e0909221256m6d917531kc8b51e1af85d3459@mail.gmail.com>
References: <20090922080747.GA20853@rhlx01.hs-esslingen.de>
	<200909222150.01185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0348182755172567241=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909222150.01185.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>
List-Id: linux-pm@vger.kernel.org

--===============0348182755172567241==
Content-Type: multipart/alternative; boundary=0016364d29d11cae78047430009e

--0016364d29d11cae78047430009e
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Sep 22, 2009 at 2:50 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Tuesday 22 September 2009, Andreas Mohr wrote:
> > Hi Rafael,
>
> Hi,
>
> > first you say "returning an error code in such cases would..."
> > and then the patch content has...?
>
> I don't quite understand your comment, care to elaborate?
>
>
I think this is what was being referenced:

+       /* Return error code if we have failed to change the state */
+       if (dev->current_state != state)
+               dev_info(&dev->dev, "Refused to change power state, "
+                       "currently in D%d\n", dev->current_state);

The comment says, "Return error code", where it should probably say, "Log
error".  Or possibly no comment at all.

-Kevin Granade


> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--0016364d29d11cae78047430009e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Sep 22, 2009 at 2:50 PM, Rafael J. Wysoc=
ki <span dir=3D"ltr">&lt;rjw@sisk.pl&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tuesday 22 September 2009, Andreas Mohr wrote:<br>
&gt; Hi Rafael,<br>
<br>
Hi,<br>
<div class=3D"im"><br>
&gt; first you say &quot;returning an error code in such cases would...&quo=
t;<br>
&gt; and then the patch content has...?<br>
<br>
</div>I don&#39;t quite understand your comment, care to elaborate?<br>
<font color=3D"#888888"><br></font></blockquote><div>=A0</div><div>I think =
this is what was being referenced:<br>
<br>
+ =A0 =A0 =A0 /* Return error code if we have failed to change the state */=
<br>
+ =A0 =A0 =A0 if (dev-&gt;current_state !=3D state)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&amp;dev-&gt;dev, &quot;Refused to c=
hange power state, &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;currently in D%d\n&quot=
;, dev-&gt;current_state);<br><br>The comment says, &quot;Return error code=
&quot;, where it should probably say, &quot;Log error&quot;.=A0 Or possibly=
 no comment at all.<br>
<br>-Kevin Granade<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;"><font color=3D"#888888">
Rafael<br>
</font><div><div></div><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br>

--0016364d29d11cae78047430009e--

--===============0348182755172567241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0348182755172567241==--
