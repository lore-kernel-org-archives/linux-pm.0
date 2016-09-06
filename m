From: hl <hl@rock-chips.com>
Subject: Re: [PULL REQ] PM / Devfreq for Linux-pm (Fixes)
Date: Wed, 7 Sep 2016 00:44:03 +0800
Message-ID: <57CEF253.3030607@rock-chips.com>
References: <CGME20160906064335epcms1p75b85321b10ff6d8d045240a785375b23@epcms1p7>
 <1278751964.451375.1473145738891.JavaMail.weblogic@ep1ml102b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:43389 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965038AbcIFQoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2016 12:44:22 -0400
In-Reply-To: <1278751964.451375.1473145738891.JavaMail.weblogic@ep1ml102b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "jszhang@marvell.com" <jszhang@marvell.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, Chanwoo Choi <cw00.choi@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Myungloo Ham,

On 2016年09月06日 15:08, MyungJoo Ham wrote:
>> Dear Rafael,
>>
>>
>> Here goes pull request from PM / devfreq for linux-pm.
>>
>> (The first two patches are previously pull-requested, but not found in v4.8-rc5.
>> If you've already pulled them, you may skip the first two)
>>
>> If you'd like to pull fixes only (no driver add), please use "tags/pull_req_20160906_fixes" tag.
>>
> Sorry for confusion, but I've just updated tags/pull_req_20160906 and it is now
> same with tags/pull_req_20160906_fixes.
>
> The updated for-rc pull-request no more include the driver add because the new driver
> requires another patch to be merged, which is no more going to be merged for next RC, but 4.9.
>
>
> Here goes the updated pull request message (the target URL is the same as it was using the tag)
>
>
> @Lin Huang: your driver is going to be targetting 4.9, not 4.8, as
> part of the driver is being targetted at 4.9 now.
Got it, thanks.
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:
>
>    Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)
>
> are available in the git repository at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20160906
>
> for you to fetch changes up to c8a9a6daccad495c48d5435d3487956ce01bc6a1:
>
>    PM / devfreq: event: remove duplicate devfreq_event_get_drvdata() (2016-09-06 13:08:40 +0900)
>
> - ----------------------------------------------------------------
> Pull req for next-rc (Fixes)
>
> - ----------------------------------------------------------------
> Jisheng Zhang (1):
>        PM / devfreq: fix Kconfig indent style
>
> Krzysztof Kozlowski (1):
>        PM / devfreq: Add COMPILE_TEST for build coverage
>
> Lin Huang (1):
>        PM / devfreq: event: remove duplicate devfreq_event_get_drvdata()
>
> Wei Yongjun (1):
>        PM / devfreq: exynos-ppmu: remove unneeded of_node_put()
>
>   drivers/devfreq/Kconfig             | 18 +++++++++---------
>   drivers/devfreq/event/Kconfig       |  4 ++--
>   drivers/devfreq/event/exynos-ppmu.c |  2 --
>   include/linux/devfreq-event.h       |  5 -----
>   4 files changed, 11 insertions(+), 18 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQIcBAEBAgAGBQJXzmqtAAoJEBOhurvWBoCK31sP/226B5IGR84smyt5f01FqoBH
> IaDbF+4Wwf+WJEzmxHCq8MQJfQ7O5ib9m1x+w4ggEXVD3hjDwKb1CpnuKLupp6kS
> tIdDbEcS5++bgh+C2QyVD5aMQBq2JAWHN9QcQdzb6KeutNMX4ejPzK4aHy4uaaPE
> Wkvrk5I6/nj43p/uwQR1fIuZ3vLJm/KRKMQJGDQjW9ka3Ivv0SaEEwf7EtCtStqz
> TyhvlgXEnKfKOBwBnlHbHYPpRtmgKRwDhcHrZo6W+chLiHInrxQ3EzT+H16y8Z26
> pmnIaXM1KTFJKuVQ315XH/IGXzyFMeX66j/AlwoaHjOubtft1eqVTyyHPoiwR3CR
> PiyOPX8VpHMmCtrc0nFOWVwWfpPMlPfIurKuiqDG4gu7R1+adp1Jg7fKNWQa+ywB
> pf2tqjDX0voGX5g2DkAuV+0ejl3ZE5zp7RxIIUkHkA77rG12rqc37VjETUzBjUTW
> qA6iT02bs1bi+HcWskbw8yUOVNgiyIsqbw35Qt9rjByP2jw589TTuJUxmHe1Yic5
> Auo9+wV4D6yRWL/lf9u9dVZaHtScxVgk78Xbi36KYWo+UUuFv36j7UrQjbR/1+is
> pn+OfdhAwyuwBorCJnkySXuumwmHzJY3yw4nZeJYglFs2nTOtVaMkTc+ZNE9npNK
> 2Zrih8vAOEI6wm41jZT4
> =oBWJ
> -----END PGP SIGNATURE-----
>

-- 
Lin Huang


