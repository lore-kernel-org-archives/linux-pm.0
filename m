From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] PM / Domains: Remove redundant call to
 pm_request_idle() in genpd
Date: Tue, 24 May 2016 08:19:01 +0200
Message-ID: <CAPDyKFoUOi_m1HfapDqOva8ekG=sh+euH6+fZagbhBqzymAr_A@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-2-git-send-email-ulf.hansson@linaro.org>
	<m2h9domppk.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38520 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcEXGTD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 02:19:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id n129so10008523wmn.1
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 23:19:01 -0700 (PDT)
In-Reply-To: <m2h9domppk.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 23 May 2016 at 23:25, Kevin Hilman <khilman@baylibre.com> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> The PM core increases the runtime PM usage count at the system PM prepare
>> phase. Later when the system has resumed and the ->complete() callback has
>> been invoked, it drops the usage count. In this way, it intentionally
>> prevents runtime PM suspend for the device throughout this period.
>>
>> For this reason, let's remove the call to pm_request_idle() from within
>> genpd's ->complete() calllback as it's redundant.
>
> It's not obvious from this description why the pm_request_idle() is
> redundant based just on usage count.
>
> IIUC, I think what you mean is that it's redundant because
> device_complete() does a pm_runtime_put(), which, in addition to
> decrementing the usage count, will do the equivalent of
> pm_request_idle()?

That's correct, allow me to re-spin and clarify the change log.

Kind regards
Uffe
