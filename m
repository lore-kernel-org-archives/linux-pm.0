From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 3/5] thermal: dove: prepare new Dove DT Kconfig
 variable
Date: Thu, 20 Mar 2014 13:57:45 +0800
Message-ID: <1395295065.3571.10.camel@rzhang1-mobl4>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
	 <1393662801-17950-3-git-send-email-sebastian.hesselbarth@gmail.com>
	 <20140304040318.GG1872@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12371 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755088AbaCTF5x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Mar 2014 01:57:53 -0400
In-Reply-To: <20140304040318.GG1872@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Mon, 2014-03-03 at 23:03 -0500, Jason Cooper wrote:
> On Sat, Mar 01, 2014 at 09:33:19AM +0100, Sebastian Hesselbarth wrote:
> > DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> > mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> > DT-only MACH_DOVE Kconfig.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Rui, Eduardo,
> > 
> > Mark Brown requested to take the corresponding ASoC patch through
> > his tree. Therefore, I have split the former patch into individual subsystem
> > patches.              
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

applied.

thanks,
rui
> 
> thx,
> 
> Jason.


