Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DE4C25B06
	for <linux-pm@archiver.kernel.org>; Sun, 14 Aug 2022 09:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHNJue (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Aug 2022 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNJud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Aug 2022 05:50:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E1611454;
        Sun, 14 Aug 2022 02:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 794FBB8068C;
        Sun, 14 Aug 2022 09:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF495C433D6;
        Sun, 14 Aug 2022 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660470630;
        bh=YMeRpElZNN0nRJL41e5QZR3ONX4RAqEuGqTmM2z0zbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zjLoF89HCesvrKOZtY0em4B9+H9L9rwDc4dwStr8iHbzRI9/hJvKTQwtu6gpAzd8G
         72+SwBvEtfkyAgFL3zp5qFmtzH3hTEvjzVpP1QwTNMjAEU91VXU9+WDqyB2fhYBVoR
         8v/D4AD7qaiyv7NJHVL5jlXXCXYX3Ve+e/A/5Kvo=
Date:   Sun, 14 Aug 2022 11:50:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>, jbeulich@suse.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
Message-ID: <YvjFY1dn2Afg/mFj@kroah.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <4688ee9b-1b18-3204-cc93-c6ab2ce9222c@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4688ee9b-1b18-3204-cc93-c6ab2ce9222c@netscape.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 14, 2022 at 05:19:12AM -0400, Chuck Zmudzinski wrote:
> Well, that did not take long. Juergen responded with a message,
> which is encrypted and not delivered to my mailbox because I do not
> have the PGP keys, presumably to make it difficult for me to continue
> the discussion and defend myself after I was accused of violating
> the netiquette rules yesterday by Boris:

The message was signed, not encrypted.  Odd that your email client could
not read it, perhaps you need to use a different one?

thanks,

greg k-h
