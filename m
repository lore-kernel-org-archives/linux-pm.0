From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 05/20] PM / devfreq: Add new passive governor
Date: Tue, 12 Apr 2016 09:30:34 +0200
Message-ID: <570CA41A.5050500@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-6-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:51048 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbcDLILl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 04:11:41 -0400
In-reply-to: <1460347078-15175-6-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the new passive governor for DEVFREQ framework. The following
> governors are already present and used for DVFS (Dynamic Voltage and Frequency
> Scaling) drivers. The following governors are independently used for one device
> driver which don't give the influence to other device drviers and also don't
> receive the effect from other device drivers.
> - ondemand / performance / powersave / userspace
> 
> The passive governor depends on operation of parent driver with specific
> governos extremely and is not able to decide the new frequency by oneself.
> According to the decided new frequency of parent driver with governor,
> the passive governor uses it to decide the appropriate frequency for own
> device driver. The passive governor must need the following information
> from device tree:
> - the source clock and OPP tables
> - the instance of parent device
> 
> For exameple,
> there are one more devfreq device drivers which need to change their source
> clock according to their utilization on runtime. But, they share the same
> power line (e.g., regulator). So, specific device driver is operated as parent
> with ondemand governor and then the rest device driver with passive governor
> is influenced by parent device.
> 
> Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [tjakobi: Reported RCU locking issue and cw00.choi fix it]
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> [linux.amoon: Reported possible recursive locking and cw00.choi fix it]
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig            |   8 ++
>  drivers/devfreq/Makefile           |   1 +
>  drivers/devfreq/governor_passive.c | 207 +++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h            |  33 ++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 drivers/devfreq/governor_passive.c
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

