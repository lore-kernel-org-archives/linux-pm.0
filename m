Return-Path: <SRS0=OhA8=A2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC366C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C04206F4
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Bc95eKcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgGOH1e (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:27:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:3959 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgGOH1d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 03:27:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4B689H1nYwz7C;
        Wed, 15 Jul 2020 09:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1594798051; bh=PJFxGFMTFR2yqU1TE9VQsY8FdsT0NV7lle6MA8J+tgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bc95eKccGiKEFR7uYoFRW5xbb1CrJ51PbFkMUdPZmpgmvZhEhqCuXIRMuDrFbLPGX
         qLlgWFl4jDoPJRQENeR4mIXN1vfmnd3RvrLKKTi2WIv6Dl8PA/pPW+jPlqQI7Dnbzp
         WyUZCOaeoTmCWw+K2Kw1ZZVBfdD9oP06FJj3ljH4ojGXOPznpeCH27BN0Ln/23l229
         T3v2TVvxahyk9M9HOXsMSjovVrCMCQiN4nueTZwE6WgUI6R7voypAluKhsZCJ/r4Sf
         mjIf74qJU15FHbFLYHiaNptv4ryY7p9c1ZwMswat0t4mG0Blz1gDBsQDxc1uiXtOO/
         wWNVzSkObPUkw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Wed, 15 Jul 2020 09:27:28 +0200
From:   Michal Miroslaw <mirq-linux@rere.qmqm.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
Message-ID: <20200715072728.GA18147@qmqm.qmqm.pl>
References: <cover.1594790493.git.yu.c.chen@intel.com>
 <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
 <20200715070614.GA2297388@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715070614.GA2297388@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 09:06:14AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2020 at 02:28:03PM +0800, Chen Yu wrote:
> > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > has added some tracepoints to monitor the change of runtime usage, and
> > there is something to improve:
> > 1. There are some places that adjust the usage count not
> >    been traced yet. For example, pm_runtime_get_noresume() and
> >    pm_runtime_put_noidle()
> > 2. The change of the usage count will not be tracked if decreased
> >    from 1 to 0.
> > 
> > This patch intends to adjust the logic to be consistent with the
> > change of usage_counter, that is to say, only after the counter has
> > been possibly modified, we record it. Besides, all usage changes will
> > be shown using rpm_usage even if included by other trace points.
> > And these changes has helped track down the e1000e runtime issue.
> > 
> > Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 85a248e196ca..5789d2624513 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> >  	int retval;
> >  
> >  	if (rpmflags & RPM_GET_PUT) {
> > -		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > -			trace_rpm_usage_rcuidle(dev, rpmflags);
> > +		bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> > +
> > +		trace_rpm_usage_rcuidle(dev, rpmflags);
> 
> Why not just call trace everywhere before you do the atomic operations?
> Why does the trace need to be called after the operation everywhere?

I would argue that this is easier mentally: We trace what state the
device is in from now on (a "current state" for the time being) instead
of tracing what it was before (an information that has just expired).

Best Regards,
Micha³ Miros³aw
