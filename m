From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/8] Remove deprecated workqueue interface users
Date: Mon, 15 Aug 2016 18:59:48 -0400
Message-ID: <20160815225948.GG3672@mtj.duckdns.org>
References: <cover.1471104124.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33469 "EHLO
	mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbcHOW7u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2016 18:59:50 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471104124.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 13, 2016 at 09:41:21PM +0530, Bhaktipriya Shridhar wrote:
> This patch set removes the instances of deprecated
> create_singlethread_workqueues in drivers/power by making the appropriate
> conversions.
> 
> Bhaktipriya Shridhar (8):
>   power: abx500_chargalg: Remove deprecated create_singlethread_workqueue
>   power: ab8500_btemp: Remove deprecated create_singlethread_workqueue
>   power: pm2301_charger: Remove deprecated create_singlethread_workqueue
>   power: intel_mid_battery: Remove deprecated create_singlethread_workqueue
>   power: ab8500_charger: Remove deprecated create_singlethread_workqueue
>   power: ipaq_micro_battery: Remove deprecated create_singlethread_workqueue
>   power: ab8500_fg: Remove deprecated create_singlethread_workqueue
>   power: ds2760_battery: Remove deprecated create_singlethread_workqueue

Patches look good to me.  I'm a bit curious about WQ_MEM_RECLAIM part
tho.  I suppose the reasoning is that as the hardware in question is
involved in battery management which may be time critical,
WQ_MEM_RECLAIM is added to ensure (timely) forward progress under
memory pressure, right?  It'd be great if someone who's more familiar
with these hardware can confirm whether this is actually necessary.

Oh, it'd also be nice to put the target subsystem in the subject of
the patchset - e.g. "[PATCH 0/8] power: Remove..."

Thanks.

-- 
tejun
