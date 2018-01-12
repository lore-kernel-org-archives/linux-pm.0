From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM / core: genpd fix and pm_runtime_force_suspend|resume() rework
Date: Fri, 12 Jan 2018 14:00:00 +0100
Message-ID: <4928977.5hd79RbQlp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:63086 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeALNNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 08:13:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

This comes from the recent discussion/testing effort that ensued after my
pm_runtime_force_suspend|resume() changes proposal:

https://marc.info/?t=151497772000004&r=1&w=2

Patch [1/2] basically is https://patchwork.kernel.org/patch/10152873/ rebased
on top of the current linux-next branch of the linux-pm.git tree (the relevant
part should be there in the linux-next tree proper ATM).  It applies on top
of https://patchwork.kernel.org/patch/10156077/ which should apply to the Linus'
tree cleanly.

Patch [2/2] is a resend of https://patchwork.kernel.org/patch/10142047/ with
a very minor changelog modification and the R-b tag from Ulf.

Geert, if possible, please test this on the Renesas systems that had the
problem with https://patchwork.kernel.org/patch/10142047/ previously and let
me know if you still see issues.

Thanks,
Rafael
