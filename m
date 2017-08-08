From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] ACPI / Sleep: Check low power idle constraints for debug
 only
Date: Tue, 8 Aug 2017 09:51:20 +0200
Message-ID: <20170808075120.GA9258@wunner.de>
References: <1502150037-32786-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502150037-32786-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 07, 2017 at 04:53:57PM -0700, Srinivas Pandruvada wrote:
> +	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid,
> +				    1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> +				    NULL);
> +
> +	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
> +			  out_obj ? "successful" : "failed");
> +
> +	if (!out_obj)
> +		return;
> +
> +	if (out_obj->type != ACPI_TYPE_PACKAGE)
> +		goto free_acpi_buffer;

Using acpi_evaluate_dsm_typed() would avoid having to check the type here.


> +	for (i = 0; i < out_obj->package.count; i++) {
> +		union acpi_object *package = &out_obj->package.elements[i];
> +		struct lpi_device_info info;
> +		int package_count = 0, j;
> +
> +		if (!package)
> +			continue;
> +
> +		info.enabled = 0;
> +		info.package = NULL;
> +		info.name = NULL;

Using a declaration such as

		struct lpi_device_info info = { };

would avoid having to zero the struct elements here.


Thanks,

Lukas
