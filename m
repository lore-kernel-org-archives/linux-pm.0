From: Tejun Heo <tj@kernel.org>
Subject: Re: [Question] about patch: don't use [delayed_]work_pending()
Date: Fri, 2 Sep 2016 10:21:02 -0400
Message-ID: <20160902142102.GG12660@htj.duckdns.org>
References: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
 <20160901184503.GD12660@htj.duckdns.org>
 <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
 <20160902135007.GF12660@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35149 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbcIBOVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 10:21:05 -0400
Content-Disposition: inline
In-Reply-To: <20160902135007.GF12660@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: qiaozhou <qiaozhou@asrmicro.com>
Cc: linux-pm@vger.kernel.org, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, linux-kernel@vger.kernel.org

On Fri, Sep 02, 2016 at 09:50:07AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 02, 2016 at 09:17:04AM +0800, qiaozhou wrote:
> > > > I don't know whether it's meaningful to still check pending work here, or
> > > > it's not suggested to use pm_qos_update_request in this early boot up phase.
> > > > Could you help to share some opinions? (I can fix this issue by adding the
> > > > current qos value directly instead of default value, though.)
> > > Hmmm... but I suppose this is super-early in the boot.  Would it make
> > > sense to have a static variable (e.g. bool clk_fully_initailized) to
> > > gate the cancel_delayed_sync() call?
> >
> > You're right that it's indeed super-early stage. But currently we can't
> > control the gate of can_delayed_work_sync, since it's inside
> > pm_qos_update_request. Out of our control. We can choose to not call
> > pm_qos_update_request to avoid this issue, and use pm_qos_add_request
> > alternatively. Good to have it.
> 
> Ah sorry, didn't understand that the offending cancel_sync call is in
> the generic part.  Hmm... but yeah, we should still be able to take
> the same approach.  I'll see what's the right thing to gate the
> operation there.

Does the following patch work?

Subject: power: avoid calling cancel_delayed_work_sync() during early boot

of_clk_init() ends up calling into pm_qos_update_request() very early
during boot where irq is expected to stay disabled.
pm_qos_update_request() uses cancel_delayed_work_sync() which
correctly assumes that irq is enabled on invocation and
unconditionally disables and re-enables it.

Gate cancel_delayed_work_sync() invocation with kevented_up() to avoid
enabling irq unexpectedly during early boot.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Qiao Zhou <qiaozhou@asrmicro.com>
Link: http://lkml.kernel.org/r/d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com
---
 kernel/power/qos.c |   11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 97b0df7..168ff44 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -482,7 +482,16 @@ void pm_qos_update_request(struct pm_qos_request *req,
 		return;
 	}
 
-	cancel_delayed_work_sync(&req->work);
+	/*
+	 * This function may be called very early during boot, for example,
+	 * from of_clk_init(), where irq needs to stay disabled.
+	 * cancel_delayed_work_sync() assumes that irq is enabled on
+	 * invocation and re-enables it on return.  Avoid calling it until
+	 * workqueue is initialized.
+	 */
+	if (keventd_up())
+		cancel_delayed_work_sync(&req->work);
+
 	__pm_qos_update_request(req, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
