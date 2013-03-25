From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH for 3.9 0/2] thermal: Marvell SoC thermal formula fixes
Date: Mon, 25 Mar 2013 16:17:36 +0800
Message-ID: <1364199456.2465.46.camel@rzhang1-mobl4>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47239 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab3CYISE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:18:04 -0400
In-Reply-To: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>

Hi,

Ezequiel, thanks for your patch.

On Fri, 2013-03-22 at 09:23 -0300, Ezequiel Garcia wrote:
> This is a small patchset that fixes thermal sensor formulas for Kirkwood
> and Dove thermal driver. The old formulas had been taken from 88AP510 public
> datasheets which appears to be slightly wrong.
> 
> The current formula comes from Marvell internal documentation
> and has been confirmed by Lior Amsalem.
> 
> This has been tested on a Kirkwood board (Openblocks A6) only.
> If at all possible, I would like to have the Dove fix tested
> before this is merged.
> 
> Please note that this fix was previously part of a bigger thermal
> patchset [1]. I've taken this out so it can be applied on v3.9 first.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg231697.html
> 
> Ezequiel Garcia (2):
>   thermal: kirkwood: Fix thermal sensor formula
>   thermal: dove: Fix thermal sensor formula
> 

Nobuhiro and Andrew,

what do you think of these patches?
As I have no idea of the hardware details, I need your comments before
applying them.

thanks,
rui

>  drivers/thermal/dove_thermal.c     |    7 ++++---
>  drivers/thermal/kirkwood_thermal.c |    8 ++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 


