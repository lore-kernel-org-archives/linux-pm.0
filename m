From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Wed, 02 Dec 2015 03:15:38 +0100
Message-ID: <2730245.RBFquPxppn@vostro.rjw.lan>
References: <1447148554-18401-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56949 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753637AbbLBBpr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 20:45:47 -0500
In-Reply-To: <1447148554-18401-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Tuesday, November 10, 2015 11:42:34 AM Grygorii Strashko wrote:
> It is unsafe [1] if probing of devices will happen during suspend or
> hibernation and system behavior will be unpredictable in this case.
> So, let's prohibit device's probing in dpm_prepare() and defer their
> probing instead. The normal behavior will be restored in
> dpm_complete().
> 
> This patch introduces new DD core APIs:
>  device_block_probing()
>    It will disable probing of devices and defer their probes instead.
>  device_unblock_probing()
>    It will restore normal behavior and trigger re-probing of deferred
>    devices.
> 
> [1] https://lkml.org/lkml/2015/9/11/554
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch queued up for v4.5, thanks!

Rafael

