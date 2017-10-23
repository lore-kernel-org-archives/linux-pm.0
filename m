From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v5 3/7] PM / devfreq: Use the available min/max
 frequency
Date: Mon, 23 Oct 2017 05:10:52 +0000
Message-ID: <20171023051052epcms1p6ab11328679c36c925f510a87f84590aa@epcms1p6>
References: <1508722332-10628-4-git-send-email-cw00.choi@samsung.com>
        <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171023013214epcas1p353a430282734319c904ea2edaa737dce@epcms1p6>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34972 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdJWFKz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2017 01:10:55 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171023051053epoutp047a56004668b7d20f4b352cf3009be6d5~wGubEA4ih2727427274epoutp04I
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2017 05:10:53 +0000 (GMT)
In-Reply-To: <1508722332-10628-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> The commit a76caf55e5b35 ("thermal: Add devfreq cooling") is able
> to disable OPP as a cooling device. In result, both update_devfreq()
> and {min|max}_freq_show() have to consider the 'opp->available'
> status of each OPP.
> 
> So, this patch adds the 'scaling_{min|max}_freq' to struct devfreq
> in order to indicate the available mininum and maximum frequency
> by adjusting OPP interface such as dev_pm_opp_{disable|enable}().
> The 'scaling_{min|max}_freq' are used for on both update_devfreq()
> and {min|max}_freq_show().
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
(along with the 2/7, revert commit)

> ---
>  drivers/devfreq/devfreq.c | 40 ++++++++++++++++++++++++++++++++--------
>  include/linux/devfreq.h   |  4 ++++
>  2 files changed, 36 insertions(+), 8 deletions(-)
