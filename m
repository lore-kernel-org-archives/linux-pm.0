From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 10:18:57 +0800
Message-ID: <1190341137.21818.52.camel__1495.4199934893$1190341090$gmane$org@caritas-dev.intel.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211120.00448.ncunningham@crca.org.au>
	<20070920184106.79e1858a.akpm@linux-foundation.org>
	<200709211157.28622.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211157.28622.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-09-21 at 11:57 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 21 September 2007 11:41:06 Andrew Morton wrote:
> > > On Friday 21 September 2007 11:06:23 Andrew Morton wrote:
> > > > On Fri, 21 Sep 2007 10:24:34 +1000 Nigel Cunningham 
> > > <nigel@nigel.suspend2.net> wrote:
> > > > 
> > > > > Hi Andrew.
> > > > > 
> > > > > On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
> > > > > > Seems like good enough for -mm to me.
> > > > > > 
> > > > > > 									Pavel
> > > > > 
> > > > > Andrew, if I recall correctly, you said a while ago that you didn't 
> want 
> > > > > another hibernation implementation in the vanilla kernel. If you're 
> going 
> > > to 
> > > > > consider merging this kexec code, will you also please consider 
> merging 
> > > > > TuxOnIce?
> > > > > 
> > > > 
> > > > The theory is that kexec-based hibernation will mainly use preexisting
> > > > kexec code and will permit us to delete the existing hibernation
> > > > implementation.
> > > > 
> > > > That's different from replacing it.
> > > 
> > > TuxOnIce doesn't remove the existing implementation either. It can 
> > > transparently replace it, but you can enable/disable that at compile time.
> > 
> > Right.  So we end up with two implementations in-tree.  Whereas
> > kexec-based-hibernation leads us to having zero implementations in-tree.
> > 
> > See, it's different.
> 
> That's not true. Kexec will itself be an implementation, otherwise you'd end 
> up with people screaming about no hibernation support. And it won't result in 
> the complete removal of the existing hibernation code from the kernel. At the 
> very least, it's going to want the kernel being hibernated to have an 
> interface by which it can find out which pages need to be saved. I wouldn't 

This has been done by kexec/kdump guys. There is a makedumpfile utility
and vmcoreinfo kernel mechanism to implement this. We can just reuse the
work of kexec/kdump.

> be surprised if it also ends up with an interface in which the kernel being 
> hibernated tells it what bdev/sectors in which to save the image as well 
> (otherwise you're going to need a dedicated, otherwise untouched partition 
> exclusively for the kexec'd kernel to use), or what network settings to use 
> if it wants to try to save the image to a network storage device. On top of

These can be done in user space. The image writing will be done in user
space for kexec base hibernation.

> that, there are all the issues related to device reinitialisation and so on, 

Yes. Device reinitialisation is needed. But all in all, kexec based
hibernation can be much simpler on the kernel side.

> and it looks like there's greatly increased pain for users wanting to 
> configure this new implementation. Kexec is by no means proven to be the 
> panacea for all the issues.

Configuration is a problem, we will work on it.

But, because it is based on kexec/kdump instead of starting from
scratch, the duplicated part between hibernation and kexec/kdump can be
eliminated.

Best Regards,
Huang Ying
