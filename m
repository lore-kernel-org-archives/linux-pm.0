Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D1CC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC99D2076C
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgHKSTs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:19:48 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:38036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgHKSTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 14:19:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id F096A100E7B73;
        Tue, 11 Aug 2020 18:19:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: line52_260c3ae26fe4
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 18:19:44 +0000 (UTC)
Message-ID: <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
Subject: Re: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
From:   Joe Perches <joe@perches.com>
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Date:   Tue, 11 Aug 2020 11:19:42 -0700
In-Reply-To: <20200811153149.12242-3-rui.zhang@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
         <20200811153149.12242-3-rui.zhang@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-08-11 at 23:31 +0800, Zhang Rui wrote:
> There will be more platforms with different fixed energy units.
> Enhance the code to support different rapl unit quirks for different
> platforms.

This seems like one quirk per platform.

Should multiple quirks on individual platforms be supported?

> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
[]
> @@ -130,11 +130,16 @@ struct rapl_pmus {
>  	struct rapl_pmu		*pmus[];
>  };
>  
> +enum rapl_unit_quirk {
> +	RAPL_UNIT_QUIRK_NONE,
> +	RAPL_UNIT_QUIRK_INTEL_HSW,
> +};
> +
>  struct rapl_model {
>  	struct perf_msr *rapl_msrs;
>  	unsigned long	events;
>  	unsigned int	msr_power_unit;
> -	bool		apply_quirk;
> +	enum rapl_unit_quirk	unit_quirk;
>  };


