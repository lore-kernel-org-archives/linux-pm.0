From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] tools/power turbostat: fix parameter passing for
 forked command
Date: Wed, 15 Jul 2015 21:18:24 -0400
Message-ID: <CAJvTdK=2bN7eYLLNrFZh7tMbiHgCjNenvf8ggSDRKhOK7XAQNA@mail.gmail.com>
References: <1436580141-26507-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34630 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbGPBS0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 21:18:26 -0400
Received: by lagx9 with SMTP id x9so34673648lag.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2015 18:18:25 -0700 (PDT)
In-Reply-To: <1436580141-26507-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

Thanks for reporting this, Yu.

Does this pre-pending a '+' to getopt_long's optstring to prevent it
from permuting the arguments help?:


-       while ((opt = getopt_long_only(argc, argv, "C:c:Ddhi:JM:m:PpST:v",

+       while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:PpST:v",



Len Brown, Intel Open Source Technology Center
