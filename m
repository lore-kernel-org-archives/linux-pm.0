From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add support frequency support
Date: Wed, 28 Dec 2016 21:09:57 +0900
Message-ID: <5863AB95.5010205@samsung.com>
References: <CGME20161228120710epcas5p2e373f06f70639bd005eba80fa36a59ce@epcas5p2.samsung.com>
 <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: hl@rock-chips.com, tjakobi@math.uni-bielefeld.de, chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear all,

I'm sorry for the version of these patches.
These patches is v1 instead of v2. It is my mistake.

But, if I should send next version, I'll use 'v3' to reduce
the confusion for the duplicate version.

Best Regards,
Chanwoo Choi

On 2016년 12월 28일 21:07, Chanwoo Choi wrote:
> The devfreq has two case to enter the suspend mode for devfreq dev as following:
> case 1: Some devfreq device call the 'devfreq_suspend/resume_device()'
>         directly on the fly regardless of 'echo mem > /sys/power/state'.
> case 2: The system enter the suspend mode by using 'echo mem > sys/power/state'.
> 
> These patches support the suspend frequency on devfreq subsystem for case 1.
> Lin Huang posted the patch[1] to support the case1. So, I rework Lin Huang's
> patch[1] to consider the passive devfreq device using passive governor.
> 
> And Tobias would support the following two features on third patches.
> He already posted the patches[2] to support the case 2.
> - Add new devfreq_{suspend|resume} function for all registered devfreq devices
> - Support the reference count to prevent the duplicate call of
>   devfreq_{suspend|resume}_device. Tobias and me already discussed it on
>   patch[3].
> 
> [1] https://patchwork.kernel.org/patch/9445007/
> - "[v7] PM/devfreq: add suspend frequency support"
> [2] https://www.spinics.net/lists/linux-samsung-soc/msg56602.html
> - [RFC v2 0/7] PM / devfreq: draft for OPP suspend impl (even draftier)
> [3] https://www.spinics.net/lists/linux-samsung-soc/msg56632.html
> 
> Also, I tested these patches on Exynos3250-Rinato board and made the
> patch[4][5]. But, the patches[4][5] would be posted after posting the third
> patches by Tobias Jakobi.
> [4] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-test&id=cf2893454b126380e5513261ec8e3aa94d898e51
> [5] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-test&id=fb75ab14e7fbd5b72784dea2c45f7cb171490b6e
> 
> 
> Depends on:
> - These patches depend on v4.1-rc1 and patches[6][7]
> 
> [6] https://lkml.org/lkml/2016/12/28/91
> - [PATCH v2 0/3] PM / devfreq: Fix the bug and add reviewer for devfreq support
> [7] https://lkml.org/lkml/2016/12/28/102
> - [PATCH v2 0/8] PM / devfreq: Update the devfreq and devfreq-event device
> 
> Chanwoo Choi (1):
>   PM / devfreq: Add separate target function
> 
> Lin Huang (1):
>   PM / devfreq: Add suspend frequency support
> 
>  drivers/devfreq/devfreq.c | 96 +++++++++++++++++++++++++++++++++++------------
>  include/linux/devfreq.h   |  2 +
>  2 files changed, 73 insertions(+), 25 deletions(-)
> 
