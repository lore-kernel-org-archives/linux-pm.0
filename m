From: Tejun Heo <tj@kernel.org>
Subject: Re: [Question] about patch: don't use [delayed_]work_pending()
Date: Fri, 2 Sep 2016 09:50:07 -0400
Message-ID: <20160902135007.GF12660@htj.duckdns.org>
References: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
 <20160901184503.GD12660@htj.duckdns.org>
 <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36822 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcIBNuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 09:50:10 -0400
Content-Disposition: inline
In-Reply-To: <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: qiaozhou <qiaozhou@asrmicro.com>
Cc: linux-pm@vger.kernel.org, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 02, 2016 at 09:17:04AM +0800, qiaozhou wrote:
> > > I don't know whether it's meaningful to still check pending work here, or
> > > it's not suggested to use pm_qos_update_request in this early boot up phase.
> > > Could you help to share some opinions? (I can fix this issue by adding the
> > > current qos value directly instead of default value, though.)
> > Hmmm... but I suppose this is super-early in the boot.  Would it make
> > sense to have a static variable (e.g. bool clk_fully_initailized) to
> > gate the cancel_delayed_sync() call?
>
> You're right that it's indeed super-early stage. But currently we can't
> control the gate of can_delayed_work_sync, since it's inside
> pm_qos_update_request. Out of our control. We can choose to not call
> pm_qos_update_request to avoid this issue, and use pm_qos_add_request
> alternatively. Good to have it.

Ah sorry, didn't understand that the offending cancel_sync call is in
the generic part.  Hmm... but yeah, we should still be able to take
the same approach.  I'll see what's the right thing to gate the
operation there.

Thanks.

-- 
tejun
