From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Enable async suspend/resume on industrial IO
	devices
Date: Wed, 06 Apr 2011 11:59:10 +0100
Message-ID: <4D9C477E.4050400__37645.2019125738$1302115333$gmane$org@cam.ac.uk>
References: <1302057915-13549-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1302057915-13549-1-git-send-email-sonnyrao@chromium.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: devel@driverdev.osuosl.org, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Phillip Kurtenbach <pkurtenbach@gmail.com>, snanda@chromium.org, Andrew Morton <akpm@linux-foundation.org>, bleung@chromium.org, linux-pm@lists.linux-foundation.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
List-Id: linux-pm@vger.kernel.org

On 04/06/11 03:45, Sonny Rao wrote:
> Industrial I/O devices can sometimes take a long time to resume,
> allowing them to be asynchronus saves 50ms on one light sensor
> 
Hi Sonny,

cc'd linux-iio

I'm not particularly familiar with this.  Are there any disadvantages?
I just wonder if it would be better to push this into individual drivers
rather than the core?

Jonathan
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> 
> ---
>  drivers/staging/iio/industrialio-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 768f448..a4b099f 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -811,6 +811,8 @@ int iio_device_register(struct iio_dev *dev_info)
>  	if (dev_info->modes & INDIO_RING_TRIGGERED)
>  		iio_device_register_trigger_consumer(dev_info);
>  
> +	device_enable_async_suspend(&dev_info->dev);
> +
>  	return 0;
>  
>  error_free_sysfs:
