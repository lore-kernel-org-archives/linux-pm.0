From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] intel_txt: add support for S3 memory
	integrity	protection within Intel(R) TXT launched kernel
Date: Tue, 9 Mar 2010 10:06:35 +0100
Message-ID: <20100309090635.GA30549__21375.4593897194$1268139019$gmane$org@atrey.karlin.mff.cuni.cz>
References: <4A9CE0B2.5060608@intel.com> <4ABF2B50.6070106@intel.com>
	<20091004185801.GC1378@ucw.cz>
	<D5AB6E638E5A3E4B8F4406B113A5A19A1D44A8FA@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A1D44A8FA@shsmsx501.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Wang, Shane" <shane.wang@intel.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "Brown,
	Len" <len.brown@intel.com>, "Cihula, Joseph" <joseph.cihula@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbeulich@novell.com" <jbeulich@novell.com>, "jmorris@namei.org" <jmorris@namei.org>, "peterm@redhat.com" <peterm@redhat.com>, "andi@firstfloor.org" <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> v2: Based on a complexity analysis and tradeoff, we moved all MAC'ing into tboot.
> 
> This patch adds support for S3 memory integrity protection within an Intel(R) TXT launched kernel, for all kernel and userspace memory.  All RAM used by the kernel and userspace, as indicated by memory ranges of type E820_RAM and E820_RESERVED_KERN in the e820 table, will be integrity protected.
> 

Please wrap at 80 columns.

> The MAINTAINERS file is also updated to reflect the maintainers of
>  the TXT-related code.

> Signed-off-by: Shane Wang <shane.wang@intel.com>
> Signed-off-by: Joseph Cihula <joseph.cihula@intel.com>

Certainly looks better now. ACK.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
