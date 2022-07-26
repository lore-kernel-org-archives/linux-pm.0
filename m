Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAE2C433EF
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jul 2022 13:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiGZNIm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiGZNIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 09:08:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D80242315A;
        Tue, 26 Jul 2022 06:08:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F89D1FB;
        Tue, 26 Jul 2022 06:08:41 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7513F70D;
        Tue, 26 Jul 2022 06:08:39 -0700 (PDT)
Date:   Tue, 26 Jul 2022 14:08:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [-next] Lockdep warnings
Message-ID: <20220726130837.n5734wq5jviocxsc@bogus>
References: <20220726104134.3b3awfphvafljdgp@bogus>
 <Yt/gyEMOtGafQX4z@FVFF77S0Q05N>
 <Yt/i/o3Sb+niH2e+@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/i/o3Sb+niH2e+@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 26, 2022 at 01:50:06PM +0100, Mark Rutland wrote:
> On Tue, Jul 26, 2022 at 01:40:40PM +0100, Mark Rutland wrote:
> > [Adding Peter; I suspect this is due to the cpuidle rework]
> 
> Looking again I see the cpuidle rework isn't in next, so evidently not...
> 

Yes, that is the first thing I checked and saw it wasn't in next. The first
splat I had see 2 weeks ago seem to suggest something around context_tracking
patches in the -next but I no longer see that. I haven't spent time digging
this, so thought better to post the splat on the list in the meantime.

-- 
Regards,
Sudeep
