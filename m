Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5AC00140
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiGZP7z (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGZP7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 11:59:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61E392F64D;
        Tue, 26 Jul 2022 08:59:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830001FB;
        Tue, 26 Jul 2022 08:59:54 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.72.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABC93F73B;
        Tue, 26 Jul 2022 08:59:52 -0700 (PDT)
Date:   Tue, 26 Jul 2022 16:59:30 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, kajetan.puchalski@arm.com
Subject: Re: [PATCH] cpuidle: Add cpu_idle_miss trace event
Message-ID: <YuAPYrAH7jRroZLn@e126311.manchester.arm.com>
References: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
 <20220726100816.3e37ed97@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726100816.3e37ed97@gandalf.local.home>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 26, 2022 at 10:08:16AM -0400, Steven Rostedt wrote:
> On Tue, 26 Jul 2022 11:24:04 +0100
> Kajetan Puchalski <kajetan.puchalski@arm.com> wrote:
 
> For the tracing POV,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks a lot for taking a look!

> -- Steve
