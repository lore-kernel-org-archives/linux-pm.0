From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: Re: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Mon, 22 Feb 2016 15:17:19 +0100
Message-ID: <CAAObsKCT+f70=bxxTOu2Vg7PLi0YaL+pkk4C41EUqtTS9e3NZA@mail.gmail.com>
References: <987619535.304031453954442569.JavaMail.weblogic@epmlwas09c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36015 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbcBVORj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 09:17:39 -0500
In-Reply-To: <987619535.304031453954442569.JavaMail.weblogic@epmlwas09c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Tyler Baker <tyler.baker@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 28 January 2016 at 05:14, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> Hi Thierry,
>>
>> On 21 January 2016 at 02:54, Thierry Reding <thierry.reding@gmail.com> wrote:
>> > On Thu, Jan 21, 2016 at 08:52:26AM +0100, Tomeu Vizoso wrote:
> []
>> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> >> Reported-by: Tyler Baker <tyler.baker@linaro.org>
> []
>> >>
>> >
>> > I had noticed it recently but hadn't got around to look into it, thanks
>> > for fixing it.
>> >
>> > Tested-by: Thierry Reding <treding@nvidia.com>
>> > Acked-by: Thierry Reding <treding@nvidia.com>
>>
>> I don't see this patch in -next yet, so I'm guess it hasn't been
>> applied. Any chance you could pick it up? This issue is now
>> manifesting in mainline, and causing ton of noise in the boot reports.
>>
>> Cheers,
>>
>> Tyler
>
>
> Hey, the patch appeared at the mailing list a week ago.
> Linux 4.5-rc1 appeared 3 days ago.
> The fastest possible for mainline inclusion is 4.5-rc2 or 3.
>
> You cannot simply expect the patch to be included in the maiinline that fast.

Hi MyungJoo Ham,

the problem is that linux-next has been showing that error in
multi_v7_defconfig builds since your changes got there. This is so
annoying that people have been putting their tegra124 boards offline
in their CI labs until this gets fixed in linux-next.

Regards,

Tomeu
