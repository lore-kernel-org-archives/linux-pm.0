From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Allow genpd to power on during the system PM phase
Date: Fri, 13 May 2016 11:54:49 +0200
Message-ID: <m21t56705y.fsf@baylibre.com>
References: <1462953610-20824-1-git-send-email-ulf.hansson@linaro.org>
	<1462953610-20824-2-git-send-email-ulf.hansson@linaro.org>
	<CAJZ5v0hsC9f7JFbs+A8GGWxc7jUJig+PvA4XLtE6VU2kiUbxYQ@mail.gmail.com>
	<CAPDyKFpUoKLVdCuF+heNeqHB0sQmnLUuBY1fmk2hHwt7FsbvkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36795 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcEMJyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 05:54:52 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so15678027wmn.1
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2016 02:54:52 -0700 (PDT)
In-Reply-To: <CAPDyKFpUoKLVdCuF+heNeqHB0sQmnLUuBY1fmk2hHwt7FsbvkA@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 12 May 2016 15:13:07 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 11 May 2016 at 23:25, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, May 11, 2016 at 10:00 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> If the PM domain is powered off when the first device in the domain starts
>>> its system PM prepare phase, genpd prevents any further attempts to power
>>> on the PM domain during the system PM phase. This constraint affects not
>>> only the current device which is being prepared, but all devices within
>>> the same PM domain.
>>
>> What exactly do you mean by "the system PM phase"?
>
> In between system PM device prepare and system PM device complete.
>
> Do you want me to clarify this in a better way in the change log?

It might be more clear if you something like "during system suspend/resume"

Kevin
