From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Thu, 20 Aug 2015 08:40:39 +0530
Message-ID: <20150820031039.GJ14544@linux>
References: <898726e0b847fa46a5efec40578324b1b5051ac5.1440038267.git.viresh.kumar@linaro.org>
 <55D542F1.3070004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35178 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbHTDKn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 23:10:43 -0400
Received: by pacdd16 with SMTP id dd16so8711450pac.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 20:10:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55D542F1.3070004@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Javi Merino <javi.merino@arm.com>
Cc: edubezval@gmail.com, linaro-kernel@lists.linaro.org, amit.daniel@samsung.com, linux-pm@vger.kernel.org, rui.zhang@intel.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, open list <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On 20-08-15, 05:01, Daniel Lezcano wrote:
> On 08/20/2015 04:40 AM, Viresh Kumar wrote:
> >None of the patches are reaching Viresh or Daniel directly as
> >get_maintainers doesn't report us as maintainers. Looks like file header
> >or history of commits isn't able to do that properly.
> >
> >Add a separate entry for cpu_cooling driver in MAINTAINERS.
> >
> >Acked-by: Eduardo Valentin <edubezval@gmail.com>
> >Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >Acked-by: Amit Daniel Kachhap <amit.kachhap@gmail.com>
> >Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Shouldn't be Javi Merino in Cc ?

Added him now, he wasn't there as get_maintainers missed his work :)

-- 
viresh
