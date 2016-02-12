From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v1 4/6] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Fri, 12 Feb 2016 12:07:08 +0100
Message-ID: <CAAObsKBsYGo+si9Mmt111isnZ1V+Ao7j=dSjGpNfxUL4r5fgcA@mail.gmail.com>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1454679181-8949-5-git-send-email-tomeu.vizoso@collabora.com> <20160210164944.GN3782@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33079 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcBLLH2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 06:07:28 -0500
In-Reply-To: <20160210164944.GN3782@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Olof Johansson <olof@lixom.net>

On 10 February 2016 at 17:49, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 05 Feb 2016, Tomeu Vizoso wrote:
>
>> From: Sameer Nanda <snanda@chromium.org>
>>
>> This driver exposes the charger functionality in the PD EC to userspace.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: Sameer Nanda <snanda@chromium.org>
>> Cc: Benson Leung <bleung@chromium.org>
>> Cc: Shawn Nematbakhsh <shawnn@chromium.org>
>> ---
>>
>>  drivers/platform/chrome/cros_ec_proto.c |  37 ++
>>  drivers/power/Kconfig                   |  10 +
>>  drivers/power/Makefile                  |   1 +
>>  drivers/power/cros_usbpd-charger.c      | 907 ++++++++++++++++++++++++++++++++
>>  include/linux/mfd/cros_ec.h             |  28 +
>>  include/linux/mfd/cros_ec_commands.h    | 324 +++++++++++-
>>  6 files changed, 1302 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/power/cros_usbpd-charger.c
>
> A 1300 line patch crossing 3 subsystems is not the way you should be
> submitting code.  Please split these up into separate commits.  The
> only time you should squash all this functionality into a single patch
> is to mitigate otherwise unavoidable build issues.  I do not believe
> that's the case here.

Agreed, sorry about that.

Thanks,

Tomeu
