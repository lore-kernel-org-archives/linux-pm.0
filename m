From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 20:16:53 +0100
Message-ID: <201102072016.53410.rjw__8532.21294605664$1297106458$gmane$org@sisk.pl>
References: <20110207152132.GM10564@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1102071035320.1924-100000@iolanthe.rowland.org>
	<20110207154953.GN10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207154953.GN10564@opensource.wolfsonmicro.com>
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

On Monday, February 07, 2011, Mark Brown wrote:
> On Mon, Feb 07, 2011 at 10:36:31AM -0500, Alan Stern wrote:
> > On Mon, 7 Feb 2011, Mark Brown wrote:
> 
> > > I'd not be so sure - since it's a bool without an explicit default set
> > > Kconfig will default to disabling it and if anything enabling it is the
> > > option that requires special effort.
> 
> > This may be a naive suggestion, but have you considered simply _asking_
> > the people who added those defconfigs?
> 
> I'm rather hoping that they'll notice the mailing list thread or that
> someone else who knows what's going on with them does - as Geert pointed
> out there's a considerable number of defconfigs that have this turned
> off.  It seems more sensible to get some idea if this seems sane to
> people in the general case before going trying to identify and contact
> so many individuals.
> 
> If there are systems that really require disabling CONFIG_PM we probably
> need to add stuff to Kconfig to make sure it can't be enabled anyway;
> this shouldn't enable any new configurations.

Well, as I've just said, I don't like this change.  I'd very much prefer it if
CONFIG_PM_OPS were renamed to CONFIG_PM.

Thanks,
Rafael
