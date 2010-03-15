From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH] power: support _noirq actions on device
 types and classes
Date: Mon, 15 Mar 2010 21:59:03 +0100
Message-ID: <20100315205903.GA7094@comet.dominikbrodowski.net>
References: <Pine.LNX.4.44L0.1003151247470.1257-100000@iolanthe.rowland.org>
	<201003152035.57927.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003152035.57927.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org
Cc: linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hey,

Does this look right? As PCMCIA seems to be the first user (for 2.6.35), I
can carry it if you prefer. Otherwise, we'd need to be careful that this
gets merged before the next big PCMCIA update for 2.6.35-rc1.

What's possible with this -- 66 insertions(+), 288 deletions(-) -- for the
PCMCIA subsystem can be seen here:

http://git.kernel.org/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=commitdiff;h=ac1986af0977c339dc6072f476e23a42103c980f


From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Mon, 15 Mar 2010 21:43:11 +0100
Subject: [PATCH] power: support _noirq actions on device types and classes

The new-style dev_pm_ops provide callbacks for both IRQs enabled
and disabled. However, the _noirq variants were only called for
buses registered with a device, not for classes and types.

In order to properly use dev_pm_ops in class pcmcia_socket_class,
support _noirq actions also on classes and types.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d477f4d..941fcb8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -439,8 +439,23 @@ static int device_resume_noirq(struct device *dev, pm_message_t state)
 	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "EARLY ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
+		if (error)
+			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "EARLY type ");
+		error = pm_noirq_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
+	if (dev->class && dev->class->pm) {
+		pm_dev_dbg(dev, state, "EARLY class ");
+		error = pm_noirq_op(dev, dev->class->pm, state);
+	}
+
+End:
 	TRACE_RESUME(error);
 	return error;
 }
@@ -735,10 +750,26 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
+	if (dev->class && dev->class->pm) {
+		pm_dev_dbg(dev, state, "LATE class ");
+		error = pm_noirq_op(dev, dev->class->pm, state);
+		if (error)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "LATE type ");
+		error = pm_noirq_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "LATE ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
 	}
+
+End:
 	return error;
 }
 
