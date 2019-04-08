Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003FC282CE
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FA920880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDHIvy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:51:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfDHIvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 04:51:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 653BAB039;
        Mon,  8 Apr 2019 08:51:53 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] x86: Do not override performance EPB MSR value on servers
Date:   Mon, 08 Apr 2019 10:51:53 +0200
Message-ID: <3028388.0SNZMY0NmP@house>
In-Reply-To: <36183132.7cOCK0nhyl@house>
References: <36183132.7cOCK0nhyl@house>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 8, 2019 10:46:46 AM CEST Thomas Renninger wrote:
> It is about this kernel message showing up on quite a lot servers:
> [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.076003] ENERGY_PERF_BIAS: View and update with
> x86_energy_perf_policy(8)
> 
> With this patch the EPB value is not overridden anymore on systems
> which expose themselves as appliance or enterprise server via ACPI
> perferred profile variable.
> 
> Signed-off-by: trenn@suse.de

The patch has successfully been tested on top of Rafeals latest EPB
fixes:
[PATCH 0/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS handling fixes and sysfs 
i/f

EPB value is now successfully and correctly restored after CPU off-/onlining
It can be set back to performance value if kernel set it to normal and this
value also survives CPU off-/onlining.

Still the kernel should not override the performance value on servers, so
it would be nice to see the patch applied.
Once applied, I may send a patch based on code before EPB changes similar to 
this for stable kernels. There it is even more urgent, due to the wrong
unconditional setting to "normal" value after CPU off-/onlining.

I tested the patch to make sure the preferred value is considered and it
works.

        Thomas
