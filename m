From: Len Brown <lenb@kernel.org>
Subject: [0/4] pm_idle, default_idle cleanup
Date: Fri, 27 Jul 2012 18:42:51 -0400
Message-ID: <1343428975-3897-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The 1st three patches in this series are specific to x86.
With an ack from the x86 crew (the main patch still has Ingo's ack
from 16 months ago) I think they could be 3.6-rc1 cleanup candidates.

The 4th patch is enabled by the first 3 -- removing pm_idle() from pm.h
touches 10 architectures.  That one will need a bunch of acks and
post rc1 linux-next build testing to make sure it doesn't break 3.7.

thanks,
Len Brown, Intel Open Source Technology Center
