From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 04/12] PM / devfreq: Add dependency on PM_OPP
Date: Mon, 28 Aug 2017 01:23:39 +0000
Message-ID: <20170828012339epcms1p8352efc5c55225f5a2d21acc004fec824@epcms1p8>
References: <1503538979-22693-5-git-send-email-cw00.choi@samsung.com>
        <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p2d2b85a7c324b101e7e4e8551873ca3ab@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29222 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdH1BXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2017 21:23:41 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20170828012340epoutp0212b57179061c9c23086eb6b29840232f~e3gCprlHj1392713927epoutp02D
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2017 01:23:40 +0000 (GMT)
In-Reply-To: <1503538979-22693-5-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> The devfreq ues the OPP library to handle the voltage and frequency
> for the device basically. This patch adds the dependency on CONFIG_PM_OPP
> in order to prevent either the build break or the unknow behavior.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
