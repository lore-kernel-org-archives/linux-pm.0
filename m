From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] PM / Runtime: Prevent re-resuming devices in pm_runtime_force_resume()
Date: Tue, 24 May 2016 08:30:04 +0200
Message-ID: <CAPDyKFoN82MGJ1PbSvkmgGazzS4Qyw=g-V9sBvqBj9C+ocjnwg@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-3-git-send-email-ulf.hansson@linaro.org>
	<m27fekmpi6.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35983 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbcEXGaG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 02:30:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id n129so111812288wmn.1
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 23:30:05 -0700 (PDT)
In-Reply-To: <m27fekmpi6.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 23 May 2016 at 23:30, Kevin Hilman <khilman@baylibre.com> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> If the device has already been resumed before pm_runtime_force_resume() is
>> invoked, prevent calling the ->runtime_resume() callback for the device,
>> as it's not the expected behaviour from the subsystem/driver.
>
> I'm not following how this description matches the code.
>
> Based on the code, it seems like it should say "If the device has not
> been runtime suspended, don't runtime resume it."   IOW, "device has
> already been resumed" is not what pm_runtime_status_suspended() is
> checking for.

Hmm, these helpers are executed during the system PM sequence to
re-use the ->runtime_suspend|resume() callbacks to suspend and resume
the device.
The message is the change log do become a bit confusing because of
that, what do you think about the below instead?

If the runtime PM status of the device isn't runtime suspended, prevent
pm_runtime_force_resume() to call the ->runtime_resume() callback for the
device, as it's not the expected behaviour from the subsystem/driver.

[...]

Kind regards
Uffe
