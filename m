From: Matt Hsu <matt@0xlab.org>
Subject: Re: [TuxOnIce-devel] [RFC PATCH] Current status,
 suspend-to-disk support on ARM
Date: Mon, 18 Apr 2011 13:48:34 +0800
Message-ID: <BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ__39731.9706892178$1303150943$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8916037516506311680=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
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
To: frank.hofmann@tomtom.com
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============8916037516506311680==
Content-Type: multipart/alternative; boundary=001636c934c537deb504a12af136

--001636c934c537deb504a12af136
Content-Type: text/plain; charset=ISO-8859-1

>
>
> The last thing here in my setup that's obviously not correctly suspending /
> resuming is the OMAP display driver; I'm not the only one with that problem,
> Matt's previous report:
>
> http://blog.gmane.org/gmane.linux.swsusp.devel/month=20101201
>
> has the same thing, "omapdss DISPC error: SYNC_LOST, disabling LCD".
>
>
>     Hi FrankH,

    Above issue could be resolved by:

   - CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE=y
   - the following patch

diff --git a/drivers/video/omap2/dss/dispc.c
b/drivers/video/omap2/dss/dispc.c
index 8b3ac80..a188732 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2784,7 +2784,6 @@ static void dispc_error_worker(struct work_struct
*work)
                bool enable = false;

                DSSERR("SYNC_LOST, disabling LCD\n");

                for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
                        struct omap_overlay_manager *mgr;
                        mgr = omap_dss_get_overlay_manager(i);
@@ -2815,6 +2814,9 @@ static void dispc_error_worker(struct work_struct
*work)
                        if (enable)
                                manager->device->enable(manager->device);
                }
+
+               dispc_enable_lcd_out(false);
+               dispc_enable_lcd_out(true);

     Although this patch is somehow nasty, but it work anyway.

- Matt

--001636c934c537deb504a12af136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddin=
g-left: 1ex;">
<br>
<br>
The last thing here in my setup that&#39;s obviously not correctly suspendi=
ng / resuming is the OMAP display driver; I&#39;m not the only one with tha=
t problem, Matt&#39;s previous report:<br>
<br>
<a href=3D"http://blog.gmane.org/gmane.linux.swsusp.devel/month=3D20101201"=
 target=3D"_blank">http://blog.gmane.org/gmane.linux.swsusp.devel/month=3D2=
0101201</a><br>
<br>
has the same thing, &quot;omapdss DISPC error: SYNC_LOST, disabling LCD&quo=
t;.<br>
<br>
<br></blockquote><div>=A0=A0=A0 Hi FrankH,<br><br>=A0=A0=A0 Above issue cou=
ld be resolved by:<br><br>=A0=A0 - CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE=3Dy<br=
>=A0=A0 - the following patch<br><br>diff --git a/drivers/video/omap2/dss/d=
ispc.c b/drivers/video/omap2/dss/dispc.c<br>
index 8b3ac80..a188732 100644<br>--- a/drivers/video/omap2/dss/dispc.c<br>+=
++ b/drivers/video/omap2/dss/dispc.c<br>@@ -2784,7 +2784,6 @@ static void d=
ispc_error_worker(struct work_struct *work)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 bool enable =3D false;<br>
=A0<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DSSERR(&quot;SYNC_LOST=
, disabling LCD\n&quot;);<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 for (i =3D 0; i &lt; omap_dss_get_num_overlay_managers(); ++i) {<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct o=
map_overlay_manager *mgr;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 mgr =3D omap_dss_get_overlay_manager(i);<br>
@@ -2815,6 +2814,9 @@ static void dispc_error_worker(struct work_struct *wo=
rk)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (enable)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 manager-&gt;device-&gt;enable(manag=
er-&gt;device);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>
+<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dispc_enable_lcd_out(false=
);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dispc_enable_lcd_out(true=
);<br><br>=A0=A0=A0=A0 Although this patch is somehow nasty, but it work an=
yway.<br></div></div><br>- Matt<br>

--001636c934c537deb504a12af136--

--===============8916037516506311680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8916037516506311680==--
