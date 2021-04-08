Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635CC433ED
	for <linux-pm@archiver.kernel.org>; Thu,  8 Apr 2021 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A126661139
	for <linux-pm@archiver.kernel.org>; Thu,  8 Apr 2021 16:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhDHQMk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:12:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51245 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232332AbhDHQM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 12:12:26 -0400
Received: (qmail 1301834 invoked by uid 1000); 8 Apr 2021 12:12:10 -0400
Date:   Thu, 8 Apr 2021 12:12:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Linux-PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM: Add documentation for pm_runtime_resume_and_get()
Message-ID: <20210408161210.GB1299815@rowland.harvard.edu>
References: <20210408152209.GA1299604@rowland.harvard.edu>
 <CAJZ5v0jjhF=Xpk_WrAFXkcCh44tnqdy16uBxrPLsRcWO6VX3Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jjhF=Xpk_WrAFXkcCh44tnqdy16uBxrPLsRcWO6VX3Ow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 08, 2021 at 06:00:27PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 8, 2021 at 5:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > deal with usage counter") added a new runtime-PM API function without
> > adding any documentation for it.
> 
> Well, there is a kerneldoc comment which counts as documentation, so
> I'd rather say "without updating the documentation in runtime_pm.rst".

Okay, that's a good point.  Feel free to make this change.

> > This patch adds the missing documentation.
> 
> But otherwise fair enough.

Thank you.

Alan Stern

> 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > CC: Zhang Qilong <zhangqilong3@huawei.com>
> > Fixes: dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
> >
> > ---
> >
> >
> > [as1954]
> >
> >
> >  Documentation/power/runtime_pm.rst |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > Index: usb-devel/Documentation/power/runtime_pm.rst
> > ===================================================================
> > --- usb-devel.orig/Documentation/power/runtime_pm.rst
> > +++ usb-devel/Documentation/power/runtime_pm.rst
> > @@ -339,6 +339,10 @@ drivers/base/power/runtime.c and include
> >        checked additionally, and -EACCES means that 'power.disable_depth' is
> >        different from 0
> >
> > +  `int pm_runtime_resume_and_get(struct device *dev);`
> > +    - run pm_runtime_resume(dev) and if successful, increment the device's
> > +      usage counter; return the result of pm_runtime_resume
> > +
> >    `int pm_request_idle(struct device *dev);`
> >      - submit a request to execute the subsystem-level idle callback for the
> >        device (the request is represented by a work item in pm_wq); returns 0 on
