From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: tvp5150 regression after commit 9f924169c035
Date: Thu, 14 Apr 2016 10:27:34 -0400
Message-ID: <570FA8D6.5070308@osg.samsung.com>
References: <20160212221352.GY3500@atomide.com>
 <56BE5C97.9070607@osg.samsung.com> <20160212224018.GZ3500@atomide.com>
 <56BE65F0.8040600@osg.samsung.com> <20160212234623.GB3500@atomide.com>
 <56BE993B.3010804@osg.samsung.com> <20160412223254.GK1526@katana>
 <570ECAB0.4050107@osg.samsung.com> <20160414111257.GG1533@katana>
 <570F9DF1.3070700@osg.samsung.com> <20160414141945.GA1539@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20160414141945.GA1539@katana>
Sender: linux-media-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

Hello Wofram,

On 04/14/2016 10:19 AM, Wolfram Sang wrote:
> 
>> Yes, I also wonder why I'm the only one facing this issue... maybe no one
>> else is using the tvp5150 driver on an OMAP board with mainline?
> 
> I wonder why it only affects tvp5150. I don't see the connection yet.
> 

Yes, me neither. All other I2C devices are working properly on this board.

The only thing I can think, is that the tvp5150 needs a reset sequence in
order to be operative. It basically toggles two pins in the chip, this is
done in tvp5150_init() [0] and is needed before accessing I2C registers.

Maybe runtime pm has an effect on this and the chip is not reset correctly?

[0]: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/media/i2c/tvp5150.c#n1311

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
