From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug-fix]:2.6.25-rc0 Generic thermal management
 [Patch 1/2]: validating input parameters
Date: Mon, 11 Feb 2008 13:38:27 -0800
Message-ID: <20080211133827.16140ba0.akpm__16624.8487578288$1202773047$gmane$org@linux-foundation.org>
References: <05B550FD4BD2014E841D83547B62600802A3A1B0@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <05B550FD4BD2014E841D83547B62600802A3A1B0@bgsmsx411.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Feb 2008 15:57:06 +0530
"Thomas, Sujith" <sujith.thomas@intel.com> wrote:

> From: Thomas Sujith <sujith.thomas@intel.com>
> 
> Added sanity checks for interface functions in thermal with
> other modules such as fan, processor, video etc..
> 
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> ---
> drivers/thermal/thermal.c |   69
> +++++++++++++++++++++++++++++-----------------

The patch is fairly seriously wordwrapped.

>  1 files changed, 44 insertions(+), 25 deletions(-)
> 
> Index: linux-2.6.24-rc3/drivers/thermal/thermal.c
> ===================================================================
> --- linux-2.6.24-rc3.orig/drivers/thermal/thermal.c
> +++ linux-2.6.24-rc3/drivers/thermal/thermal.c
> @@ -301,13 +301,27 @@ int thermal_zone_bind_cooling_device(str
>  {
>  	struct thermal_cooling_device_instance *dev;
>  	struct thermal_cooling_device_instance *pos;
> +	struct thermal_zone_device *pos1;
> +	struct thermal_cooling_device *pos2;
>  	int result;
>  
> +	if (!tz || !cdev)
> +		return -EINVAL;

Is this change actually needed?  It's sloppy for a caller to be passing
invalid arguments into a callee, and it's not good for the callee to just
hide that sloppiness.

> -		return NULL;
> +		return  ERR_PTR(-EINVAL);

the patch adds several spaces like this in places where we don't normally
put them.
