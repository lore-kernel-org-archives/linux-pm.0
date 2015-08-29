From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: power_allocator: allocate with kcalloc what you
 free with kfree
Date: Sat, 29 Aug 2015 13:27:46 +0100
Message-ID: <20150829122737.GA2840@e104805>
References: <1440526955-9860-1-git-send-email-javi.merino@arm.com>
 <20150827154936.GH5653@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150827154936.GH5653@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

On Thu, Aug 27, 2015 at 04:49:37PM +0100, Javi Merino wrote:
> On Tue, Aug 25, 2015 at 07:22:35PM +0100, Javi Merino wrote:
> > Commit cf736ea6f902 ("thermal: power_allocator: do not use devm*
> > interfaces") forgot to change a devm_kcalloc() to just kcalloc(), but
> > it's corresponding devm_kfree() was changed to kfree().  Allocate with
> > kcalloc() to match the kfree().
> > 
> > Fixes: cf736ea6f902 ("thermal: power_allocator: do not use devm* interfaces")
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> > 
> > Can this be merged for 4.2, please?  I'm having memory problems with
> > 4.2-rc8 because of this.
> 
> Please merge this for 4.2 or revert cf736ea6f902 ("thermal:
> power_allocator: do not use devm* interfaces")

cf736ea6f902 ("thermal: power_allocator: do not use devm*
interfaces") was merged for 4.2-rc8.  It leaves an allocation of
memory with devm_kcalloc() that is then freed with kfree().  The
patch at the top of the thread[0][1] fixes this.  Can you either
merge this patch or revert cf736ea6f902 for 4.2?

[0] https://patchwork.kernel.org/patch/7072591/
[1] Message-ID: <1440526955-9860-1-git-send-email-javi.merino@arm.com>

Thanks,
Javi
