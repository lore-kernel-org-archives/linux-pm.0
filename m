From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec
	jump
Date: Tue, 11 Dec 2007 08:55:45 +0000
Message-ID: <1197363345.24045.96.camel__24742.6353315406$1197334702$gmane$org@caritas-dev.intel.com>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
	<20071210223117.GC27124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071210223117.GC27124@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-12-10 at 17:31 -0500, Vivek Goyal wrote:
> [..]
> >  
> > -#define KEXEC_ON_CRASH  0x00000001
> > -#define KEXEC_ARCH_MASK 0xffff0000
> > +#define KEXEC_ON_CRASH		0x00000001
> > +#define KEXEC_PRESERVE_CPU	0x00000002
> > +#define KEXEC_PRESERVE_CPU_EXT	0x00000004
> > +#define KEXEC_SINGLE_CPU	0x00000008
> > +#define KEXEC_PRESERVE_DEVICE	0x00000010
> > +#define KEXEC_PRESERVE_CONSOLE	0x00000020
> 
> Hi,
> 
> Why do we need so many different flags for preserving different types
> of state (CPU, CPU_EXT, Device, console) ? To keep things simple,
> can't we can create just one flag KEXEC_PRESERVE_CONTEXT, which will
> indicate any special action required for preserving the previous kernel's
> context so that one can swith back to old kernel?

Yes. There are too many flags, especially when we have no users of these
flags now. It is better to use one flag such as KEXEC_PRESERVE_CONTEXT
now, and create the others required flags when really needed.

Best Regards,
Huang Ying
