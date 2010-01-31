From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
	in the middle of EC transaction
Date: Sun, 31 Jan 2010 23:31:50 +0100
Message-ID: <201001312331.50321.rjw__3607.09538585997$1264977145$gmane$org@sisk.pl>
References: <201001310029.48717.rjw@sisk.pl>
	<1264970500.5544.0.camel@maxim-laptop>
	<201001312209.21212.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001312209.21212.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sunday 31 January 2010, Rafael J. Wysocki wrote:
> On Sunday 31 January 2010, Maxim Levitsky wrote:
> > On Sun, 2010-01-31 at 00:29 +0100, Rafael J. Wysocki wrote: 
> ...
> > >  
> > >  static int acpi_ec_resume(struct acpi_device *device)
> > >  {
> > >  	struct acpi_ec *ec = acpi_driver_data(device);
> > > +
> > > +	mutex_lock(&ec->lock);
> > >  	/* Enable use of GPE back */
> > >  	acpi_enable_gpe(NULL, ec->gpe);
> > > +	/* Allow transactions to happen again */
> > > +	set_bit(EC_FLAGS_SUSPENDED, &ec->flags);
> >           ^^^^^^^^^^^^
> > Thats why it doesn't work here....
> > Will retest now.
> 
> Ouch, sorry.

Fixed version is appended, for the record.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / EC: Add protection from suspending in the middle of EC transaction

There is a race between the suspend process and the EC driver that
may result in suspending in the middle of an EC transaction in
progress, which may lead to unpredictable behavior of the platform.

To remove that race condition, make acpi_ec_suspend() and
acpi_ec_resume() acquire ec->lock and introduce a new EC flag,
EC_FLAGS_SUSPENDED, set in acpi_ec_suspend() and cleared in
acpi_ec_resume(), that will cause acpi_ec_transaction() to return
error code (-EBUSY) if set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -76,8 +76,9 @@ enum ec_command {
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
-	EC_FLAGS_HANDLERS_INSTALLED	/* Handlers for GPE and
+	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
+	EC_FLAGS_SUSPENDED,		/* Driver is suspended */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -291,6 +292,10 @@ static int acpi_ec_transaction(struct ac
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->lock);
+	if (test_bit(EC_FLAGS_SUSPENDED, &ec->flags)) {
+		status = -EBUSY;
+		goto unlock;
+	}
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
@@ -1059,16 +1064,26 @@ error:
 static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
+
+	mutex_lock(&ec->lock);
+	/* Prevent transactions from happening while suspended */
+	set_bit(EC_FLAGS_SUSPENDED, &ec->flags);
 	/* Stop using GPE */
 	acpi_disable_gpe(NULL, ec->gpe);
+	mutex_unlock(&ec->lock);
 	return 0;
 }
 
 static int acpi_ec_resume(struct acpi_device *device)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
+
+	mutex_lock(&ec->lock);
 	/* Enable use of GPE back */
 	acpi_enable_gpe(NULL, ec->gpe);
+	/* Allow transactions to happen again */
+	clear_bit(EC_FLAGS_SUSPENDED, &ec->flags);
+	mutex_unlock(&ec->lock);
 	return 0;
 }
 
