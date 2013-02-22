From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 09:30:07 -0800
Message-ID: <5127AB1F.1030407@zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com> <20130222165531.GA29308@phenom.dumpdata.com> <20130222172403.GA17056@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20130222172403.GA17056@phenom.dumpdata.com>
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
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, yinghai@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, stable@vger.kernel.org, Alexander Duyck <alexander.h.duyck@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Christoph Lameter <cl@linux.com>, Daniel J Blueman <daniel@numascale-asia.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Fenghua Yu <fenghua.yu@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Gleb Natapov <gleb@redhat.com>, Gokul Caushik <caushik>
List-Id: linux-pm@vger.kernel.org

On 02/22/2013 09:24 AM, Konrad Rzeszutek Wilk wrote:
>
> Here is a better serial log of the crash (just booting a normal Xen 4.1 + initial
> kernel with 8GB):
>

Configuration, please, especially: is early_printk compiled in?  Also, 
since this is Xen-related we really need your help on this.  A lot of 
this is not going to be meaningful to non-Xen people.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
