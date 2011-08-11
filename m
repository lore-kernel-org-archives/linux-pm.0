From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Thu, 11 Aug 2011 21:48:08 +0200
Message-ID: <201108112148.08220.rjw@sisk.pl>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<201108090009.42342.rjw@sisk.pl> <20110810222725.GA2012@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110810222725.GA2012@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, yanmin_zhang@linux.intel.com, Greg KH <gregkh@suse.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 11, 2011, Pavel Machek wrote:
> On Tue 2011-08-09 00:09:42, Rafael J. Wysocki wrote:
> > On Monday, August 08, 2011, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > > > Thanks for the nice pointer. I checked dynamic debug. It's really a good debug tool.
> > > > > > > > With the dynamic debug:
> > > > > > > > 1) user need write a user space parser to process the syslog output;
> > > > > > > > 2) Our testing scenario is we leave the mobile for at least hours. Then, check its status.
> > > > > > > > No serial console available during the testing. One is because console would be suspended,
> > > > > > > > and the other is serial console connecting with spi or HSU devices would consume power. These
> > > > > > > > devices are powered off at suspend-2-ram.
> > > ...
> > > > Not in the case described by Yanmin.
> > > 
> > > Really? I see the description above.
> > > 
> > > Yes, they'd need to set up syslog to only log >= KERN_ERR, then parse
> > > the (small) results. Even hours worth of suspends should not cause
> > > _that_ many errors.
> > > 
> > > Serial console is irrelevant. You need live machine to dump dmesg, but
> > > again, you need live machine to access debugfs, too.
> > 
> > This sounds like substantial overhead to collect statistics that we can
> > collect at a much lower cost in the kernel.
> 
> That's always the case, right? Everyone wants different subsets of
> syslog, and doing selection in kernel is always lowest overhead.
> 
> > The patch isn't very intrusive and rather straightforward.
> 
> No, it is not _too_ bad; but
> 
> 1) the code stays there when not debugging

Fine.  I don't really think that matters a lot, does it?

> 2) different users want different syslog subsets. Putting all the
> "interesting" subsets into /sys/debug/my_syslog_subset just does not
> seem like a way to go.

I don't agree with such a broad generalization.  From the system management
point of view suspend is rather special and the information the patch
collects is useful and would require substantial overhead to collect from
user space (and I can imagine test setups where it can't be collected from
user space).

I think that the explanation why dynamic debug isn't sufficient provided
by Yanmin is convincing.  Apparently, you think it isn't, but you haven't
proven him wrong yet.

Rafael
