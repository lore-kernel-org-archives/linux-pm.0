From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 10:45:57 +0800
Message-ID: <1190342757.21818.75.camel__19273.8732825548$1190342705$gmane$org@caritas-dev.intel.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211157.28622.nigel@nigel.suspend2.net>
	<1190341137.21818.52.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211225.25874.nigel@nigel.suspend2.net>
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

On Fri, 2007-09-21 at 12:25 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 21 September 2007 12:18:57 Huang, Ying wrote:
> > > That's not true. Kexec will itself be an implementation, otherwise you'd 
> end 
> > > up with people screaming about no hibernation support. And it won't result 
> in 
> > > the complete removal of the existing hibernation code from the kernel. At 
> the 
> > > very least, it's going to want the kernel being hibernated to have an 
> > > interface by which it can find out which pages need to be saved. I 
> wouldn't 
> > 
> > This has been done by kexec/kdump guys. There is a makedumpfile utility
> > and vmcoreinfo kernel mechanism to implement this. We can just reuse the
> > work of kexec/kdump.
> 
> You've already said that you are currently saving all pages. How are you going 
> to avoid saving free pages if you don't get the information from the kernel 
> being saved? This will require more than just code reuse.

I have not tried "makedumpfile". The "makedumpfile" avoids saving free
pages through checking the "mem_map" of the original kernel. I think
there is nothing prevent it been used for kexec based hibernation image
writing.

This is an example of duplicated effort between kexec/kdump and original
hibernation implementation. Both kexec/kdump and hibernation need to
save memory image without saving the free pages. This can be done once
instead of twice.

> > > be surprised if it also ends up with an interface in which the kernel 
> being 
> > > hibernated tells it what bdev/sectors in which to save the image as well 
> > > (otherwise you're going to need a dedicated, otherwise untouched partition 
> > > exclusively for the kexec'd kernel to use), or what network settings to 
> use 
> > > if it wants to try to save the image to a network storage device. On top 
> of
> > 
> > These can be done in user space. The image writing will be done in user
> > space for kexec base hibernation.
> 
> That only complicates things more. Now you need to get the information on 
> where to save the image from the kernel being saved, then transfer it to 
> userspace after switching to the kexec kernel. That's more kernel code, not 
> less.

This is fairly simple in fact. For example, you can specify the
bdev/sectors in kernel command line when do kexec load "kexec -l <...>
--append='...'", then the image writing system can get it through
"cat /proc/cmdline".

> > > that, there are all the issues related to device reinitialisation and so 
> on, 
> > 
> > Yes. Device reinitialisation is needed. But all in all, kexec based
> > hibernation can be much simpler on the kernel side.
> 
> Sorry, but I'm yet to be convinced. I'm not unwilling, I'm just not there yet.
>  
> > > and it looks like there's greatly increased pain for users wanting to 
> > > configure this new implementation. Kexec is by no means proven to be the 
> > > panacea for all the issues.
> > 
> > Configuration is a problem, we will work on it.
> > 
> > But, because it is based on kexec/kdump instead of starting from
> > scratch, the duplicated part between hibernation and kexec/kdump can be
> > eliminated.
> 

Best Regards,
Huang Ying
