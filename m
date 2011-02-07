From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 10:36:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102071035320.1924-100000__2656.13090382448$1297093133$gmane$org@iolanthe.rowland.org>
References: <20110207152132.GM10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207152132.GM10564@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-embedded@vger.kernel.org, Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@lists.linux-foundation.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Feb 2011, Mark Brown wrote:

> On Tue, Feb 08, 2011 at 02:19:16AM +1100, Stephen Rothwell wrote:
> 
> > At least some of the powerpc defconfigs were added with CONFIG_PM
> > disabled.  I assume that was on purpose (though it may not have been).
> 
> I'd not be so sure - since it's a bool without an explicit default set
> Kconfig will default to disabling it and if anything enabling it is the
> option that requires special effort.

This may be a naive suggestion, but have you considered simply _asking_
the people who added those defconfigs?

Alan Stern
