From: Andy Lutomirski <luto@amacapital.net>
Subject: Temporarily disabling SNB package C-states?
Date: Wed, 10 Jul 2013 14:03:20 -0700
Message-ID: <CALCETrWFVbTDy1u6bpe6h6fGMZHpOvKa3VmzmJ7cej9WOqFiWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:63156 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab3GJVDl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2013 17:03:41 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha12so6078063vcb.7
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2013 14:03:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org

I wrote a driver for the SNB Xeon iMC SMBUS adapter, but it doesn't
work right due to erratum BT109 (I think).  To work around it, I need
to keep a particular cpu package awake for a few ms when my driver is
in use.  Is there a good way to do this?  So far I've thought of:

 - pm_qos.  This seems hacky and it will keep a lot more of the system
awake than I need.

 - Hook into cpuidle to keep a single core awake.

 - Actually run on the target package, possibly in a kthread or
workqueue, and stay busy.  Ugh.

 - Fiddle with the package c-state limit (in
MSR_PKG_CST_CONFIG_CONTROL) directly.  This seems like it's asking for
trouble.  I'd have to coordinate with intel_idle, presumably.

Any ideas/suggestions?

--Andy
