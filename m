From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [patch] thermal: underflow in trip_point_temp_store()
Date: Wed, 4 Nov 2015 08:32:38 -0800
Message-ID: <20151104163236.GD8850@localhost.localdomain>
References: <20151103221434.GB19280@mwanda>
 <20151104055659.GB8850@localhost.localdomain>
 <20151104113231.GI7289@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151104113231.GI7289@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 04, 2015 at 02:32:32PM +0300, Dan Carpenter wrote:
> Oh...  Hm.  I actually sent a totally different patch to fix this
> warning and you just merged it.  I had forgotten about that.  As far as
> I am concerned this issue is solved.  :)  Sorry for sending duplicates.

Ok. Thanks :-). I guess this one took more attention for being touching
the thermal core. On IMX driver, it might still make sense to remove the
negative values as we are dealing with CPU temperature over there.

But it is good as it brings to the radar the point of reviewing again
the possibility of supporting negative temperatures. 


BR

Eduardo

> 
> regards,
> dan carpenter
> 
