From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] power: surface3_power: MSHW0011 rev-eng
 implementation
Date: Tue, 16 Aug 2016 13:02:36 +0300
Message-ID: <20160816100236.GF1751@lahna.fi.intel.com>
References: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 29, 2016 at 05:49:26PM +0200, Benjamin Tissoires wrote:
> +static const struct i2c_device_id mshw0011_id[] = {
> +	{ "MSHW0011:00", 0 },

You should not use ACPI device names in non-ACPI matching table. I think
you can just leave this table empty.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
