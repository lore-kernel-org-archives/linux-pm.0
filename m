From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv3 0/8] Thermal Framework Enhancements
Date: Fri, 1 Mar 2013 05:12:29 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59292A35@BGSMSX101.gar.corp.intel.com>
References: <1360061183-14137-1-git-send-email-durgadoss.r@intel.com>
 <512FCD3C.1020504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36321 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab3CAFMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Mar 2013 00:12:47 -0500
In-Reply-To: <512FCD3C.1020504@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hi Eduardo,

> -----Original Message-----
> From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
> Sent: Friday, March 01, 2013 3:04 AM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> hongbo.zhang@linaro.org; wni@nvidia.com
> Subject: Re: [PATCHv3 0/8] Thermal Framework Enhancements
> 
> 
> Durga,
> 
> 
> 
> On 05-02-2013 06:46, Durgadoss R wrote:
> > This patch set is a v3 of the previous versions submitted here:
> > [v2]: http://lwn.net/Articles/531720/
> > [v1]: https://lkml.org/lkml/2012/12/18/108
> > [RFC]:https://patchwork.kernel.org/patch/1758921/
> 
> On this version I have some implementation details which applies mostly
> for the series. So, I am replying to patch 0 to summarize:
> 
> - Consider using linked list

This I thought through on my RFC itself.
I know we have arrays, but using list adds too many members
to the structures, and protection becomes really cryptic.

> - You may have contention on your indexes and arrays
> - overflow on your buffer (carefully check your implementation)
> - zone removal condition. can we remove zones with sensors/cdevs/maps
> registered?
> - Minors on strlcpy, snprintf, devm_ helpers
> - documentation in the code for these helper functions and also better
> naming..

I will try to take care of these in my next version, as far as I can see.
But would really help if you can point the specific code that needs
improvement.

Thanks,
Durga
