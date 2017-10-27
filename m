From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Remove Eduardo's git tree
Date: Thu, 26 Oct 2017 20:41:25 -0700
Message-ID: <20171027034123.GA16699@localhost.localdomain>
References: <20170924211843.11451-1-f.fainelli@gmail.com>
 <44d01b56-191e-d955-3be8-f413d18b5597@gmail.com>
 <aa79dc4c-8a76-9d98-d94f-3250fd8a328f@linaro.org>
 <1509070951.3536.28.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:56629 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdJ0Dl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2017 23:41:29 -0400
Content-Disposition: inline
In-Reply-To: <1509070951.3536.28.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, code@mmayer.net, mmayer@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>

Hello Florian,

On Fri, Oct 27, 2017 at 10:22:31AM +0800, Zhang Rui wrote:
> CC Eduardo.
> 
> On Thu, 2017-10-26 at 19:06 +0200, Daniel Lezcano wrote:
> > On 26/10/2017 18:59, Florian Fainelli wrote:
> > > 
> > > On 09/24/2017 02:18 PM, Florian Fainelli wrote:
> > > > 
> > > > Eduardo's git tree at:
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > > > thermal.git
> > > > 
> > > > has not been updated in months, remove it to avoid any confusing
> > > > and
> > > > patch submissions to stall.
> > > > 
> > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > ---
> > > > This is agains Rui's next branch
> > > The very fact that this patch has not received any response is a
> > > clear
> > > indication that there is something seriously wrong with the SoC
> > > thermal
> > > drivers maintenance.

> > > 
> > > Eduardo, if you can't even be bothered to respond to emails and
> > > Ack/Nack, then remove yourself so you can set clear expectations
> > > with
> > > people attempting to get their drivers upstreamed.
> > Eduardo reviewed and took my patches recently.
> > 
> > I don't know the status about merging them in Linus's tree.
> > 
> > 
> Eduardo was busy on some personal stuff during last release cycle, and
> now he is back and is taking thermal soc patches for next merge window.

Yes, past merge windows I was not able to help on the thermal subsystem
maintenance, which I do, btw, in my free time.
If you want to sponsor that, feel free to contact me in private.

*Also, not that there are TWO maintainers in the thermal subsystem, and Rui
was notified of my absence. And I am pretty sure he would take care of
patches in case you properly called his attention.*

> 
> I think he didn't response because he was not CCed.

Yup, if you do not copy me in e-mails that you want my attention, it's
hard to respond. I suppose if you want to remove a tree of a volunteer,
it would be fair if you at least copy him/her :-)

Not sure if you noticed, but the BRCM driver you pinged me in linux-pm
is also already merge in my tree and will be sent in the next merge
window as notified over email:
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=linus

Hope that helps and also clarifies.

> 
> thanks,
> rui
