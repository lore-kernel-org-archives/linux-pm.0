From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Thu, 3 May 2007 15:06:27 +0200
Message-ID: <200705031506.28559.rjw@sisk.pl>
References: <f129n6$mro$1@sea.gmane.org> <200705031006.27068.rjw@sisk.pl>
	<200705031341.05023.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031341.05023.marcus@better.se>
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
To: Marcus Better <marcus@better.se>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 13:41, Marcus Better wrote:
> Rafael J. Wysocki wrote:
> > Could you please test the appended patch instead of the previous one?
> 
> It doesn't work. The suspend LED flashed for a while but the screen was blank 
> and didn't show any messages. It powered down after a while, without writing 
> anything to disk.

Hmm, perhaps we should do something more, like the following:

 drivers/acpi/hardware/hwsleep.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Index: linux-2.6.21/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.21.orig/drivers/acpi/hardware/hwsleep.c	2007-04-26 05:08:32.000000000 +0200
+++ linux-2.6.21/drivers/acpi/hardware/hwsleep.c	2007-05-03 12:57:22.000000000 +0200
@@ -193,18 +193,13 @@ acpi_status acpi_enter_sleep_state_prep(
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = sleep_state;
 
-	/* Run the _PTS and _GTS methods */
+	/* Run the _PTS method */
 
 	status = acpi_evaluate_object(NULL, METHOD_NAME__PTS, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		return_ACPI_STATUS(status);
 	}
 
-	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Setup the argument to _SST */
 
 	switch (sleep_state) {
@@ -266,6 +261,8 @@ acpi_status asmlinkage acpi_enter_sleep_
 	u32 PM1Bcontrol;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
 	u32 in_value;
 	acpi_status status;
 
@@ -312,6 +309,19 @@ acpi_status asmlinkage acpi_enter_sleep_
 		return_ACPI_STATUS(status);
 	}
 
+	/* Execute the _GTS method */
+
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = sleep_state;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+
+	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Get current value of PM1A control */
 
 	status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
