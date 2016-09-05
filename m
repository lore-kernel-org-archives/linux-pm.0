From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] power: avoid calling cancel_delayed_work_sync() during
 early boot
Date: Mon, 5 Sep 2016 14:58:29 +0200
Message-ID: <CAJZ5v0jyZ2=T-F13dFuzX8bZrnnhVBkkvKuZTkfVpsTf83U=dg@mail.gmail.com>
References: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
 <20160901184503.GD12660@htj.duckdns.org> <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
 <20160902135007.GF12660@htj.duckdns.org> <20160902142102.GG12660@htj.duckdns.org>
 <c8aca802-e681-8bc3-4ebc-e86cd9b7e2f4@asrmicro.com> <20160905123813.GB20784@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34647 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcIEM6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 08:58:31 -0400
In-Reply-To: <20160905123813.GB20784@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qiaozhou <qiaozhou@asrmicro.com>

On Mon, Sep 5, 2016 at 2:38 PM, Tejun Heo <tj@kernel.org> wrote:
> of_clk_init() ends up calling into pm_qos_update_request() very early
> during boot where irq is expected to stay disabled.
> pm_qos_update_request() uses cancel_delayed_work_sync() which
> correctly assumes that irq is enabled on invocation and
> unconditionally disables and re-enables it.
>
> Gate cancel_delayed_work_sync() invocation with kevented_up() to avoid
> enabling irq unexpectedly during early boot.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-and-tested-by: Qiao Zhou <qiaozhou@asrmicro.com>
> Link: http://lkml.kernel.org/r/d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com
> ---
>
> Rafael, can you please route this patch?

I will.

Thanks,
Rafael
