From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH 0077/1285] Replace numeric parameter like 0444 with macro
Date: Wed, 3 Aug 2016 09:29:27 +0200
Message-ID: <20160803072926.GA2921@unicorn.suse.cz>
References: <20160802103855.18883-1-baolex.ni@intel.com>
 <20160802124256.GA25315@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35863 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbcHCH3g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Aug 2016 03:29:36 -0400
Content-Disposition: inline
In-Reply-To: <20160802124256.GA25315@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Baole Ni <baolex.ni@intel.com>, rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Tue, Aug 02, 2016 at 02:42:56PM +0200, Pavel Machek wrote:
> 
> Sorry, the macros just make it _less_ readable, because you do chmod
> 666, not chmod S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH.

Actually, you can do "chmod a=rw ..." or "chmod u=rw,go=r ..." but very
few people use that syntax (the "+" or "-" variants come handy at times,
though).

                                                         Michal Kubecek

