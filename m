From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] thermal: Use freezable workqueue
Date: Mon, 7 Feb 2011 20:47:12 -0800
Message-ID: <20110208044712.GA906__37073.1082898148$1297140509$gmane$org@core.coreip.homeip.net>
References: <201102080029.57195.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102080029.57195.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 08, 2011 at 12:29:57AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If thermal polling is enabled, which for example is the case for
> ACPI thermal zones with the _TZP object defined, the thermal driver
> uses delayed work items for this purpose.  Unfortunately, since
> they are queued up using schedule_delayed_work(), the work function
> may be executed during system suspend or resume, which is not
> desirable.
> 
> To prevent that from happening, use a freezable workqueue for
> queuing up delayed work items in the thermal driver.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/thermal/thermal_sys.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/thermal/thermal_sys.c
> ===================================================================
> --- linux-2.6.orig/drivers/thermal/thermal_sys.c
> +++ linux-2.6/drivers/thermal/thermal_sys.c
> @@ -62,6 +62,20 @@ static DEFINE_MUTEX(thermal_list_lock);
>  
>  static unsigned int thermal_event_seqnum;
>  
> +static struct workqueue_struct *thermal_wq;
> +
> +static int __init thermal_start_workqueue(void)
> +{
> +	thermal_wq = alloc_workqueue("thermal", WQ_FREEZEABLE, 0);

Should probably be unbound as well.

FWIW, I would not mind if we had a global freezeable workqueue already
predefined. I could switch input_polldev and vmw_balloon to it and there
probably could be more users...

Thanks.

-- 
Dmitry
