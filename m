From: Kevin Hilman <khilman@ti.com>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Wed, 11 Jul 2012 16:07:56 -0700
Message-ID: <87ipdthp6b.fsf@ti.com>
References: <Pine.LNX.4.44L0.1207111017010.1559-100000@iolanthe.rowland.org>
	<201207111936.45639.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207111936.45639.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 11 Jul 2012 19:36:45 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday, July 11, 2012, Alan Stern wrote:
>> On Wed, 11 Jul 2012, Rafael J. Wysocki wrote:
>> 
>> > > This opens up the possibility of calling probe while a runtime resume
>> > > or suspend is in progress.  (On the other hand, the existing code
>> > > doesn't prevent a concurrent runtime resume.)  Maybe it would be best
>> > > to leave the pm_runtime_barrier().
>> > 
>> > That wouldn't close the race, though, because the suspend/resume may still
>> > be started right after _barrier has returned.
>> 
>> True, but see below.
>> 
>> > The race is only possible if runtime PM is enabled by a subsystem or PM domain
>> > code before the first eligible driver is registered and if that code is not
>> > careful enough to get ready for driver registration.  I'm not sure how likely
>> > it is to happen in practice.
>> 
>> It's not just the first eligible driver.  Drivers can be bound and 
>> unbound dynamically, and suspends/resume operations can sit on the wait 
>> queue or wait until a timer expires.  We don't want an old request 
>> suddenly to take effect in the middle of a probe.
>> 
>> The barrier will get rid of any old requests.  New ones would have to 
>> be added after the probe starts, which as you say, is unlikely.
>
> OK, I'll keep the barrier, then.
>
> Kevin, can you please double check the patch below?

Yup, this verion looks right and I tested it and verified that it still
fixes the problem I'm seeing.

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

Thanks!

Kevin

> Rafael
>
> ---
>  drivers/base/dd.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Index: linux/drivers/base/dd.c
> ===================================================================
> --- linux.orig/drivers/base/dd.c
> +++ linux/drivers/base/dd.c
> @@ -356,10 +356,9 @@ int driver_probe_device(struct device_dr
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
>  
> -	pm_runtime_get_noresume(dev);
>  	pm_runtime_barrier(dev);
>  	ret = really_probe(dev, drv);
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_idle(dev);
>  
>  	return ret;
>  }
> @@ -406,9 +405,8 @@ int device_attach(struct device *dev)
>  			ret = 0;
>  		}
>  	} else {
> -		pm_runtime_get_noresume(dev);
>  		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
> -		pm_runtime_put_sync(dev);
> +		pm_runtime_idle(dev);
>  	}
>  out_unlock:
>  	device_unlock(dev);
