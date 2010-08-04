From: Matthias Hopf <mhopf@suse.de>
Subject: Re: [PATCH] ACPI / PM: Traverse video_device_list for
	backlight	restoration
Date: Wed, 4 Aug 2010 13:00:23 +0200
Message-ID: <20100804110023.GA17385__24617.2204999768$1280919802$gmane$org@suse.de>
References: <20100803100505.GA26948@suse.de> <20100803101157.GA29721@suse.de>
	<1280885249.1779.97.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1280885249.1779.97.camel@rui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Oliver Neukum <oneukum@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Aug 04, 10 09:27:29 +0800, Zhang Rui wrote:
> On Tue, 2010-08-03 at 18:11 +0800, Matthias Hopf wrote:
> > The .bind_info is later used in acpi_video_resume() to re-set the backlight
> > - but it's only evaluated on the active_list[], on which all .bind_info are
> > NULL by construction.
> why? .bind_info in active_list is initialized in acpi_video_device_bind.

Hm. Right. acpi_video_bus_get_one_device() is called after _enumerate().
Dunno why I didn't read this correctly.

> > I don't understand
> > why the list is (partially) transformed into an array in the first place,
> > especially as both the array *and* the list are used in the code...
> > 
> no, the active_list is an array in fact, which equals
> acpi_video_bus->attached_array. Maybe we need to change it to a more
> proper name.

:-)

> I'm still wondering why the patch works for you.

Same to me.

> could you please attach the acpidump output of this laptop?

Will do.

> please rebuild your kernel with CONFIG_ACPI_DEBUG=y, and reboot with
> kernel parameter "acpi.debug_layer=0x10 acpi.debug_level=0x400".
> and attach the dmesg output after resume, both w/ and w/o the patch you
> attached.

The most intriguing thing here is that the system starts writing to
/var/log/messages continuously, thus dmesg output is sort-of worthless.
This might be a reasonable side effect, it might be an indication of the
original issue.
I'll try to compile something for you.

Thanks

Matthias

-- 
Matthias Hopf <mhopf@suse.de>      __        __   __
Maxfeldstr. 5 / 90409 Nuernberg   (_   | |  (_   |__          mat@mshopf.de
Phone +49-911-74053-715           __)  |_|  __)  |__  R & D   www.mshopf.de
