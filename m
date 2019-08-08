Return-Path: <SRS0=lDgx=WE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2CCC0650F
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C4D20679
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hJm1D+2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfHHT3c (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:29:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHT3c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 15:29:32 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A1561EC0B07;
        Thu,  8 Aug 2019 21:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565292570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NHq2olb47ydFVvwU3qTj/y4JnB68wpWYnGGPittTI0s=;
        b=hJm1D+2kn7vU05wJ2/eLubQxpXt2GGn3YfEBHGqk/LAb6+v2jCFQKpqdbxbLPcbau5sXkC
        fGkW/fwGo0cWyvZ3FYdaJ+v9jveBI0yUbUagWElMQnV5WtDAYQMcs/ggWqWfRPzwOm9yyh
        aFmH1SO+71/t4rHMrkysP3MPPBxqB9M=
Date:   Thu, 8 Aug 2019 21:30:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808193019.GP20745@zn.tnic>
References: <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
 <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
 <7ba45ead-186a-8802-2da6-6fa9fa00b36a@intel.com>
 <20190808163849.GL20745@zn.tnic>
 <91eefbe4-e32b-d762-be4d-672ff915db47@intel.com>
 <20190808172955.GM20745@zn.tnic>
 <19ef9df7-fc54-500a-c421-f7d8db013ab7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19ef9df7-fc54-500a-c421-f7d8db013ab7@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 12:24:52PM -0700, Dave Hansen wrote:
> On 8/8/19 10:30 AM, Borislav Petkov wrote:
> > 4. Add a short differentiator if necessary.  Add an _X to differentiate
> >    Server from Client.
> 
> We could also add:
> 
> "Try to be descriptive especially if the processor has a special role.
> Avoid using Intel codenames or codename acronyms, especially platform
> codenames and acronyms."
> 
> Here's a short decoder for some of the more common differentiators:
> 
> 	DESKTOP: Clients
> 	MOBILE : Clients
>   	X      : Servers, to differentiate names from Clients
> 	XEON_D : Microservers, branded as Xeon D
> 	ULT    : Special low-power client platforms
> 	MID    : Mobile Internet Device, >=phone, <=tablet
> 
> Rajneesh said he's patch'ify my email blabbering.

Sure but make that a separate patch from the ELH model adding.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
