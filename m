Return-Path: <SRS0=WV1n=6W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51AC38A2A
	for <linux-pm@archiver.kernel.org>; Fri,  8 May 2020 10:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A04B21473
	for <linux-pm@archiver.kernel.org>; Fri,  8 May 2020 10:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588934247;
	bh=nMwbkoXsurAgX5aweLzLKtjN+Fg0rJIaQRWh3uGI/70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RBJD2lTj/D21ecCB2i13wL+5pBMKDbFYynVhoDLZQilPSTTiuhZWjIKPQDjoIvb2T
	 1ul3ux5CVaiT6Pb24gQ9d93o9GplVGFFMJgSTVGtChvFtpMVEgLwaIQfd5t/AiP6yu
	 udYYOdThAJd78iV9RWrPW2hglbb8fEa55fgkgBWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgEHKh0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 May 2020 06:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgEHKh0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 06:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D90020708;
        Fri,  8 May 2020 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588934244;
        bh=nMwbkoXsurAgX5aweLzLKtjN+Fg0rJIaQRWh3uGI/70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9//zzjsKE4ajKoe4iXB7ZnDulXLTyAfrmmFkYLvhvSWi1ElShUtoq+2KWH+yKyn3
         303XnjY9Ryc4WBSgBWklZ1DGIyaPBYVXMgcm59qHW21QL6ZkKeac55LnVO23EDzZns
         1zqIgPuTHYIL4oia6XGhbFt1/wEeK0cy+3fwG/vQ=
Date:   Fri, 8 May 2020 12:37:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508103721.GA3860390@kroah.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508081128.GM5298@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 10:11:28AM +0200, Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 07:09:58PM +0100, Quentin Perret wrote:
> > One challenge to implement GKI is to avoid bloating the kernel by
> > compiling too many things in, especially given that different devices
> > need different things. As such, anything that can be turned into a
> > module helps GKI, by offering an alternative to having that component
> > built-in. This is true for pretty much anything that can be made
> > modular, including drivers as well as other kernel components, such as
> > CPUFreq governors.
> 
> The idea is to move to 1 governor, schedutil. Also, I abhor all the
> exports this thing does. Modules have no business touching most of that.
> 
> Look at every EXPORT you do and wonder ask yourself how you can abuse
> it. Modules are not a good thing, they're horrible pieces of crap.

Quentin, what is missing from schedutil that warrants the need for a
totally different governor?  Is there specific problems with the
existing ones or is this just an instance of "we wrote our own a long
time ago and never pushed it upstream" from various SoC companies?

thanks,

greg k-h
