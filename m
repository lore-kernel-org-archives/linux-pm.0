From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI / PM: Traverse video_device_list for
 backlight restoration
Date: Wed, 04 Aug 2010 09:27:29 +0800
Message-ID: <1280885249.1779.97.camel__44215.981095522$1280885177$gmane$org@rui>
References: <20100803100505.GA26948@suse.de> <20100803101157.GA29721@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100803101157.GA29721@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthias Hopf <mhopf@suse.de>
Cc: Oliver Neukum <oneukum@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-08-03 at 18:11 +0800, Matthias Hopf wrote:
> A bit of background about this patch:
> 
> 
> acpi_video_bus_get_devices() explicitly calls acpi_video_device_enumerate()
> before acpi_video_bus_get_one_device(), which does acpi_video_device_bind().
> 
> In _enumerate(), active_list[] is created, with .bind_info explicitly set to
> NULL, while the related .bind_info entry in video_device_list is set to the
> acpi_video_device ptr in _bind().
> 
> The .bind_info is later used in acpi_video_resume() to re-set the backlight
> - but it's only evaluated on the active_list[], on which all .bind_info are
> NULL by construction.

why? .bind_info in active_list is initialized in acpi_video_device_bind.

>   This results in backlight not being restored, if the
> BIOS doesn't do this by itself already.
> 
> 
> The patch resolves this by replacing the active_list[] traversal by a
> video_device_list traversal,

>  but due to the nature of the issue I'm unsure
> whether the original issue isn't of more principal quality.


> I don't understand
> why the list is (partially) transformed into an array in the first place,
> especially as both the array *and* the list are used in the code...
> 
no, the active_list is an array in fact, which equals
acpi_video_bus->attached_array. Maybe we need to change it to a more
proper name.

I'm still wondering why the patch works for you.
could you please attach the acpidump output of this laptop?

please rebuild your kernel with CONFIG_ACPI_DEBUG=y, and reboot with
kernel parameter "acpi.debug_layer=0x10 acpi.debug_level=0x400".
and attach the dmesg output after resume, both w/ and w/o the patch you
attached.

thanks,
rui
