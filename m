From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] drivers/idle: make intel_idle.c driver more
 explicitly non-modular
Date: Thu, 21 Apr 2016 10:04:27 +0200
Message-ID: <20160421080427.GC14010@linaro.org>
References: <20160407165355.GA9188@linaro.org>
 <1461165906-21614-1-git-send-email-paul.gortmaker@windriver.com>
 <20160420181322.GM5862@linaro.org>
 <20160421031249.GH13379@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35613 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcDUIEc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 04:04:32 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so76843707wme.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 01:04:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160421031249.GH13379@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, rcochran@linutronix.de, linux-pm@vger.kernel.org

On Wed, Apr 20, 2016 at 11:12:49PM -0400, Paul Gortmaker wrote:

[ ... ]

> > > We replace module.h with moduleparam.h since the file does declare
> > > some module parameters, and leaving them as such is currently the
> > > easiest way to remain compatible with existing boot arg use cases.
> > 
> > What about using __setup() ? so module* disappear from the file.
> 
> No, it can't be __setup since moduleparam uses an instance of the
> filename as a prefix to the boot arg, and __setup does not.  And we
> should stay compatible with existing boot arg use cases for people
> who have embedded such a setting in their grub config a long time
> ago and forgot it.  It would take looking at and likely extending the
> early_param macro to provide a syntax compatible instance of what
> the module_param currently does if I recall correctly -- hence the
> above comment in the commit log.

-module_param(max_cstate, int, 0444);
+static int __init max_cstate_param(char *str)
+{
+       max_cstate = simple_strtol(str, NULL, 0);
+       return 1;
+}
+__setup("intel_idle.max_cstate=", max_cstate_param);


