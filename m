Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3BC77B7C
	for <linux-pm@archiver.kernel.org>; Thu, 20 Apr 2023 17:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjDTRIi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDTRIh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 13:08:37 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99210F;
        Thu, 20 Apr 2023 10:08:34 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso29311866b.1;
        Thu, 20 Apr 2023 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010513; x=1684602513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuRONv8seiZYRHKVDXe/quu6lUAwCL/qK3jfgqGF4GY=;
        b=WcuplgFsu5AGUrCigusfsZULy4wg63JOMGDQHQHKBeFpqd1Vrxen6jWcrQCmWQKm6U
         TLjLcOOxrjMsvzU5rIAvp+YOBxfC8+Oq2EU6W544IJLDAuNB2iKGTCBiuiXB/zLybNDN
         FOhrdCxTEWHsTiprONvbU/66NuFMxDprUIwIRd2cVjrpeWzEAcrP0xvYNd2GKJhpT167
         nKgZxpwpMJJwtJewkn7zMx94xE3b9UEK1PThnirqsB7sJahaXzzoQfkq4M30rkvv/XU9
         tOi934fqMzGllqjf+nIRIFBMRdw7bTg5/We5giUZXeFa4dXGqkLe+L0W6dx+BUdLW0EP
         CXmg==
X-Gm-Message-State: AAQBX9cLIYHiope2dbqn63LrFdN3vkSzfIzjJAWO35DBT2JtT/EGuGrb
        0fxGgSi4B90zsjz4MLnu8RZh+LCXzGPv/XlG/Ew=
X-Google-Smtp-Source: AKy350a3R0mZC2e6WMfLZ1aKIbwnAdPJZzuO1Lv9M3Qn3e5ge3cus6J/R8KP0F4hPmE01C8rkUeIHCSEvpzQMW99mfo=
X-Received: by 2002:a17:907:37c:b0:94e:8b6c:462c with SMTP id
 rs28-20020a170907037c00b0094e8b6c462cmr2155391ejb.2.1682010513297; Thu, 20
 Apr 2023 10:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230417152708.3599-1-mario.limonciello@amd.com>
In-Reply-To: <20230417152708.3599-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Apr 2023 19:08:22 +0200
Message-ID: <CAJZ5v0hBVosNmxN-KFZ0N=syNWNsQKtPOxYbNFy1bjRO2tP05Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Add vendor agnostic mechanism to report hardware sleep
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, Jain Rajat <rajatja@google.com>,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 17, 2023 at 5:27 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> An important part of validating that s0ix worked properly is to check how
> much of a cycle was spent in a hardware sleep state.
>
> The reporting of hardware sleep is a mix of kernel messages and sysfs
> files that vary from vendor to vendor. Collecting this information
> requires extra information on the kernel command line or fetching from
> debugfs.
>
> To make this information more readily accessible introduce a new file in
> suspend_stats that drivers can report into during their resume routine.
>
> Userspace can fetch this information and compare it against the duration
> of the cycle to allow determining residency percentages and flagging
> problems.
>
> v9->v10:
>  * Add tags
>  * Rebase on linux-pm/bleeding-edge as it will apply through this tree
>
> Mario Limonciello (4):
>   PM: Add sysfs files to represent time spent in hardware sleep state
>   platform/x86/amd: pmc: Report duration of time in hw sleep state
>   platform/x86/intel/pmc: core: Always capture counters on suspend
>   platform/x86/intel/pmc: core: Report duration of time in HW sleep
>     state
>
>  Documentation/ABI/testing/sysfs-power | 29 +++++++++++++
>  drivers/platform/x86/amd/pmc.c        |  6 +--
>  drivers/platform/x86/intel/pmc/core.c | 17 ++++----
>  drivers/platform/x86/intel/pmc/core.h |  4 +-
>  include/linux/suspend.h               |  8 ++++
>  kernel/power/main.c                   | 59 +++++++++++++++++++++------
>  6 files changed, 98 insertions(+), 25 deletions(-)
>

Whole series applied as 6.4-rc1 material, thanks!
