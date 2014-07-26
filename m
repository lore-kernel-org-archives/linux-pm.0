From: Peter Feuerer <peter@piie.net>
Subject: Re: [PATCH v5 3/6] thermal: Added Bang-bang thermal governor
Date: Sat, 26 Jul 2014 16:14:46 +0200
Message-ID: <cone.1406384086.541895.7413.1000@galar>
References: <1398561815-22033-1-git-send-email-peter@piie.net> <1406043436-17068-1-git-send-email-peter@piie.net> <1406043436-17068-4-git-send-email-peter@piie.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:54215 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaGZOOv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Jul 2014 10:14:51 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Feuerer <peter@piie.net>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, Borislav Petkov <bp@suse.de>, Javi Merino <javi.merino@arm.com>

Hi Rui,

Peter Feuerer writes:

> The bang-bang thermal governor uses a hysteresis to switch abruptly on
> or off a cooling device.  It is intended to control fans, which can
> not be throttled but just switched on or off.
> Bang-bang cannot be set as default governor as it is intended for
> special devices only.  For those special devices the driver needs to
> explicitely request it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zhang Rui <rui.zhang@intel.com>

Anything that prevents you from giving your acked-by?

[...]

-- 
kind regards,
--peter;
