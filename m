From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] This patch is used ... [trimmed overly long subject]
Date: Sat, 25 Nov 2017 00:41:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711250032250.2316@nanos>
References: <1511483521-7264-1-git-send-email-timguo_via@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48864 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbdKXXly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Nov 2017 18:41:54 -0500
In-Reply-To: <1511483521-7264-1-git-send-email-timguo_via@aliyun.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: TimGuo <timguo_via@aliyun.com>
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, benjaminpan@viatech.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com

Tim,

Your patch looks good, but your patch description needs some care:

Please do not write full sentences in the subject line. The subject line
should be a short and precise information about the patch. The format is:

       [PATCH] subsystem: Short precise description.

in this case:

       [PATCH] x86/centaur: Mark TSC invariant

Then you add a decsription of the change in the body of the mail. Please
avoid wording like 'This patch does ...'. We already know that this is a
patch and the description should be more focussed on the WHY than on the
WHAT. The WHAT can be seen from the patch itself, but the WHY is the
information which is not in the code.

See also Documentation/process/submitting-patches.rst

Thanks,

	tglx
