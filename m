From: Frans Pop <elendil@planet.nl>
Subject: Re: [Bug 13865] Can only resume with HP_WMI selected on
	compaq nc6000 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca
	is reverted
Date: Thu, 30 Jul 2009 00:57:47 +0200
Message-ID: <200907300057.48669.elendil__14670.2372505844$1248908338$gmane$org@planet.nl>
References: <bug-13865-10028@http.bugzilla.kernel.org/>
	<200907292257.41573.rjw@sisk.pl>
	<200907292331.34214.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907292331.34214.elendil@planet.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: cedric@belbone.be, linux-kernel@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 29 July 2009, Frans Pop wrote:
> The strange thing is that the resume function does not do anything
> that's not also done in hp_wmi_input_setup(). The only thing I can
> think of is that we might need to test for
> wmi_has_guid(HPWMI_EVENT_GUID) because that model simply does not
> support input events.

If that is the problem, the following patch will hopefully fix it.
This patch is against .31-rc4 but will need only minor changes to
apply against .30.

Subject: hp-wmi: check that an input device exists in resume handler

Some systems may not support input events, or registering the input
handler may have failed. So check that an input device exists before
trying to set the docking and tablet mode state during resume.

Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=13865

Reported-by: cedric@belbone.be
Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 369bd43..63c9214 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -540,11 +540,13 @@ static int hp_wmi_resume_handler(struct device *device)
 	 * the input layer will only actually pass it on if the state
 	 * changed.
 	 */
-
-	input_report_switch(hp_wmi_input_dev, SW_DOCK, hp_wmi_dock_state());
-	input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-			    hp_wmi_tablet_state());
-	input_sync(hp_wmi_input_dev);
+	if (hp_wmi_input_dev) {
+		input_report_switch(hp_wmi_input_dev, SW_DOCK,
+				    hp_wmi_dock_state());
+		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+				    hp_wmi_tablet_state());
+		input_sync(hp_wmi_input_dev);
+	}
 
 	if (wifi_rfkill)
 		rfkill_set_states(wifi_rfkill,
