From: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [driver-core PATCH v7 4/9] driver core: Probe devices
 asynchronously instead of the driver
Date: Fri, 30 Nov 2018 18:48:47 -0800
Message-ID: <20181201024847.GH28501@garbanzo.do-not-panic.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345154692.18040.8161459765233879389.stgit@ahduyck-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <154345154692.18040.8161459765233879389.stgit-+uVpp3jiz/SWyQ3uPIV3rPooFf0ArEBIu+b9c/7xato@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bvanassche-HInyCGIudOg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 28, 2018 at 04:32:26PM -0800, Alexander Duyck wrote:
> Probe devices asynchronously instead of the driver.

> +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
> +{
> +	struct device *dev = _dev;
> +	struct device_driver *drv;
> +
> +	__device_driver_lock(dev, dev->parent);
> +
> +	/*
> +	 * If someone attempted to bind a driver either successfully or
> +	 * unsuccessfully before we got here we should just skip the driver
> +	 * probe call.
> +	 */
> +	drv = dev_get_drv_async(dev);
> +	if (drv && !dev->driver)
> +		driver_probe_device(drv, dev);

I believe this should mean drivers which have async work on probe can
deadlock. For instance, if a driver does call async_schedule() or a
derivative call does this for it, the kernel will call
async_synchronize_full() and I believe we deadlock.

Are we sure most subsystems which would use async probe will not have
an async_schedule() call?

  Luis
