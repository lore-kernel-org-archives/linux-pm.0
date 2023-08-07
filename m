Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A0FEB64DD
	for <linux-pm@archiver.kernel.org>; Mon,  7 Aug 2023 06:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHGGj7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGGj6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 02:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B374BA;
        Sun,  6 Aug 2023 23:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2730161554;
        Mon,  7 Aug 2023 06:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C00C433C7;
        Mon,  7 Aug 2023 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691390396;
        bh=cLRE+sII7UxJ95Wse28eozoKbP82elCRGURB4T28oU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xv3pC6z4NdGXo6fFO2mAE0b7pnfTYgjb109MExyrfTcLvK1Nb0Ld75UnbO+0aByN3
         /yyKCBy5B+XW5LNWCm1k1MgrJirKlbInMghvuZJw7m1cAPmaBiRJYIxrFUra4Jsubx
         KIqy2yPpqlk6KnycbxENlR3VzDHUoGHteVhNLduE=
Date:   Mon, 7 Aug 2023 08:39:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Huang Rui <ray.huang@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
Message-ID: <2023080747-outsider-despite-acd2@gregkh>
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh>
 <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 07, 2023 at 08:21:37AM +0200, Jannik Glückert wrote:
> Hi Greg,
> 
> our kernel uses the Fedora config and has a homeopathic patchset on
> top of upstream - see
> https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=6.4 except
> the 50** patches.
> Namely we don't touch cpufreq or pm.
> 
> > Comm: cat Tainted: P
> 
> I am not using any out of tree modules, the kernel switches to
> Tainted: P on the first CFI violation.

Ah, ok.  Then work with the amd_pstate driver authors on this, odds are
one of the sysfs callbacks is incorrectly created which is quite easy to
do for stuff like this.  CFI also gets confused at times when dealing
with sysfs attributes due to them being cast in all sorts of crazy ways.

good luck!

greg k-h
