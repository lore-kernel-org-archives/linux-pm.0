From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 18:06:04 +0000
Message-ID: <alpine.DEB.2.02.1302221804340.22997@kaball.uk.xensource.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <20130222165531.GA29308@phenom.dumpdata.com> <5127A719.3060702@zytor.com> <20130222173805.GC7768@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20130222173805.GC7768@phenom.dumpdata.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Christoph Lameter <cl@linux.com>, Daniel J Blueman <daniel@numascale-asia.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Fenghua Yu <fenghua.yu@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Gleb
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Feb 2013, Konrad Rzeszutek Wilk wrote:
> On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
> > On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
> > >
> > >What is bizzare is that I do recall testing this (and Stefano also did it).
> > >So I am not sure what has altered.
> > >
> > 
> > Yes, there was a very specific reason why I wanted you guys to test it...
> 
> Exactly. And I re-ran the same test, but with a new kernel. This is what
> git reflog tells me:
> 
> 473cd24 HEAD@{75}: checkout: moving from 08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
> 08f321e HEAD@{76}: checkout: moving from linux-next to yinghai/for-x86-mm
> eb827a7 HEAD@{77}: checkout: moving from 1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
> [konrad@build linux]$ git show 08f321e
> commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Thu Nov 8 00:00:19 2012 -0800
> 
>     mm: Kill NO_BOOTMEM version free_all_bootmem_node()
> 
> And I recall Stefano later on testing (I was in a conference and did not have
> the opportunity to test it). Not sure what he ran with.
> 

FYI the last patch series I tested was Yinghai's "x86, boot, 64bit: Add
support for loading ramdisk and bzImage above 4G" v7u1.
