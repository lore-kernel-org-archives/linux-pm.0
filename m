From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Sat, 7 Jul 2012 21:25:26 +0200
Message-ID: <201207072125.26189.rjw@sisk.pl>
References: <873954a5ho.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <873954a5ho.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, July 07, 2012, Kevin Hilman wrote:
> Hello,
> 
> I've got a question around the proper use of pm_runtime_disable() in a
> driver's ->probe method.  Basically, using pm_runtime_disable() in
> ->probe() (e.g because of a error/failure) can result in the device
> remaning runtime enabled forever.

Er, no.

> This is because the driver core wraps
> the probe in _get_noresume()/_put_sync() so any usage of _put_sync() in
> ->probe itself does not trigger an actual device runtime suspend.  If
> the driver also calls pm_runtime_disable() in probe, that results in the
> device remaining runtime enabled.

I'm not quite sure what way.  pm_runtime_disable() increments
dev->power.disable_count and if that is not decremented later, the
device remains runtime disabled.

You probably wanted to say that the device will end up in the full-power
state in that case, which isn't the same and is intentional.

> Consider this example (based on drivers/mmc/host/omap_hsmmc.c).  In the
> normal/success path, everything works fine.  But in the failure case,
> the after the failed probe, the driver calls pm_runtime_disable() and
> the device is left runtime enabled:
> 
> driver_probe()
> {
>     /* usage count == 1; due to _get_noresume() in driver core */
>     pm_runtime_enable();
>     pm_runtime_get_sync()
>     /* usage_count == 2 */
>   
>     /* probe HW */
>     if (failure)
>         goto error;    
> 
>     /* otherwise, finish HW init */
> 
>     pm_runtime_put_sync();
>     /* usage_count == 1 */
>     /* _put_sync() in driver core will make count = 0
>      * and device will be runtime suspended */
>     return 0;  
> 
>  error:
>     pm_runtime_put_sync();
>     /* usage_count = 1 */
>     pm_runtime_disable();
> 
>     /* Now, the _put_sync() in driver core will not actually suspend
>        since runtime PM has been disabled. */
> }
> 
> 
> So, the question is: is it right to use pm_runtime_disable() this way?

If your intention is to put the device into a low-power state in case of
a failing .probe(), this isn't the way to do it.  pm_runtime_disable()
means "don't do any runtime power management on this device any more"
regardless of the current state of the device (it may resume the device
in some situations, but it won't suspend it, although it may wait for
a suspend in progress to complete).

That said, I'm not aware of any other generally reliable way to do that
either.  The problem is, if .probe() is failing we don't have callbacks
allowing us to power manage the device (there may be bus type callbacks
knowing how to do that, but not for the platform bus type).

> Removing it means the device is left in runtime suspended state even in
> the error case.  However, without the pm_runtime_disable(), if this
> driver was a module, repeated attempts to load would result in
> unbalalced calls to pm_runtime_enable.
> 
> What is the right way to handle the runtime PM enable/disable in a
> failed probe attempt?

I would recommend using pm_runtime_disable() and then either
pm_runtime_set_active() or pm_runtime_set_suspended() depending on what the
real power state of the device is at this point.

Anyway, you can't force the device into a low-power state using runtime PM
after a failing probe, at least in general.

Thanks,
Rafael
