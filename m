From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Issue: Runtime API usage in wake-up device irq_handler
	during wakeup from system-wide-suspend.
Date: Fri, 26 Aug 2011 18:31:33 +0530
Message-ID: <1314363693-20831-1-git-send-email-govindraj.raja__455.602483316575$1314375875$gmane$org@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, Partha Basak <p-basak2@ti.com>, Govindraj R <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

During system_wide_suspend pm runtime is disabled.
I.e. __pm_runtime_disable is called from __device_suspend.
Now, if a wakeup interrupt is triggered and the wakeup device irq handler
is called even before device_resume and pm_runtime_enable happens,
the device irq_handler proceeds to enable clock with runtime API to
handle wakeup event.
 
Wouldn't this result in system wide abort since the pm_runtime is not enabled
yet from dpm_resume?
As we end up accessing regs after doing runtime get_sync.
 
Looks like this scenario is not handled currently.
Or Am I missing something here?

--
Thanks,
Govindraj.R
