Return-Path: <SRS0=1vxP=7N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A8C433DF
	for <linux-pm@archiver.kernel.org>; Sun, 31 May 2020 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD7C20674
	for <linux-pm@archiver.kernel.org>; Sun, 31 May 2020 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgEaWLa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 31 May 2020 18:11:30 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:57272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgEaWLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2020 18:11:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 90F1C1802926E;
        Sun, 31 May 2020 22:11:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chess64_5207aa126d78
X-Filterd-Recvd-Size: 1901
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 May 2020 22:11:28 +0000 (UTC)
Message-ID: <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sun, 31 May 2020 15:11:27 -0700
In-Reply-To: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

(adding Dan Carpenter)

On Sun, 2020-05-31 at 23:00 +0200, Christophe JAILLET wrote:
> 'swsusp_header_init()' is only called via 'core_initcall'.
> It can be marked as __init to save a few bytes of memory.

Hey Dan

smatch has a full function calling tree right?

Can smatch find unmarked functions called only by __init
functions so those unmarked functions can be appropriately
marked with __init like the below?

> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index ca0fcb5ced71..01e2858b5fe3 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1590,7 +1590,7 @@ int swsusp_unmark(void)
>  }
>  #endif
>  
> -static int swsusp_header_init(void)
> +static int __init swsusp_header_init(void)
>  {
>  	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
>  	if (!swsusp_header)

