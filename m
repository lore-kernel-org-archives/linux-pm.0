From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Subject: pm_runtime_get_sync() vs pm_runtime_put_noidle()
Date: Tue, 13 Feb 2018 11:18:48 +0100
Message-ID: <20180213101848.iagpzschadqyq2vc@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from agrajag.zerfleddert.de ([88.198.237.222]:34746 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeBMKYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Feb 2018 05:24:24 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: sil2linuxmp@lists.osadl.org

Hi linux-pm,

for the OSADL SIL2LinuxMP project I'm looking at some static code
analysis for the kernel using coccinelle. I think I've found some common
error case that I'd ask you to confirm.

The good case looks like this:

	err = pm_runtime_get_sync(device);
	if (err) {
		pm_runtime_put_noidle(device);

pm_runtime_get_sync() increments the usage count even when returning an
error, so you have to call pm_runtime_put_noidle() in error handling.

Looking at the drivers in linux-next, there's a lot of them that

1) completely ignore the return value of pm_runtime_get_sync()

2) do handle the return value, but don't do pm_runtime_put_noidle().

For static analysis, I assume that scenario (1) might be correct (ie.
these drivers somehow know that the get can't fail).

For scenario (2), my first coccinelle script finds more than 100 cases.
Before submitting patches to these, I wanted to ask:

Is there a scenario where not doing a ...put_noidle() after
...get_sync() returned an error is the correct way to go?

Why isn't ...get_sync() directly calling ...put_noidle() but relies on
the driver implementation to do it? It seems unintuitive for a _get_
function to increase the usage count although returning an error.

I'd be glad if you could give me some pointers here,

Tobias

P.S.: googling finds several commits that add the ...put_noidle(), so
it seems to be a common case of bugs, e.g.
Feb 2013:
http://linux-kernel.2935.n7.nabble.com/PATCH-1-5-regmap-irq-call-pm-runtime-put-in-pm-runtime-get-sync-failed-case-td607900.html
Mar 2015:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331190.html
The patch that started this investigation was
https://lkml.org/lkml/2018/1/3/354
