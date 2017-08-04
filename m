From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] intel-vbtn: match power button on press rather than
 release
Date: Fri, 4 Aug 2017 10:29:53 -0700
Message-ID: <20170804172953.GC21169@fury>
References: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdHDR34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 13:29:56 -0400
Content-Disposition: inline
In-Reply-To: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: AceLan Kao <acelan.kao@canonical.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Fri, Aug 04, 2017 at 12:00:06PM -0500, Mario Limonciello wrote:
> This fixes a problem where the system gets stuck in a loop
> unable to wakeup via power button in s2idle.
> 
> The problem happens because:
>  - press power button:
>    - system emits 0xc0 (power press), event ignored
>    - system emits 0xc1 (power release), event processed,
>      emited as KEY_POWER
>    - set wakeup_mode to true
>    - system goes to s2idle
>  - press power button
>    - system emits 0xc0 (power press), wakeup_mode is true,
>      system wakes
>    - system emits 0xc1 (power release), event processed,
>      emited as KEY_POWER
>    - system goes to s2idle again
> 
> To avoid this situation, process the presses (which matches what
> intel-hid does too).
> 
> Verified on an Dell XPS 9365
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

This looks good to me - responding to the release is non-intuitive IMHO
anyway.  I'd like to see agreement from AceLan, but this should go into
the 4.13 rc cycle (at rc3 currently).

-- 
Darren Hart
VMware Open Source Technology Center
