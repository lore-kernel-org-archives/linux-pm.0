From: James King <james.king@broadcom.com>
Subject: Re: [RFC PATCH 0/5] The power allocator thermal governor
Date: Wed, 14 May 2014 10:05:15 +0000 (UTC)
Message-ID: <loom.20140514T115634-17@post.gmane.org>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51562 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414AbaENKKH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 May 2014 06:10:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1WkW8S-0006Ud-1w
	for linux-pm@vger.kernel.org; Wed, 14 May 2014 12:10:04 +0200
Received: from 212.44.20.129.ip.redstone-isp.net ([212.44.20.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 12:10:04 +0200
Received: from james.king by 212.44.20.129.ip.redstone-isp.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 12:10:04 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi Javi and Punit,

We have integrated this patchset onto an internal dual ARM cluster SoC and 
it does do a good job of holding the SoC temperature steady while running 
high performance benchmarks. Happy to be added to all the patches as "verified 
by".

Thanks, James



