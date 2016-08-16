From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/8] Remove deprecated workqueue interface users
Date: Tue, 16 Aug 2016 10:51:20 -0400
Message-ID: <20160816145120.GC9516@htj.duckdns.org>
References: <cover.1471104124.git.bhaktipriya96@gmail.com>
 <20160815225948.GG3672@mtj.duckdns.org>
 <20160816002321.ibydaw5qrkpvyx26@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36589 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbcHPOvW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 10:51:22 -0400
Content-Disposition: inline
In-Reply-To: <20160816002321.ibydaw5qrkpvyx26@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Sebastian.

On Tue, Aug 16, 2016 at 02:23:21AM +0200, Sebastian Reichel wrote:
> At least the charger monitoring is timing critical: Many charger
> chips must be monitored (e.g. for over-temp. events). I think
> all of them have a self-protection, or a watchdog, so they would
> actually stop charging instead of overheating, but that may result
> in system failure due to power loss. Battery monitors also include
> some temperture safety checks. So without careful case-by-case
> checking the WQ_MEM_RECLAIM should not be removed IMHO.

Thanks for the clarification.  Yeah, WQ_MEM_RECLAIM seems like the
right call.

Thanks.

-- 
tejun
