From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/3] ACPI / scan: Change ordering of locks for device
 hotplug
Date: Fri, 30 Aug 2013 18:17:37 -0600
Message-ID: <1377908257.10300.896.camel@misato.fc.hp.com>
References: <9589253.Co8jZpnWdd@vostro.rjw.lan>
	 <1752041.76DW3TEE1A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1752041.76DW3TEE1A@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-mm@kvack.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2013-08-29 at 23:15 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change the ordering of device hotplug locks in scan.c so that
> acpi_scan_lock is always acquired after device_hotplug_lock.
> 
> This will make it possible to use device_hotplug_lock around some
> code paths that acquire acpi_scan_lock safely (most importantly
> system suspend and hibernation).  Apart from that, acpi_scan_lock
> is platform-specific and device_hotplug_lock is general, so the
> new ordering appears to be more appropriate from the overall
> design viewpoint.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
