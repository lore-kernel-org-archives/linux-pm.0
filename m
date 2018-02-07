From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [Query] thermal: Who is using "cooling-{min|max}-level}" properties ?
Date: Wed, 7 Feb 2018 12:29:59 +0530
Message-ID: <20180207065959.GN28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36709 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeBGHAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Feb 2018 02:00:04 -0500
Received: by mail-it0-f46.google.com with SMTP id n206so1008450itg.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2018 23:00:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

Looks like I am missing the obvious and sorry for the noise in advance.

But I couldn't find any code that parses the "cooling-{min|max}-level" DT
bindings in the kernel. Yeah, almost every ARM platform have these properties
set for their CPU nodes in DT, but I don't see how these are getting used.

I even tried to remove them for my hikey platform and everything worked as if
nothing has changed (which I was expecting anyway). The deal is that the
->get_max_state() callback of the cooling drivers are getting called to get the
range at runtime and none of them refers to these bindings.

Removing code is always fun and I would be happy to post a series to clean
things up if everyone agrees. Please let me know if my understanding is correct
and if it would be fine to remove these bindings completely.

Thanks.

-- 
viresh
