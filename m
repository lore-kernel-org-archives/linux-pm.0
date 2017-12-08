From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] base: power: runtime: Export
 pm_runtime_get/put_suppliers
Date: Fri, 8 Dec 2017 14:21:36 +0100
Message-ID: <20171208132136.GA26631@kroah.com>
References: <1512736247-16538-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbdLHNVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 08:21:30 -0500
Content-Disposition: inline
In-Reply-To: <1512736247-16538-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org, robdclark@gmail.com, robin.murphy@arm.com, will.deacon@arm.com, linux-arm-msm@vger.kernel.org

On Fri, Dec 08, 2017 at 06:00:47PM +0530, Vivek Gautam wrote:
> The device link allows the pm framework to tie the supplier and
> consumer. So, whenever the consumer is powered-on, the supplier
> is powered-on first.
> 
> There are however cases in which the consumer wants to power-on
> the supplier, but not itself.
> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> to unmap a buffer and finish the TLB operations without powering
> on itself. Some of these unmap requests are coming from the
> user space when the controller itself is not powered-up, and it
> can be huge penalty in terms of power and latency to power-up
> the graphics/mm controllers.
> There can be an argument that the supplier should handle this case
> on its own and there should not be a need for the consumer to
> power-on the supplier. But as discussed on the thread [1] about
> ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
> in atomic paths, such as in arm_smmu_unmap.
> 
> [1] https://patchwork.kernel.org/patch/9827825/
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/base/power/runtime.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 027d159ac381..af169304ca13 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1578,6 +1578,7 @@ void pm_runtime_get_suppliers(struct device *dev)
>  
>  	device_links_read_unlock(idx);
>  }
> +EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);

We do not export symbols unless there are in-kernel users of them.
Where is the patch that adds a user for these functions?

thanks,

greg k-h
