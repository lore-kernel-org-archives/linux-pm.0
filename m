Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01727C433DB
	for <linux-pm@archiver.kernel.org>; Mon, 22 Feb 2021 07:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BC364DDC
	for <linux-pm@archiver.kernel.org>; Mon, 22 Feb 2021 07:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBVHml (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Feb 2021 02:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhBVHmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 02:42:33 -0500
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Feb 2021 23:41:53 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34810C061574;
        Sun, 21 Feb 2021 23:41:53 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 1E37C40A30; Mon, 22 Feb 2021 07:41:52 +0000 (UTC)
Date:   Mon, 22 Feb 2021 07:41:52 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, jarkko@kernel.org,
        corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 7/9] pm: hibernate: Optionally use TPM-backed keys to
 protect image integrity
Message-ID: <20210222074152.GD30403@codon.org.uk>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-8-matthewgarrett@google.com>
 <4c265e1d-0a02-207a-cc10-9a49b4fc5169@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c265e1d-0a02-207a-cc10-9a49b4fc5169@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 19, 2021 at 06:20:13PM -0800, Randy Dunlap wrote:
>   For all of the Kconfig* configuration files throughout the source tree,
>   the indentation is somewhat different.  Lines under a ``config`` definition
>   are indented with one tab, while help text is indented an additional two
>   spaces.

Whoops, I've no idea how I screwed that up. I'll fix for V2, thanks!
 
> Also, one feature should not be responsible for enabling other "subsystems,"
> such as KEYS and CRYPTO. They should instead be listed as dependencies.

ACK.
