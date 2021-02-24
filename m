Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782DC433DB
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F9A64F0E
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhBXRXt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233502AbhBXRXp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Feb 2021 12:23:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D5364F0B;
        Wed, 24 Feb 2021 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614187383;
        bh=yM3gTzozh38TOrtlF44CT4e+9SY2u5O47HHG/3thchw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Urv0L9Z777BEgwBfiogkGzqzX3a7DuHcP3qVAsEU6budUH/VtqxbjAnsmmHMgGEJW
         0RnpvncW8Qho1IV/MSilN3cbzqMNLz0p/RJE/knhNU6391jKGwCteRKXLILUedKBuQ
         OqS4KeWimf6HHtSZqJ9STMGZ1pAxKkrc9iDNsTJgvLCLAW5poQ/ITvtmgx5Hdg9r7Y
         21IPplVsfsX2H+ZFzndouaFFoqUALhPSizyjnU5ka05HRm3MZRwvFJtA1OxH36KFxX
         zqFBIXrH6yQwCNBQ+IWaL66ZoMN8NsBsejtG/EOwcTmxfF3WPDwElJnp4+iQMYDd0s
         ROM6J8aZtXxiA==
Date:   Wed, 24 Feb 2021 19:22:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 3/9] security: keys: trusted: Parse out individual
 components of the key blob
Message-ID: <YDaLZW+27o6Cgutk@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-4-matthewgarrett@google.com>
 <YDB8gM6Z9OOKujQu@kernel.org>
 <20210222073627.GB30403@codon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222073627.GB30403@codon.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 07:36:27AM +0000, Matthew Garrett wrote:
> On Sat, Feb 20, 2021 at 05:05:36AM +0200, Jarkko Sakkinen wrote:
> > On Sat, Feb 20, 2021 at 01:32:49AM +0000, Matthew Garrett wrote:
> > > Performing any sort of state validation of a sealed TPM blob requires
> > > being able to access the individual members in the response. Parse the
> > > blob sufficiently to be able to stash pointers to each member, along
> > > with the length.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > 
> > I'll just say LGTM for now. Did not see anything obviously wrong in
> > the code change (and does make sense to nitpick minor things just
> > yet).
> > 
> > Need to understand the whole use case just a little bit better.
> 
> I wrote this up with some more detail at 
> https://mjg59.dreamwidth.org/55845.html - it seemed longer than
> appropriate for a commit message, but if you'd like more detail
> somewhere I can certainly add it.

Thanks (bookmarked). I'll read it before reviewing +1 version.

Requiring a config flag is something that slows down adoption in the
stock kernels.

Since we are talking about hibernate the decision whether to have this
feature set, does not have to be something that needs to be changed
dynamically to a running system.

So: maybe the best compromise would be to have it kernel command line
option? That way it's easier feature to adapt (e.g. with GRUB
configuration) and to enable in the kernel.

/Jarkko
