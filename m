From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: Fix turbo frequency reporting for pre-Sandy Bridge cores
Date: Tue, 11 Apr 2017 14:36:17 +0200
Message-ID: <22617475.I35FT52FBz@skinner>
References: <20170410232944.GA4152@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdDKMgY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 08:36:24 -0400
In-Reply-To: <20170410232944.GA4152@decadent.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: 859978@bugs.debian.org, GSR <gsr.bugs@infernal-iceberg.com>, linux-pm@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>

Hi Ben,

good catch, thanks!
Could you resubmit adding my Signed-off-by, please.
Rafael could directly pick it up then?

> Reported-by: GSR <gsr.bugs@infernal-iceberg.com>
> Tested-by: GSR <gsr.bugs@infernal-iceberg.com>

These seem not to make much sense, at least not in the kernel changelog?
