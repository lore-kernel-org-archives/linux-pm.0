From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: rockchip: fix compile error
Date: Wed, 11 Nov 2015 19:32:22 -0800
Message-ID: <20151112033221.GA9142@localhost.localdomain>
References: <1446990043-8096-1-git-send-email-wxt@rock-chips.com>
 <20151109193638.GB10824@localhost.localdomain>
 <20151112090658.619c3b7c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33314 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbKLDc1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 22:32:27 -0500
Content-Disposition: inline
In-Reply-To: <20151112090658.619c3b7c@canb.auug.org.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, lkp@intel.com

Hello Stephen,

On Thu, Nov 12, 2015 at 09:06:58AM +1100, Stephen Rothwell wrote:
> Hi Eduardo,
> 
> On Mon, 9 Nov 2015 11:36:39 -0800 Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > On Sun, Nov 08, 2015 at 09:40:43PM +0800, Caesar Wang wrote:
> > > Missing a include file caused compile error.
> > > 

<cut>

> > 
> > 
> > Adding this to my tree and sending to ruis too.
> 
> This missed the merge of the thermal tree into Linus' tree and so is
> now needed in Linus' tree ASAP (several builds are failing).

Sure. I will send the patch directly to Linus.

Thanks for the heads up.

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
