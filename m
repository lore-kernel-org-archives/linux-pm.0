From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
Date: Mon, 27 May 2013 20:54:46 -0700
Message-ID: <20130528035446.GJ13532@quad.lixom.net>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
 <51A33D83.905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51A33D83.905@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rafael >> \"'Rafael J. Wysocki'\"" <rafael.j.wysocki@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, Bastian Hecht <hechtb+renesas@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, arm@kernel.org, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 27, 2013 at 01:03:31PM +0200, Daniel Lezcano wrote:
> On 05/27/2013 10:59 AM, Simon Horman wrote:
> > From: Bastian Hecht <hechtb@gmail.com>
> > 
> > We make use of the r8a7740 Suspend To Ram code to plug together a
> > CPUIdle driver.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> 
> Shouldn't it go through Rafael's tree ? Or does the patch contains some
> dependencies on a code only visible in the ARM tree ?

Missing S-o-b from Simon. But this patch clearly builds on the preceding
one in the series, so merging them independently might not make much
sense. Getting an ack from Rafael would be nice though.

I was going to say that it should probably go under drivers/cpuidle as
well, but that just seems silly -- there is practically no code to share
with any other platform in this small driver, AND there's not really
any subsystem-internal data exposed. So it might just make more sense
to keep it under arch/arm instead.

Likewise, looking at the kirkwood and calxeda drivers under drivers/cpuidle,
I'm wondering why we thought it was a good idea to merge them there, besides
getting caught up in the "nothing can live under arch/arm any more" frenzy.


-Olof
