From: "Jordan Crouse" <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Subject: apm_console_blank()
Date: Mon, 28 Mar 2005 10:20:35 -0700
Message-ID: <20050328102035.5fcd9a61@cosmic.amd.com>
References: <1111963367.3503.152.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18445718898852848=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <1111963367.3503.152.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============18445718898852848==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

Everyone, put on your legacy helmets... :)

Attached is a diff against apm.c fixing what I think was a flaw in
the logic of the function apm_console_blank().

Previously, the code tried to power down device 0x100, and, unless that
returned no error, it tried to do the same to device 0x1FF, and unless
*that* returned no error, it tried to power down device 0x101. 
Then, it would try to engage the power management or return a
message based on only the error message of the last call.

Now, it turns out that page 41 of the APM specification indicates that
the system should be engaged, but the devices should start out
disengaged, which is what our BIOS does.  I do understand the system is
engaged at boot time if the apm_bios flags indicate APM_BIOS_DISENGAGED.
What I don't know is if our BIOS should be setting this flag or
not (normally when I get bugs like this, I question why thousands of
systems before me have somehow managed to do the right thing, and it
usually means that we're doing something boneheaded).

If it is not critical that the BIOS be engaged at boot time, then one
would expect that a device could possibly still be disengaged when the
console tries to blank the screen.  So, I went ahead and modified the
code slightly so that any set_power_state() call that returns
NOT_ENGAGED will go ahead and try to engage the device.

Comments and flames welcome.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--- linux-2.6.11.orig/arch/i386/kernel/apm.c	2005-03-28 10:05:01.000000000 -0700
+++ linux-2.6.11/arch/i386/kernel/apm.c	2005-03-28 10:05:12.000000000 -0700
@@ -1058,25 +1058,26 @@
  *	all video devices. Typically the BIOS will do laptop backlight
and  *	monitor powerdown for us.
  */
- 
-static int apm_console_blank(int blank)
-{
-	int	error;
-	u_short	state;
+
+static int apm_console_blank(int blank) {
+	
+	int error, i;
+	u_short state;
+	u_short dev[3] = { 0x100, 0x1FF, 0x101 };
 
 	state = blank ? APM_STATE_STANDBY : APM_STATE_READY;
-	/* Blank the first display device */
-	error = set_power_state(0x100, state);
-	if ((error != APM_SUCCESS) && (error != APM_NO_ERROR)) {
-		/* try to blank them all instead */
-		error = set_power_state(0x1ff, state);
-		if ((error != APM_SUCCESS) && (error != APM_NO_ERROR))
-			/* try to blank device one instead */
-			error = set_power_state(0x101, state);
+
+	for(i = 0; i < 3; i++) {		
+		error = set_power_state(dev[i], state);
+
+		if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
+			return 1;
+
+		if (error == APM_NOT_ENGAGED)
+			break;	       
 	}
-	if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
-		return 1;
-	if (error == APM_NOT_ENGAGED) {
+
+	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
 		static int tried;
 		int eng_error;
 		if (tried++ == 0) {
@@ -1089,7 +1090,8 @@
 				return apm_console_blank(blank);
 		}
 	}
-	apm_error("set display", error);
+
+	apm_error("set display", error);	
 	return 0;
 }
 #endif







--===============18445718898852848==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============18445718898852848==--
