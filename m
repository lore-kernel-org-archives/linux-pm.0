From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Doc/PM: Sync with intel_powerclamp code behavior
Date: Thu, 20 Apr 2017 15:35:26 -0600
Message-ID: <20170420153526.43f3f6ed@lwn.net>
References: <1492193964-49735-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:47576 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965863AbdDTVf2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Apr 2017 17:35:28 -0400
In-Reply-To: <1492193964-49735-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Masanari Iida <standby24x7@gmail.com>, Wang Xiaolong <xiaolong.wang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Fri, 14 Apr 2017 11:19:24 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Commit feb6cd6a0f9f ("thermal/intel_powerclamp: stop sched tick in forced
> idle") changed how idle injection accouting, so we need to update
> the documentation accordingly.
> 
> This patch also expands more details on the behavior of cur_state.

Applied to the docs tree, thanks.

jon
