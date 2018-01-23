From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: Add mediatek related projects into
 blacklist
Date: Wed, 24 Jan 2018 02:26:54 +0800
Message-ID: <1516732014.15199.38.camel@mtkswgap22>
References: <8193c5fd73ee34b59799fdf5c6cc24ca60971d6e.1516693333.git.sean.wang@mediatek.com>
         <20180123084651.GA26581@kroah.com> <1516700314.12197.48.camel@mtkswgap22>
         <20180123094205.GA14587@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:65464 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751721AbeAWS06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jan 2018 13:26:58 -0500
In-Reply-To: <20180123094205.GA14587@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, Kevin Hilman <khilman@baylibre.com>

On Tue, 2018-01-23 at 10:42 +0100, Greg KH wrote:
> On Tue, Jan 23, 2018 at 05:38:34PM +0800, Sean Wang wrote:
> > On Tue, 2018-01-23 at 09:46 +0100, Greg KH wrote:
> > > On Tue, Jan 23, 2018 at 04:31:11PM +0800, sean.wang@mediatek.com wrote:
> > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > 
> > > > commit 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e upstream.
> > > > 
> > > > commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
> > > > device with OPP v2") not added MediaTek SoCs to the blacklist that would
> > > > lead to cause an occasional hang or unexpected behaviors on related boards
> > > > as kernelci reported and complained on [1] specifically for 4.14 and 4.15
> > > > tree.
> > > > 
> > > > For those reasons, add MediaTek SoCs into cpufreq-dt blacklist and wish
> > > > the patch be applied to 4.14 and 4.15 tree to allow kernelci able to
> > > > complete following automated kernel testing.
> > > > 
> > > > [1] https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/
> > > > 
> > > > Fixes: edeec420de24 (cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2)
> > > > Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > 
> > > What stable kernel tree(s) are you wanting this backported to?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi, Greg,
> > 
> > thanks for your help!
> > 
> > stable and stable-rc are those trees I want this backported to 
> 
> I don't understand, what exactly do you mean by this?
> 
> Have you read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly?
> 
> > Hi, Viresh
> > 
> > currently, can the patch be permitted to go through tree linux-pm branch
> > master to be part of mainline? 
> 
> Wait, this is not in Linus's tree already?  If not, what is that big
> "commit XXXX upstream" in the changelog for?
> 
> I don't see that commit in Linus's tree at all.
> 
> totally confused,
> 
> greg k-h


Hi Greg,

thanks for your instructions

Sorry for that I missed one thing: The patch is currently not in Linus
tree, but it is already in linux-next tree. So, I will wait until the
patch ends up in Linus's tree and submit again to wish the patch be
applied into 4.14.y tree or 4.15.y tree in the near future.

	Sean
