From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: -next: no resume from suspend
Date: Wed, 16 Jan 2013 11:36:05 +0100
Message-ID: <50F68295.3@suse.cz>
References: <50F3D9E8.6040802@suse.cz> <16191961.j5ydKsJ3d3@vostro.rjw.lan> <50F3FFE6.4090108@suse.cz> <87fw21wkk4.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fw21wkk4.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, daniel.vetter@ffwll.ch, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/16/2013 10:20 AM, Jani Nikula wrote:
> Hi Jiri, the dmesgs for both cases with drm.debug=0xe module param might
> give us some clues.
> 
> Does it work without no_console_suspend?

Hi, no, it does not work either way. But what I found out with debug
enabled, that it's a completely different problem: in ACPI. The kernel
is spinning acpi_rs_get_aml_length. I'll report details without CCing
DRM people.

thanks,
-- 
js
suse labs
