From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND PATCH] tools/power/x86/intel_pstate_tracer: Adjust
 directory permissions
Date: Mon, 17 Apr 2017 00:57:10 +0200
Message-ID: <CAJZ5v0gqxj97yADB4tpxONwHtrdasZREaFqLfht9id9H+Fx1QA@mail.gmail.com>
References: <1492355834-7793-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34016 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbdDPW5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Apr 2017 18:57:11 -0400
In-Reply-To: <1492355834-7793-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Sun, Apr 16, 2017 at 5:17 PM, Doug Smythies <doug.smythies@gmail.com> wrote:
> Depending on what is being done, the intel_pstate_tracer.py script
> needs to be run as root, or can be run as a regular user.
> If run the first time as root the results directory will be
> incorrect for any subsequent run as a regular user.

Which is OK.

For security reasons, non-root should not be able to modify root-owned
directories.

Thanks,
Rafael
