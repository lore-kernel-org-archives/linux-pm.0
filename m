From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [v3 PATCH 1/3] powernv-cpufreq: Add helper to extract pstate from PMSR
Date: Sun, 17 Dec 2017 14:04:03 +1100
Message-ID: <CAKTCnzn9TskuPQavjkNZTjy+ff-BxSOsBkLvmb7+unH3O_3KKg@mail.gmail.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com> <1513148261-21097-2-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35499 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757022AbdLQDEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 22:04:04 -0500
In-Reply-To: <1513148261-21097-2-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> On POWERNV platform, the fields for pstates in the Power Management
> Status Register (PMSR) and the Power Management Control Register
> (PMCR) are 8-bits wide. On POWER8 the pstates are negatively numbered
> while on POWER9 they are positively numbered.
>
> The device-tree exports pstates as 32-bit entries. The device-tree
> implementation sign-extends the 8-bit pstate values to obtain the
> corresponding 32-bit entry.
>
> Eg: On POWER8, a pstate value 0x82 [-126] is represented in the
> device-tree as 0xfffffff82 while on POWER9, the same value 0x82 [130]
> is represented in the device-tree as 0x00000082.
>
> The powernv-cpufreq driver implementation represents pstates using the
> integer type. In multiple places in the driver, the code interprets
> the pstates extracted from the PMSR as a signed byte and assigns it to
> a integer variable to get the sign-extention.
>
> On POWER9 platforms which have greater than 128 pstates, this results
> in the driver performing incorrect sign-extention, and thereby
> treating a legitimate pstate (say 130) as an invalid pstates (since it
> is interpreted as -126).
>
> This patch fixes the issue by implementing a helper function to
> extract Pstates from PMSR register, and correctly sign-extend it to be
> consistent with the values provided by the device-tree.
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---

This looks better

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
