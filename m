From: Rabin Vincent <rabin@rab.in>
Subject: pm_runtime_suspended() and non-pm_runtime-using (i2c)
	drivers
Date: Tue, 14 Dec 2010 21:24:33 +0530
Message-ID: <AANLkTik7D2mDJN=BaasvLa4xx0fQBgjHREqQB06aD9JU__27580.7306323715$1292342186$gmane$org@mail.gmail.com>
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
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

If an i2c driver uses dev_pm_ops and pm_runtime_suspended() returns true
for the device,  the i2c core will not call the driver's pm->suspend()
routine.  Similar behaviour (except for the if dev_pm_ops check) is
present in the generic PM ops provided in
drivers/base/power/generic_ops.c.

Since pm_runtime_suspended() returns true if the relevant driver did not
call any pm_runtime functions, this means that any driver which does not
use pm_runtime APIs will not get its pm->suspend() callback called
during system sleep, if CONFIG_PM_RUNTIME is enabled.

For the i2c case, there are several such drivers (in drivers/input/*,
etc) lacking these calls.  How is this to be handled?  Do all of these
drivers need to be patched to use the pm_runtime API if they are to be
used on a kernel with PM_RUNTIME enabled?

thanks,
Rabin
