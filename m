From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
Date: Tue, 4 Jun 2013 14:10:06 +0900
Message-ID: <20130604051006.GV23054@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
 <51A33D83.905@linaro.org>
 <20130528035446.GJ13532@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130528035446.GJ13532@quad.lixom.net>
Sender: linux-sh-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, "rafael @mail.au.vergenet.net>> \"'Rafael J. Wysocki'\"" <rafael.j.wysocki@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 27, 2013 at 08:54:46PM -0700, Olof Johansson wrote:
> On Mon, May 27, 2013 at 01:03:31PM +0200, Daniel Lezcano wrote:
> > On 05/27/2013 10:59 AM, Simon Horman wrote:
> > > From: Bastian Hecht <hechtb@gmail.com>
> > > 
> > > We make use of the r8a7740 Suspend To Ram code to plug together a
> > > CPUIdle driver.
> > > 
> > > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > 
> > Shouldn't it go through Rafael's tree ? Or does the patch contains some
> > dependencies on a code only visible in the ARM tree ?
> 
> Missing S-o-b from Simon. But this patch clearly builds on the preceding
> one in the series, so merging them independently might not make much
> sense. Getting an ack from Rafael would be nice though.
> 
> I was going to say that it should probably go under drivers/cpuidle as
> well, but that just seems silly -- there is practically no code to share
> with any other platform in this small driver, AND there's not really
> any subsystem-internal data exposed. So it might just make more sense
> to keep it under arch/arm instead.
> 
> Likewise, looking at the kirkwood and calxeda drivers under drivers/cpuidle,
> I'm wondering why we thought it was a good idea to merge them there, besides
> getting caught up in the "nothing can live under arch/arm any more" frenzy.

After discussion with Magnus I have decided to drop these changes.
We can revisit them for a future release.
