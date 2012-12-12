From: Borislav Petkov <bp@alien8.de>
Subject: Re: pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50
 [snd_hda_intel] returns -11
Date: Wed, 12 Dec 2012 17:37:48 +0100
Message-ID: <20121212163748.GF8760@liondog.tnic>
References: <20121211170315.GC28827@liondog.tnic>
 <2487425.bAQggRZzC4@vostro.rjw.lan>
 <20121211175508.GE28827@liondog.tnic>
 <15066310.xXEWfqCuJc@vostro.rjw.lan>
 <20121212105143.GA9252@liondog.tnic>
 <F46914AEC2663F4A9BB62374E5EEF8F829248F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59675 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166Ab2LLQhw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Dec 2012 11:37:52 -0500
Content-Disposition: inline
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F829248F@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Dec 12, 2012 at 03:20:25PM +0000, Lin, Mengdong wrote:
> I remember I didn't observed repetitive attempts to suspend if the
> azx_runtime_suspend() returns -EAGAIN.
>
> Because the HD-A driver does not implement the runtime idle
> callback...

It does now :-)

https://lkml.org/lkml/2012/12/12/128

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
