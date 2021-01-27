Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B87C433E9
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1447060C40
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhA0TA4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Jan 2021 14:00:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhA0TAs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 14:00:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31F99AD2B;
        Wed, 27 Jan 2021 19:00:07 +0000 (UTC)
Date:   Wed, 27 Jan 2021 19:59:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] tools/power/turbostat: fix compatibility with older
 kernels
Message-ID: <20210127185957.GD8115@zn.tnic>
References: <20210127132444.981120-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127132444.981120-1-dedekind1@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 03:24:44PM +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Commit
> 
> 6d6501d912a9 tools/power/turbostat: Read energy_perf_bias from sysfs
> 
> added a useful EPB print by reading EPB from sysfs's 'energy_perf_bias' file.
> However, older kernels, which do not necessarily have that sysfs file (e.g.,
> Centos 7's stock kernel does not have it). As a result, turbostat fails with
> older kernels.
> 
> This patch fixes the problem by ignoring the sysfs file read errors.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 389ea5209a83..12e014f2c24b 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1839,7 +1839,9 @@ int get_epb(int cpu)
>  
>  	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
>  
> -	fp = fopen_or_die(path, "r");
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		return -1;
>  
>  	ret = fscanf(fp, "%d", &epb);
>  	if (ret != 1)

So I was under the impression that things in tools/ are tied to the
kernel version they're shipped with. Which means, you should probably
get the one from the centos kernel.

However, if this is supposed to work on older kernels too, then

  6d6501d912a9 ("tools/power/turbostat: Read energy_perf_bias from sysfs")

would need to be extended to first test the sysfs file's existence and
if not there, fall back to the MSR reading...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
