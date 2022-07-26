Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8CC00140
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jul 2022 14:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGZOhg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGZOhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 10:37:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0599E1166;
        Tue, 26 Jul 2022 07:37:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61CBB1FB;
        Tue, 26 Jul 2022 07:37:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1BDB3F70D;
        Tue, 26 Jul 2022 07:37:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:37:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [-next] Lockdep warnings
Message-ID: <20220726143731.qe4pdsttv3qwqiuf@bogus>
References: <20220726104134.3b3awfphvafljdgp@bogus>
 <Yt/gyEMOtGafQX4z@FVFF77S0Q05N>
 <Yt/i/o3Sb+niH2e+@FVFF77S0Q05N>
 <20220726130837.n5734wq5jviocxsc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726130837.n5734wq5jviocxsc@bogus>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 26, 2022 at 02:08:37PM +0100, Sudeep Holla wrote:
> On Tue, Jul 26, 2022 at 01:50:06PM +0100, Mark Rutland wrote:
> > On Tue, Jul 26, 2022 at 01:40:40PM +0100, Mark Rutland wrote:
> > > [Adding Peter; I suspect this is due to the cpuidle rework]
> > 
> > Looking again I see the cpuidle rework isn't in next, so evidently not...
> > 
> 
> Yes, that is the first thing I checked and saw it wasn't in next. The first
> splat I had see 2 weeks ago seem to suggest something around context_tracking
> patches in the -next but I no longer see that. I haven't spent time digging
> this, so thought better to post the splat on the list in the meantime.
> 

OK, I need to take back that the issue is only on -next. Just tested
v5.19-rc8 and v5.18, both has the splat with lockdep on. It could be just
that it has been a while since I booted a kernel with lockdep on.

-- 
Regards,
Sudeep
