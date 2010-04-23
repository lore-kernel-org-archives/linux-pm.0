From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: platform_bus: Allow runtime PM by default
Date: Fri, 23 Apr 2010 20:41:41 +0200
Message-ID: <201004232041.42064.rjw__10474.8977035799$1272049204$gmane$org@sisk.pl>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201004231840.20041.rjw@sisk.pl> <201004232026.37114.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004232026.37114.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 23 April 2010, Rafael J. Wysocki wrote:
> On Friday 23 April 2010, Rafael J. Wysocki wrote:
> > On Friday 23 April 2010, Mark Brown wrote:
> > > On Fri, Apr 23, 2010 at 09:11:57AM -0700, Greg KH wrote:
> > > > On Fri, Apr 23, 2010 at 04:57:21PM +0100, Mark Brown wrote:
> > > 
> > > > > Turns out it's commit ad53012 "i2c: Fix bus-level power management
> > > > > callbacks" in the PM tree that it depends on.  Does it make sense to
> > > > > merge this via there rather than via your tree?
> > > 
> > > > Why would an i2c specific patch be needed here?  Do you have a pointer
> > > > to that patch?
> > > 
> > > Despite the patch title being I2C specific it actually includes exposing
> > > some of the runtime PM implementation to external users - I2C being the
> > > first user of the generic PM runtime callbacks that I'm trying to use in
> > > the platform device implementation.
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=ad530128cd302e5df930b6eb4d4c7e162c40fcb2;hp=b938b00444e900f1c86e754539e3d00f172c184e
> > > http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=d690b2cd222afc75320b9b8e9da7df02e9e630ca
> > > 
> > > > And yes, if it depends on something else in the PM tree, feel free to
> > > > send this patch also through it, I have no objection to that.  Rafael,
> > > > care to pick it up?  Mark, you might have to resend it to him.
> > > 
> > > OK, Raphael please let me know if you need a resend.
> > 
> > No, thanks, I have your original post.
> 
> Now applied to suspend-2.6/linux-next .

Reverted, sorry.

The i2c patch is not in my tree, it's in the i2c tree.
Perhaps I can handle the both of them.

Jean, the patch we're discussing depends on the
"i2c: Fix bus-level power management callbacks" patch that's in your tree right
now.  Would it be possible to move the i2c patch to my tree, or alternatively
would it be acceptable for you to merge a core PM patch through your tree?

Rafael
