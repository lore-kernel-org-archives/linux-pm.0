From: Rene Herman <rene.herman@keyaccess.nl>
Subject: -mm: pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
 breaks resuming isapnp cards
Date: Sat, 12 Jan 2008 21:08:01 +0100
Message-ID: <47891E21.8060209__28815.386867109$1200325258$gmane$org@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>
	<20080112162150.1ec9cad0@poseidon.drzeus.cx>
	<4788F226.7040101@keyaccess.nl> <200801122008.10313.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030900050006070904040005"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801122008.10313.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------030900050006070904040005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

pnp-do-not-stop-start-devices-in-suspend-resume-path.patch in current -mm 
breaks resuming isapnp cards from hibernation. They need the pnp_start_dev 
to enable the device again after hibernation.

They don't really need the pnp_stop_dev() which the above mentioned patch 
also removes but with the pnp_start_dev() restored it seems pnp_stop_dev() 
should also stay. Bjorn Helgaas should decide  -- currently the patch as you 
have it breaks drivers though. Could you drop it?

Then, if so and after you do that, could you apply the attached? That's also 
needed to resume (ALSA) ISA-PnP cards from hibernation due to the 
RES_DO_NOT_CHANGE test triggering for ALSA drivers and the pnp_start_dev() 
still not happening. More in the changelog...

On 12-01-08 20:08, Rafael J. Wysocki wrote:

> On Saturday, 12 of January 2008, Rene Herman wrote:

>> It seems all PnP drivers would need to stick a pnp_start_dev in their resume 
>> method
> 
> Yes.
> 
>> then which means it really belongs in core.
> 
> Yes, if practical.
> 
>> One important point where PnP and PCI differ is that PnP allows to change the
>> resources on a protocol level and I don't see how it could ever not be
>> necessary to restore the state a user may have set if power has been
>> removed. Hibernate is just that, isn't it?
> 
> Basically, yes, it is.

Rene.


--------------030900050006070904040005
Content-Type: text/plain;
 name="pnp_driver_res_do_not_test.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp_driver_res_do_not_test.diff"

commit 7d16e8b3e7739599d32c8006f9e84fadb86b8296
Author: Rene Herman <rene.herman@gmail.com>
Date:   Sat Jan 12 00:00:35 2008 +0100

    PNP: do not test PNP_DRIVER_RES_DO_NOT_CHANGE on suspend/resume
    
    The PNP_DRIVER_RES_DO_NOT_CHANGE flag is meant to signify that
    the PNP core should not change resources for the device -- not
    that it shouldn't disable/enable the device on suspend/resume.
    
    ALSA ISAPnP drivers set PNP_DRIVER_RES_DO_NOT_CHANAGE (0x0001)
    through setting PNP_DRIVER_RES_DISABLE (0x0003). The latter
    including the former may in itself be considered rather
    unexpected but doesn't change that suspend/resume wouldn't seem
    to have any business testing the flag.
    
    As reported by Ondrej Zary for snd-cs4236, ALSA driven ISAPnP
    cards don't survive swsusp hibernation with the resume skipping
    setting the resources due to testing the flag -- the same test
    in the suspend path isn't enough to keep hibernation from
    disabling the card it seems.
    
    These tests were added (in 2005) by Piere Ossman in commit
    68094e3251a664ee1389fcf179497237cbf78331, "alsa: Improved PnP
    suspend support" who doesn't remember why. This deletes them.
    
    Signed-off-by: Rene Herman <rene.herman@gmail.com>
    Tested-by: Ondrej Zary <linux@rainbow-software.org>

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index a262762..12a1645 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -161,8 +161,7 @@ static int pnp_bus_suspend(struct device *dev, pm_message_t state)
 			return error;
 	}
 
-	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
-	    pnp_can_disable(pnp_dev)) {
+	if (pnp_can_disable(pnp_dev)) {
 		error = pnp_stop_dev(pnp_dev);
 		if (error)
 			return error;
@@ -185,14 +184,17 @@ static int pnp_bus_resume(struct device *dev)
 	if (pnp_dev->protocol && pnp_dev->protocol->resume)
 		pnp_dev->protocol->resume(pnp_dev);
 
-	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
+	if (pnp_can_write(pnp_dev)) {
 		error = pnp_start_dev(pnp_dev);
 		if (error)
 			return error;
 	}
 
-	if (pnp_drv->resume)
-		return pnp_drv->resume(pnp_dev);
+	if (pnp_drv->resume) {
+		error = pnp_drv->resume(pnp_dev);
+		if (error)
+			return error;
+	}
 
 	return 0;
 }

--------------030900050006070904040005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030900050006070904040005--
