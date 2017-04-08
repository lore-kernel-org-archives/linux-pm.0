From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/4] ACPI: utils: Add new acpi_dev_present helper
Date: Sat, 8 Apr 2017 23:40:44 +0200
Message-ID: <20170408214044.GA3894@wunner.de>
References: <20170408212346.8227-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:52469 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdDHVkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2017 17:40:49 -0400
Content-Disposition: inline
In-Reply-To: <20170408212346.8227-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Sat, Apr 08, 2017 at 11:23:43PM +0200, Hans de Goede wrote:
[snip]
> Changes in v3:
> -memset the entire acpi_dev_present_info struct, this fixes
>  acpi_device_id.cls not getting cleared
[snip]
> +bool acpi_dev_present(const char *hid, const char *uid, int hrv)
> +{
> +	struct acpi_dev_present_info match;
> +	struct device *dev;
> +
> +	memset(&match, 0, sizeof(match));

Just use
	struct acpi_dev_present_info match = {};

That's how I did it in parse_acpi_path() in commit 46cd4b75cd0e.
Copy+paste is hard. ;-)

Best regards,

Lukas
