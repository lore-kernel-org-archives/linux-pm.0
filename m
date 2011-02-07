From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 14:50:31 +0000
Message-ID: <20110207145031.GL10564__31368.2180633352$1297090283$gmane$org@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
	<20110207141829.GK10564@opensource.wolfsonmicro.com>
	<20110208014432.2c9288e4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110208014432.2c9288e4.sfr@canb.auug.org.au>
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
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 08, 2011 at 01:44:32AM +1100, Stephen Rothwell wrote:
> On Mon, 7 Feb 2011 14:18:29 +0000 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Do you mean that these systems require CONFIG_PM be turned off, or just
> > that people tend not to turn it on?  If the latter would you expect any
> > ill effects from doing so?

> I don't know the answer to either question without testing.  All I am
> saying is that currently the default for CONFIG_PM is "off" and you are
> changing it to be "on" and there may not have been any testing done of
> that in some situations.   We don't know where it was explicitly
> turned off any more since we shrank our defconfig files (which was done
> automatically) ... since it is off by default, it doesn't need to be
> mentioned in a defconfig unless it needs to be turned on.

My suspicion would be that it'll have been turned off by someone hitting
return through a config upgrade rather than through deliberate effort.
On the other hand if it is essential for some machines to have it
disabled they probably want to have somethnig in Kconfig.
