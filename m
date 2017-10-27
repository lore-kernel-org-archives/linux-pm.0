From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Remove Eduardo's git tree
Date: Fri, 27 Oct 2017 10:22:31 +0800
Message-ID: <1509070951.3536.28.camel@intel.com>
References: <20170924211843.11451-1-f.fainelli@gmail.com>
         <44d01b56-191e-d955-3be8-f413d18b5597@gmail.com>
         <aa79dc4c-8a76-9d98-d94f-3250fd8a328f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:12116 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdJ0CWm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Oct 2017 22:22:42 -0400
In-Reply-To: <aa79dc4c-8a76-9d98-d94f-3250fd8a328f@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
Cc: code@mmayer.net, mmayer@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>

CC Eduardo.

On Thu, 2017-10-26 at 19:06 +0200, Daniel Lezcano wrote:
> On 26/10/2017 18:59, Florian Fainelli wrote:
> > 
> > On 09/24/2017 02:18 PM, Florian Fainelli wrote:
> > > 
> > > Eduardo's git tree at:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > > thermal.git
> > > 
> > > has not been updated in months, remove it to avoid any confusing
> > > and
> > > patch submissions to stall.
> > > 
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > > This is agains Rui's next branch
> > The very fact that this patch has not received any response is a
> > clear
> > indication that there is something seriously wrong with the SoC
> > thermal
> > drivers maintenance.
> > 
> > Eduardo, if you can't even be bothered to respond to emails and
> > Ack/Nack, then remove yourself so you can set clear expectations
> > with
> > people attempting to get their drivers upstreamed.
> Eduardo reviewed and took my patches recently.
> 
> I don't know the status about merging them in Linus's tree.
> 
> 
Eduardo was busy on some personal stuff during last release cycle, and
now he is back and is taking thermal soc patches for next merge window.

I think he didn't response because he was not CCed.

thanks,
rui
