From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: apm_console_blank()
Date: Tue, 29 Mar 2005 20:51:00 +0200
Message-ID: <20050329185100.GB7929@elf.ucw.cz>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<20050328102035.5fcd9a61@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82945648915945225=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050328102035.5fcd9a61-aftB2sG12IhaqnLngUycEA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Jordan Crouse <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============82945648915945225==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Everyone, put on your legacy helmets... :)
> 
> Attached is a diff against apm.c fixing what I think was a flaw in
> the logic of the function apm_console_blank().

I guess you need to send it to APM maintainer...

Please inline your patches, its easier to comment on them that way.

--- linux-2.6.11.orig/arch/i386/kernel/apm.c    2005-03-28 10:05:01.000000000 -0700
+++ linux-2.6.11/arch/i386/kernel/apm.c 2005-03-28 10:05:12.000000000 -0700
@@ -1058,25 +1058,26 @@
  *     all video devices. Typically the BIOS will do laptop backlight
and  *  monitor powerdown for us.
  */
-
-static int apm_console_blank(int blank)
-{
-       int     error;
-       u_short state;
+
+static int apm_console_blank(int blank) {
+
+       int error, i;
+       u_short state;

You are actually breaking formating here.

+       u_short dev[3] = { 0x100, 0x1FF, 0x101 };

        state = blank ? APM_STATE_STANDBY : APM_STATE_READY;
-       /* Blank the first display device */
-       error = set_power_state(0x100, state);
-       if ((error != APM_SUCCESS) && (error != APM_NO_ERROR)) {
-               /* try to blank them all instead */
-               error = set_power_state(0x1ff, state);
-               if ((error != APM_SUCCESS) && (error != APM_NO_ERROR))
-                       /* try to blank device one instead */
-                       error = set_power_state(0x101, state);
+
+       for(i = 0; i < 3; i++) {

Please put space between for and (.

@@ -1089,7 +1090,8 @@
                                return apm_console_blank(blank);
                }
        }
-       apm_error("set display", error);
+
+       apm_error("set display", error);
        return 0;
 }

...and don't do change formatting just because you can.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============82945648915945225==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82945648915945225==--
