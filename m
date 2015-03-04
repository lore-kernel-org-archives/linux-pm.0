From: Javi Merino <javi.merino@arm.com>
Subject: Re: select on undefined THERMAL_POWER_ACTOR
Date: Wed, 4 Mar 2015 17:46:24 +0000
Message-ID: <20150304174623.GA14216@e104805>
References: <CAD3Xx4KK5LGJSPHvsnX36EUB-T6j_6RgGw=oQ+gZyP8RBhC1=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55790 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758862AbbCDRq1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 12:46:27 -0500
In-Reply-To: <CAD3Xx4KK5LGJSPHvsnX36EUB-T6j_6RgGw=oQ+gZyP8RBhC1=Q@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Andreas Ruprecht <rupran@einserver.de>, Paul Bolle <pebolle@tiscali.nl>

Hi Valentin,

On Wed, Mar 04, 2015 at 01:19:25PM +0000, Valentin Rothberg wrote:
> your commit 8754d5115693 ("thermal: introduce the Power Allocator
> governor") is included in today's linux-next tree (i.e.,
> next-20150304).
> 
> This patch adds a select on the Kconfig symbol THERMAL_POWER_ACTOR.
> However, THERMAL_POWER_ACTOR is not defined so that this select is a
> NOOP.
> 
> @@ -99,6 +107,13 @@ config THERMAL_GOV_USER_SPACE
>         help
>           Enable this to let the user space manage the platform thermals.
> 
> +config THERMAL_GOV_POWER_ALLOCATOR
> +       bool "Power allocator thermal governor"
> +       select THERMAL_POWER_ACTOR
> 
> Is there a patch queued somewhere that adds this Kconfig symbol?

No there isn't, it's a leftover from a previous version of the
patches.  I'll send a patch to remove it.

Thanks for reporting it!
Javi

>                                                                   I
> detected the issue by running undertaker-checkpatch from the
> Undertaker tool suite (undertaker.cs.fau.de).
> 
> Kind regards,
>  Valentin

