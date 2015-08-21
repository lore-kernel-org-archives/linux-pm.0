From: Nigel Cunningham <nigel@nigelcunningham.com.au>
Subject: Re: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Fri, 21 Aug 2015 22:34:37 +1000
Message-ID: <55D71ADD.2000601@nigelcunningham.com.au>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nigelcunningham.com.au ([139.162.22.9]:54719 "EHLO
	nigelcunningham.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbbHUMer (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2015 08:34:47 -0400
In-Reply-To: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>, rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: rui.zhang@intel.com, lenb@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chen.

Is there any issue with saving and restoring MSRs unconditionally? That would simplify the patch and make things 'just work'.

Regards,

Nigel
