Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F62C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEC220674
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJRN4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:13:56 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:60414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgGJRN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 13:13:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 25435182CED2A;
        Fri, 10 Jul 2020 17:13:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shade61_3512d3f26ed0
X-Filterd-Recvd-Size: 1831
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jul 2020 17:13:52 +0000 (UTC)
Message-ID: <db753175946cf53e77999d1fbb3cf949f777ef61.camel@perches.com>
Subject: Re: [PATCH v2] genpd: Fix up terminology with parent/child
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jul 2020 10:13:51 -0700
In-Reply-To: <202007081629.0840B4CB78@keescook>
References: <202007081629.0840B4CB78@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-07-08 at 16:32 -0700, Kees Cook wrote:
> The genpd infrastructure uses the terms master/slave, but such uses have
> no external exposures (not even in Documentation/driver-api/pm/*) and are
> not mandated by nor associated with any external specifications. Change
> the language used through-out to parent/child.

Thanks.

Perhaps change a couple more references:

$ grep -i -P '(?:master|slave)' drivers/cpuidle/cpuidle-psci-domain.c
	/* Link genpd masters/subdomains to model the CPU topology. */
$ grep -i -P '(?:master|slave)' drivers/opp/core.c
	 * genpd and its master have one to one mapping of performance states


