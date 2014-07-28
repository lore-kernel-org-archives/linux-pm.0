From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v5 3/6] thermal: Added Bang-bang thermal governor
Date: Mon, 28 Jul 2014 10:26:29 +0800
Message-ID: <1406514389.14109.7.camel@rzhang1-toshiba>
References: <1398561815-22033-1-git-send-email-peter@piie.net>
	 <1406043436-17068-1-git-send-email-peter@piie.net>
	 <1406043436-17068-4-git-send-email-peter@piie.net>
	 <cone.1406384086.541895.7413.1000@galar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42392 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbaG1C0g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 27 Jul 2014 22:26:36 -0400
In-Reply-To: <cone.1406384086.541895.7413.1000@galar>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Feuerer <peter@piie.net>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, Borislav Petkov <bp@suse.de>, Javi Merino <javi.merino@arm.com>

On Sat, 2014-07-26 at 16:14 +0200, Peter Feuerer wrote:
> Hi Rui,
> 
> Peter Feuerer writes:
> 
> > The bang-bang thermal governor uses a hysteresis to switch abruptly on
> > or off a cooling device.  It is intended to control fans, which can
> > not be throttled but just switched on or off.
> > Bang-bang cannot be set as default governor as it is intended for
> > special devices only.  For those special devices the driver needs to
> > explicitely request it.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> 
> Anything that prevents you from giving your acked-by?
> 
NO.

I'll queue them for 3.18.

thanks,
rui

