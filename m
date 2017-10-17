From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 5/8] PM / devfreq: Show the all available frequencies
Date: Tue, 17 Oct 2017 23:50:57 +0900
Message-ID: <CAJ0PZbQGp6YwoceAXfwW82kdQy7bpF9cMzUa7vJsyC65pXTtLw@mail.gmail.com>
References: <CGME20171013074834epcas2p2474f31a6521ae57d94618d4c79cff7b9@epcas2p2.samsung.com>
 <1507880904-31956-1-git-send-email-cw00.choi@samsung.com> <1507880904-31956-6-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54158 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933855AbdJQOvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 10:51:14 -0400
In-Reply-To: <1507880904-31956-6-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> The commit a76caf55e5b35 ("thermal: Add devfreq cooling") allows
> the devfreq device to use the cooling device. When the cooling down
> are required, the devfreq_cooling.c disables the OPP entry with
> the dev_pm_opp_disable(). In result, 'available_frequencies'[1]
> sysfs node never came to show the all available frequencies.
> [1] /sys/class/devfreq/.../available_frequencies
>
> So, this patch uses the 'freq_table' in the 'struct devfreq_dev_profile'
> in order to show the all available frequencies.
> - If 'freq_table' is NULL, devfreq core initializes them by using OPP values.
> - If 'freq_table' is initialized, devfreq core just uses the 'freq_table'.
>
> And this patch adds some comment about the sort way of 'freq_table'.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


> ---
>  drivers/devfreq/devfreq.c | 16 +++++-----------
>  include/linux/devfreq.h   |  5 +++--
>  2 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 909cedef7caa..534ead60d1cc 100644
[]
