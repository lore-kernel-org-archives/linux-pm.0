From: Kevin Hilman <khilman@ti.com>
Subject: use of pm_runtime_disable() from driver probe?
Date: Fri, 06 Jul 2012 15:29:07 -0700
Message-ID: <873954a5ho.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

I've got a question around the proper use of pm_runtime_disable() in a
driver's ->probe method.  Basically, using pm_runtime_disable() in
->probe() (e.g because of a error/failure) can result in the device
remaning runtime enabled forever.  This is because the driver core wraps
the probe in _get_noresume()/_put_sync() so any usage of _put_sync() in
->probe itself does not trigger an actual device runtime suspend.  If
the driver also calls pm_runtime_disable() in probe, that results in the
device remaining runtime enabled.

Consider this example (based on drivers/mmc/host/omap_hsmmc.c).  In the
normal/success path, everything works fine.  But in the failure case,
the after the failed probe, the driver calls pm_runtime_disable() and
the device is left runtime enabled:

driver_probe()
{
    /* usage count == 1; due to _get_noresume() in driver core */
    pm_runtime_enable();
    pm_runtime_get_sync()
    /* usage_count == 2 */
  
    /* probe HW */
    if (failure)
        goto error;    

    /* otherwise, finish HW init */

    pm_runtime_put_sync();
    /* usage_count == 1 */
    /* _put_sync() in driver core will make count = 0
     * and device will be runtime suspended */
    return 0;  

 error:
    pm_runtime_put_sync();
    /* usage_count = 1 */
    pm_runtime_disable();

    /* Now, the _put_sync() in driver core will not actually suspend
       since runtime PM has been disabled. */
}


So, the question is: is it right to use pm_runtime_disable() this way?

Removing it means the device is left in runtime suspended state even in
the error case.  However, without the pm_runtime_disable(), if this
driver was a module, repeated attempts to load would result in
unbalalced calls to pm_runtime_enable.

What is the right way to handle the runtime PM enable/disable in a
failed probe attempt?

Thanks,

Kevin
