From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/10] ACPI: register ACPI Video LCD as
	generic thermal cooling device
Date: Thu, 17 Jan 2008 12:24:31 +0000
Message-ID: <20080117122431.GA32133__13196.3416039527$1200585398$gmane$org@srcf.ucam.org>
References: <1200556282.2935.122.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200556282.2935.122.camel@acpi-sony.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sujith.thomas@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2008 at 03:51:22PM +0800, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Register ACPI video device as thermal cooling devices as they may be listed
> in _TZD method and the backlight control can be used for throttling.

I'm worried to some extent about how ungeneric this is. A thermal zone 
may cover any devices, not just processor and video ones. Perhaps this 
should be added to the acpi_device struct instead, and then let 
individual drivers implement whatever callbacks are appropriate?

> +static int
> +video_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
> +{
> +	struct acpi_device *device = cdev->devdata;
> +	struct acpi_video_device *video = acpi_driver_data(device);
> +	int level;
> +
> +	if ( state >= video->brightness->count - 2)
> +		return -EINVAL;
> +
> +	state = video->brightness->count - state;
> +	level = video->brightness->levels[state -1];
> +	return acpi_video_device_lcd_set_level(video, level);

This all seems like duplication of the backlight interface?

(Speaking of which - Len, what's happening with my patches to the video 
driver? Some feedback would be nice)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
