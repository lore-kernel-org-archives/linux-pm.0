From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: tvp5150 regression after commit 9f924169c035
Date: Fri, 12 Feb 2016 19:26:20 -0300
Message-ID: <56BE5C0C.3060703@osg.samsung.com>
References: <56B204CB.60602@osg.samsung.com>
 <20160208105417.GD2220@tetsubishi> <56BE57FC.3020407@osg.samsung.com>
 <20160212222208.GD1529@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160212222208.GD1529@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

Hello Wolfram,

On 02/12/2016 07:22 PM, Wolfram Sang wrote:
>
>> I'm adding Tony Lindgren to the cc list as well since he is the OMAP
>> maintainer and I see that has struggled lately with runtime PM issues
>> so maybe he has more ideas.
>
> Good idea. Did you try his patch which is in my for-current branch
> ("i2c: omap: Fix PM regression with deferred probe for
> pm_runtime_reinit")?
>

Yes I did but unfortunately it did not help in this case.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
