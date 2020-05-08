Return-Path: <SRS0=WV1n=6W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0152AC38A2A
	for <linux-pm@archiver.kernel.org>; Fri,  8 May 2020 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF60F208CA
	for <linux-pm@archiver.kernel.org>; Fri,  8 May 2020 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLlSvJ6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEHL0a (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 May 2020 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgEHL0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 07:26:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97AC05BD43;
        Fri,  8 May 2020 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i605eDMDNY8KyszY5v6QIxThK3xpDXQtG6gdo/y+ktg=; b=KLlSvJ6JY5ihQrVCCnT+wbVZgJ
        z3wpGMlGDZpsLvpDv7HIafxPs1yngTfy6fULgy9QRhhHGASaQ06FQm2v8cmhOBEmkoK4/J7vVN8tp
        aTZxlpudeb6U0tOfvdFCMTTE9KlxrTCbSnzfra1Mw059R2wKbxchrqwJkdQ7mtOG2M8prxNOqV8uJ
        nM2eLo5j/vASGAmjQtDWqNyWzZvhepI6Htw9ExmaxYnAl8wIeAen3lA4X9GR1/W+OiWUkYHjkO2PN
        Tp1j5aA81izfL94vE1bB4a6BMP6saHjBzm3isSsjsgyM/7dkfOKCas9GvS+LcA3VuauD1cpRS2xiB
        SJaonrUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX18t-0000MQ-Ly; Fri, 08 May 2020 11:26:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D6B8301EFB;
        Fri,  8 May 2020 13:26:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1877B203ECDC2; Fri,  8 May 2020 13:26:09 +0200 (CEST)
Date:   Fri, 8 May 2020 13:26:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508112609.GA5298@hirez.programming.kicks-ass.net>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508103721.GA3860390@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 12:37:21PM +0200, Greg KH wrote:
> On Fri, May 08, 2020 at 10:11:28AM +0200, Peter Zijlstra wrote:
> > On Thu, May 07, 2020 at 07:09:58PM +0100, Quentin Perret wrote:
> > > One challenge to implement GKI is to avoid bloating the kernel by
> > > compiling too many things in, especially given that different devices
> > > need different things. As such, anything that can be turned into a
> > > module helps GKI, by offering an alternative to having that component
> > > built-in. This is true for pretty much anything that can be made
> > > modular, including drivers as well as other kernel components, such as
> > > CPUFreq governors.
> > 
> > The idea is to move to 1 governor, schedutil. Also, I abhor all the
> > exports this thing does. Modules have no business touching most of that.
> > 
> > Look at every EXPORT you do and wonder ask yourself how you can abuse
> > it. Modules are not a good thing, they're horrible pieces of crap.
> 
> Quentin, what is missing from schedutil that warrants the need for a
> totally different governor?  Is there specific problems with the
> existing ones or is this just an instance of "we wrote our own a long
> time ago and never pushed it upstream" from various SoC companies?

At the very least there's that interactive governor that's really
popular with Android. But IIRC there's a whole scala of home-brew
governors and tweaks out there.

And instead of enabling that crap, we should be discouraging it.
Consolidate and kill the governor interface.
