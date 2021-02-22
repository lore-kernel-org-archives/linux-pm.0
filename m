Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C61BC4332D
	for <linux-pm@archiver.kernel.org>; Mon, 22 Feb 2021 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC64464EB4
	for <linux-pm@archiver.kernel.org>; Mon, 22 Feb 2021 07:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBVHqR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Feb 2021 02:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBVHqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 02:46:16 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4AC06178A;
        Sun, 21 Feb 2021 23:45:35 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 109D340A2E; Mon, 22 Feb 2021 07:36:27 +0000 (UTC)
Date:   Mon, 22 Feb 2021 07:36:27 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 3/9] security: keys: trusted: Parse out individual
 components of the key blob
Message-ID: <20210222073627.GB30403@codon.org.uk>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-4-matthewgarrett@google.com>
 <YDB8gM6Z9OOKujQu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDB8gM6Z9OOKujQu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 20, 2021 at 05:05:36AM +0200, Jarkko Sakkinen wrote:
> On Sat, Feb 20, 2021 at 01:32:49AM +0000, Matthew Garrett wrote:
> > Performing any sort of state validation of a sealed TPM blob requires
> > being able to access the individual members in the response. Parse the
> > blob sufficiently to be able to stash pointers to each member, along
> > with the length.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> 
> I'll just say LGTM for now. Did not see anything obviously wrong in
> the code change (and does make sense to nitpick minor things just
> yet).
> 
> Need to understand the whole use case just a little bit better.

I wrote this up with some more detail at 
https://mjg59.dreamwidth.org/55845.html - it seemed longer than
appropriate for a commit message, but if you'd like more detail
somewhere I can certainly add it.
