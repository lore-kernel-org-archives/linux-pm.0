From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 15:21:32 +0000
Message-ID: <20110207152132.GM10564__29723.3587633402$1297092147$gmane$org@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
	<20110207141829.GK10564@opensource.wolfsonmicro.com>
	<20110208014432.2c9288e4.sfr@canb.auug.org.au>
	<20110207145031.GL10564@opensource.wolfsonmicro.com>
	<AANLkTikw7j5Q7CGZK=Xbcgubt9LYBGiXf01wQ4nbg8NR@mail.gmail.com>
	<20110208021045.699654ca.sfr@canb.auug.org.au>
	<20110208021916.68b33b37.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110208021916.68b33b37.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@lists.linux-foundation.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 08, 2011 at 02:19:16AM +1100, Stephen Rothwell wrote:

> At least some of the powerpc defconfigs were added with CONFIG_PM
> disabled.  I assume that was on purpose (though it may not have been).

I'd not be so sure - since it's a bool without an explicit default set
Kconfig will default to disabling it and if anything enabling it is the
option that requires special effort.
