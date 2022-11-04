Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39607C433FE
	for <linux-pm@archiver.kernel.org>; Fri,  4 Nov 2022 05:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKDFCP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKDFBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 01:01:55 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68C2A24E
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 22:01:17 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 0B038C033F;
        Fri,  4 Nov 2022 04:51:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 4DDEB20027;
        Fri,  4 Nov 2022 04:50:53 +0000 (UTC)
Message-ID: <d5aad01b77072d065f47b89b1c0ff16edf906bc9.camel@perches.com>
Subject: Re: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 21:51:44 -0700
In-Reply-To: <20221103143654.85275-1-colin.i.king@gmail.com>
References: <20221103143654.85275-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4DDEB20027
X-Stat-Signature: uwnwjmkujh3r4d3igepfxgnq9pjwy8f7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187jzT9iI/uQ5LIT5aSXQWCd3SiSHIShjY=
X-HE-Tag: 1667537453-657377
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-11-03 at 14:36 +0000, Colin Ian King wrote:
> Don't populate the read-only array sys_clk_src on the stack but instead
> make it static and add in a missing const. Also makes the object code a
> little smaller.
[]
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
[]
> @@ -39,7 +39,7 @@ static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
>  	 * In SPEAr1340, cpu clk's parent sys clk can take input from
>  	 * following sources
>  	 */
> -	const char *sys_clk_src[] = {
> +	static const char * const sys_clk_src[] = {
>  		"sys_syn_clk",
>  		"pll1_clk",
>  		"pll2_clk",

sys_clk_src[2] isn't used and could be deleted with the
pclk indices changed.

Dunno what happened to the > 500000000 && != 600000000 range.
