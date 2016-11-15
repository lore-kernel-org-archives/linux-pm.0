From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH v2] thermal: intel_pch_thermal: Support skylake PCH 100 series thermal
Date: Tue, 15 Nov 2016 23:13:01 +0900
Message-ID: <877f8496he.fsf@mail.parknet.co.jp>
References: <87pomyd515.fsf@mail.parknet.co.jp>
        <1476813814.132953.50.camel@intel.com>
        <87eg3dctaj.fsf@mail.parknet.co.jp>
        <1476821756.132953.56.camel@intel.com>
        <8760opcr4y.fsf@mail.parknet.co.jp>
        <871szdcr0u.fsf_-_@mail.parknet.co.jp>
        <1476824673.132953.57.camel@intel.com>
        <1479212410.2224.11.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.parknet.co.jp ([210.171.160.6]:46243 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbcKOONH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 09:13:07 -0500
In-Reply-To: <1479212410.2224.11.camel@intel.com> (Zhang Rui's message of
        "Tue, 15 Nov 2016 20:20:10 +0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Zhang Rui <rui.zhang@intel.com> writes:

> hmmm, this patch is queued in my tree for some time.
> However, it conflicts with
> commit 33086a9a3071812a829d4b63bed826736a5d8b17
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:   Mon Oct 3 12:36:02 2016 -0700
>
>     thermal: intel_pch_thermal: Enable Haswell PCH
>     
>     Added missing support for Haswell PCH thermal sensor.
> which has been shipped in v4.9-rc3.
>
> Rebased patch sent, please double check.

"[PATCH v3] thermal: intel_pch_thermal: ..." looks good to me.

[I was thinking I checked latest kernel though, it looks like I was
missing something.]

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
