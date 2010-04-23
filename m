From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: platform_bus: Allow runtime PM by default
Date: Fri, 23 Apr 2010 16:13:27 +0100
Message-ID: <20100423151327.GA23551@rakim.wolfsonmicro.main>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100422235353.GA16310@kroah.com>
	<20100423105750.GA27232@rakim.wolfsonmicro.main>
	<20100423150528.GB7648@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100423150528.GB7648@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 23, 2010 at 08:05:28AM -0700, Greg KH wrote:
> On Fri, Apr 23, 2010 at 11:57:51AM +0100, Mark Brown wrote:

> > This depends on "PM: Provide generic subsystem-level callbacks" which is
> > in Linus' tree - which kernel version are you building against and with
> > what config?  Things work fine for me in -next...

> I was using Linus's latest tree as of yesterday when this failed.  Are
> you relying on something in -next that is not in Linus's tree?

Not intentionally - it's also possible that it's specific to some option
in .config, either an option or something that gets included by default
due to the arch.
