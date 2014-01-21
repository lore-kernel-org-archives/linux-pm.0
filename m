From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / PM: Use ACPI_COMPANION() to get ACPI companions
 of devices
Date: Tue, 21 Jan 2014 11:45:13 +0200
Message-ID: <20140121094513.GK18029@intel.com>
References: <3698474.jasU9n7YCg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51562 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbaAUJiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jan 2014 04:38:21 -0500
Content-Disposition: inline
In-Reply-To: <3698474.jasU9n7YCg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>

On Sun, Jan 19, 2014 at 04:38:33PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI device PM code in device_pm.c uses a special function,
> acpi_dev_pm_get_node(), to obtain an ACPI companion object of a given
> device.  However, that is not necessary any more after recent changes
> that introduced the ACPI_COMPANION() macro serving exactly the same
> purpose, but working in a much more straightforward way.  For this
> reason, drop acpi_dev_pm_get_node() and use ACPI_COMPANION() instead
> of it everywhere.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
