From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 11/27] i915: intel_acpi: convert acpi_get_handle() to
 acpi_has_method()
Date: Mon, 9 Sep 2013 10:57:48 +0200
Message-ID: <20130909085748.GD27291@phenom.ffwll.local>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
 <1378168335-22556-12-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:63442 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3III5f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2013 04:57:35 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so2948554eaj.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2013 01:57:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378168335-22556-12-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>

On Tue, Sep 03, 2013 at 08:31:59AM +0800, Zhang Rui wrote:
> acpi_has_method() is a new ACPI API introduced to check
> the existence of an ACPI control method.
> 
> It can be used to replace acpi_get_handle() in the case that
> 1. the calling function doesn't need the ACPI handle of the control method.
> and
> 2. the calling function doesn't care the reason why the method is unavailable.
> 
> Convert acpi_get_handle() to acpi_has_method()
> in drivers/gpu/drm/i915/intel_acpi.c in this patch.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> CC: Daniel Vetter <daniel.vetter@ffwll.ch>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/i915/intel_acpi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_acpi.c b/drivers/gpu/drm/i915/intel_acpi.c
> index 57fe1ae..43959ed 100644
> --- a/drivers/gpu/drm/i915/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/intel_acpi.c
> @@ -193,16 +193,14 @@ static void intel_dsm_platform_mux_info(void)
>  
>  static bool intel_dsm_pci_probe(struct pci_dev *pdev)
>  {
> -	acpi_handle dhandle, intel_handle;
> -	acpi_status status;
> +	acpi_handle dhandle;
>  	int ret;
>  
>  	dhandle = DEVICE_ACPI_HANDLE(&pdev->dev);
>  	if (!dhandle)
>  		return false;
>  
> -	status = acpi_get_handle(dhandle, "_DSM", &intel_handle);
> -	if (ACPI_FAILURE(status)) {
> +	if (!acpi_has_method(dhandle, "_DSM")) {
>  		DRM_DEBUG_KMS("no _DSM method for intel device\n");
>  		return false;
>  	}
> -- 
> 1.8.1.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
