From: Michal Hocko <mhocko@suse.cz>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Tue, 13 Apr 2010 10:27:56 +0200
Message-ID: <20100413082756.GA5233__4130.24407248503$1271166616$gmane$org@tiehlicka.suse.cz>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<1270848027.3071.0.camel@localhost>
	<201004102136.43246.rjw@sisk.pl> <201004130101.54117.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004130101.54117.rjw@sisk.pl>
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
Cc: Tony Vroon <tony@linx.net>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue 13-04-10 01:01:54, Rafael J. Wysocki wrote:
> On Saturday 10 April 2010, Rafael J. Wysocki wrote:
> > On Friday 09 April 2010, Tony Vroon wrote:
> > > On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > > > Please check if the patch below changes anything.
> > > >  drivers/acpi/wakeup.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > That didn't change the behaviour for me, sorry.
> > 
> > Well, I would be sorry if it did, because the patch removed some useful code. :-)
> > 
> > > (I made sure to go through a full power down session before trying the
> > > patched kernel)
> > 
> > Thanks for testing.  So it looks like we don't disable the GPE during power off.
> > 
> > I'll try to figure out what's going on, please stay tuned.
> 
> Can you please check if the patch below changes the behavior?

Unfortunately, it didn't help either (I have tried on top of the fresh
rc4).

> 
> Rafael
> 
> ---
>  drivers/acpi/wakeup.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/wakeup.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/wakeup.c
> +++ linux-2.6/drivers/acpi/wakeup.c
> @@ -63,17 +63,17 @@ void acpi_enable_wakeup_device(u8 sleep_
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  		struct acpi_device *dev =
>  			container_of(node, struct acpi_device, wakeup_list);
> +		u8 action = ACPI_GPE_ENABLE;
>  
>  		if (!dev->wakeup.flags.valid)
>  			continue;
>  
>  		if ((!dev->wakeup.state.enabled && !dev->wakeup.prepare_count)
>  		    || sleep_state > (u32) dev->wakeup.sleep_state)
> -			continue;
> +			action = ACPI_GPE_DISABLE;
>  
> -		/* The wake-up power should have been enabled already. */
>  		acpi_set_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
> -				ACPI_GPE_ENABLE);
> +				action);
>  	}
>  }
>  

-- 
Michal Hocko
L3 team 
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
