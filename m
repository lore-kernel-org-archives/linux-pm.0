From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / runtime: Asynchronous "idle" in pm_runtime_allow()
Date: Thu, 30 Jun 2016 15:48:37 -0700
Message-ID: <m2poqyqomy.fsf@baylibre.com>
References: <2236951.5ps16Zk8OD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33102 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcF3Wsj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 18:48:39 -0400
Received: by mail-pf0-f172.google.com with SMTP id i123so33611964pfg.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 15:48:39 -0700 (PDT)
In-Reply-To: <2236951.5ps16Zk8OD@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Wed, 29 Jun 2016 02:53:48 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Arjan reports that it takes a relatively long time to enable runtime
> PM for multiple devices at system startup, because all writes to the
> "control" attribute in sysfs are handled synchronously and if the
> device is suspended as a result of the write, it will block until
> that operation is complete.
>
> That may be avoided by passing the RPM_ASYNC flag to rpm_idle()
> in pm_runtime_allow() which will make it execute the device's
> "idle" callback asynchronously, so writes to "control" changing
> it from "on" to "auto" will return without waiting.
>
> Reported-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
