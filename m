From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Date: Thu, 27 Dec 2007 13:12:18 -0500
Message-ID: <20071227181218.GA15084__20386.6926873618$1198779394$gmane$org@redhat.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<20071227015716.GA6718@redhat.com>
	<1198722793.7320.15.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1198722793.7320.15.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 27, 2007 at 10:33:13AM +0800, Huang, Ying wrote:
> On Wed, 2007-12-26 at 20:57 -0500, Vivek Goyal wrote:
> [...]
> > > 9. Now, you are in the original kernel again. You can read/write the
> > >    memory image of kexeced kernel via /proc/kimgcore.
> > > 
> > 
> > Why do we need two interfaces, /proc/vmcore and /proc/kimgcore? Can't
> > we have just one say /proc/vmcore. Irrespective of what kernel you are
> > in /proc/vmcore gives you the access to the memory of kernel which was
> > previously booted.
> 
> In theory we can kexec another kernel even in a kexeced kernel, that is,
> in kernel A kexec kernel B, and in kernel B kexec another kernel C. In
> this situation, both /proc/vmcore and /proc/kimgcore has valid contents.
> So I think, it may be better to keep two interfaces.
> 

In those situations I think only one interface is better. For example, 
above will be broken if somebody kexec 4 kernels.

A-->B--->C--->D

I think better option might be if it is stack like situation. A kernel
shows you only the previous kernel's memory contents through /proc/vmcore
interface. So If I am in kernel D, I see only kernel C's memory image.
To see kernel B's memory image, one shall have to go back to kernel C.

Thanks
Vivek
