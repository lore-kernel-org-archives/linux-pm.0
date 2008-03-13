From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Thu, 13 Mar 2008 14:51:45 +0800
Message-ID: <1205391105.2240.68.camel__18004.7222799205$1205391974$gmane$org@acpi-hp-zz.sh.intel.com>
References: <200803130214.36861.lenb@kernel.org>
	<20080312234516.bb079cc5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080312234516.bb079cc5.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <andrea@qumranet.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Wed, 2008-03-12 at 23:45 -0700, Andrew Morton wrote:
> On Thu, 13 Mar 2008 02:14:36 -0400 Len Brown <lenb@kernel.org> wrote:
> 
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> > 
> > A bunch of small regression fixes, bug fixes, and a couple of minor cleanups.
> 
> I hope Rafael knows how to cross-reference the regression fixes against his list?
> 
> 
> 
> I'm sitting on five ACPI patches which look like they (or alternatives?) should
> be in 2.6.25:
> 
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-ec-revert-208c70a45624400fafd7511b96bc426bf01f8f5e.patch
> 
>   This was too poorly changelogged for me to remember what problem it
>   solves, but it seemed important at the time.
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/drivers-acpi-asus_acpic-correct-use-of-and.patch
> 
>   Fix logic error in asus_acpi.c
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/drivers-acpi-asus_acpic-correct-use-of-and.patch
> 
>   Fix an overrun.
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/revert-acpi-thermal-fixup.patch
> 
>   Hopeully fix a regression which Andrea Arcangeli hit.  Although I'm not sure
>   that he has confirmed that this revert actually works?
Well, the patch looks good, this may be caused by a BIOS problem.
anyway, I wish to get the response from Andrea so that I can do some
investigation ASAP.

thanks,
rui
