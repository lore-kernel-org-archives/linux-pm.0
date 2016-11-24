From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] powercap/intel_rapl: fix and tidy up error handling
Date: Thu, 24 Nov 2016 22:06:59 +0100
Message-ID: <CAJZ5v0jJ4kxcT0MVi3mz0zKRrEiRaNfQqPvY6y5bTHpkPpiU3A@mail.gmail.com>
References: <1479927666-563-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32898 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966004AbcKXVHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 16:07:41 -0500
In-Reply-To: <1479927666-563-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Marcin Koss <marcin.koss@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Wed, Nov 23, 2016 at 8:01 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> Commit e1399ba20eee ("powercap / RAPL: handle missing MSRs") added
> contraint_to_pl() function to return index into an array. But it
> can potentially return -EINVAL if powercap layer sends an out of
> range constraint ID. This patch adds sanity check.
>
> Unnecessary RAPL domain pointer check is removed since it must be
> initialized before calling rapl_unit_xlate().
>
> Reported-by: Odzioba, Lukasz <lukasz.odzioba@intel.com>
> Reported-by: Koss, Marcin <marcin.koss@intel.com>

Does this depend on the Thomas' series only?

Also, it looks like a Fixes: tag should be present here.

>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks,
Rafael
