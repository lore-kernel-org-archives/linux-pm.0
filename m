From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation
Date: Mon, 27 Aug 2007 12:16:04 +0530
Message-ID: <20070827064604.GD9809__34192.5748660744$1188225932$gmane$org@in.ibm.com>
References: <1188177245.3247.36.camel@caritas-dev.intel.com>
	<20070827050027.GB9809@in.ibm.com>
	<1188195529.3247.82.camel@caritas-dev.intel.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1188195529.3247.82.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 27, 2007 at 02:18:49PM +0800, Huang, Ying wrote:

[..]
> > 
> > If one compiles the kernel C to boot from reserved memory area (subset
> > of memory area used by kernel B), then I can skip the step of kexecing
> > from C to D? (COFIG_PHYSICAL_START)
> 
> Yes. I think so.
> 
> > Alternatively, can we give hint to kernel C to run from a specified address
> > at run time with the help of command line parameters. What I mean boot-loader
> > can load the kernel at any address, but kernel will move itself to run
> > from a different location depending on command line parameter.  For example,
> > let say kernel_run_addr = 0x1000000. This parameter will tell the kernel
> > to move itself to 16MB address and run from there. I think it can be made
> > to work with little work in existing setup of relocatable kernel.
> > 
> > Kernel run address can be put by some user space script which will save
> > the hibernated image of original kernel. So after saving the /proc/vmcore,
> > script can modify the boot loader config file to append the right
> > command line to the kernel (kernel_run_addr).
> > 
> > After hibernation, user will shutdown/reboot. Next time the kernel boots
> > it will load at 16MB addr (because of kernel_run_addr) and then it can
> > restore the previously saved image.
> > 
> > We shall have to get rid of (kernel_run_addr) parameter from command
> > line while resuming. One can restore the image (krestore) and then edit
> > the boot loader config file to get rid of command line param, kernel_run_addr.
> > 
> > In this scheme, with the help of relocatable kernel, we can use a single
> > kernel for everything. (A, B, C, D). We will also avoid additional kexec
> > from kernel C to kernel D.
> > 
> > I think in the long run we shall have to work out so that a user does
> > not have to maintain multiple kernels. 
> 
> Only one relocatable kernel image is needed. In fact, I use one
> relocatable kernel image in testing during development.
> 
> > Does this make sense?
> 
> Yes, this is a sensible optimization. But I think it may be better to
> make bootloader load kernel D directly into a specified memory location.
> For example, we can add a option to "kernel" command of grub. 
> 

IIUC, you mean a command line option which is parsed by boot-loader and
then boot-loader loads the kernel at user specified address?

I think it might not be a very good idea as hibernation becomes boot-loader
dependent scheme. How many boot-loaders will one modify and hibernation
will not work with older versions of boot-loader. 

I think it is better to make kernel relocate to user specified address and
keep hibernation mechanism independent of specific boot-loader(grup, lilo,...)
and boot-loader version.

Thanks
Vivek
