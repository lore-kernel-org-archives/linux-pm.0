From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Runtime PM: Idle notification
Date: Wed, 16 Dec 2009 11:11:55 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298D7D7F21D@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I had a question on Idle notification in the runtime PM core.

Is this function comment accurate -

+/**
+ * __pm_runtime_idle - Notify device bus type if the device can be suspended.
+ * @dev: Device to notify the bus type about.
+ *
+ * This function must be called under dev->power.lock with interrupts disabled.
+ */
+static int __pm_runtime_idle(struct device *dev)


I also do see that the in the pm_runtime.txt there is a mention -

+The action performed by a bus type's ->runtime_idle() callback is totally
+dependent on the bus type in question, but the expected and recommended action
+is to check if the device can be suspended (i.e. if all of the conditions
+necessary for suspending the device are satisfied) and to queue up a suspend
+request for the device in that case.

If this is the case, are the below checks in __pm_runtime_idle and 
__pm_request_idle suggested?
In __pm_runtime_idle
+	    || dev->power.runtime_status != RPM_ACTIVE)
+		retval = -EAGAIN;
In __pm_request_idle
+	    || dev->power.runtime_status == RPM_SUSPENDED
+		retval = -EAGAIN;


Shouldn't we just return success if power.runtime_status == RPM_SUSPENDED? I 
know it does not make a difference in the runtime PM core as return value for 
the idle callbacks are never checked. But what if someone wants to use idle 
callback API explicitly?


Regards,	
Nithish Mahalingam
