From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] PM/Suspend: Introduce two new platform
	callbacks to	avoid breakage (Re: 900af0d breaks some embedded
	suspend/resume)
Date: Sun, 19 Apr 2009 21:03:30 +0100
Message-ID: <20090419200330.GA16002__22739.647611934$1240245497$gmane$org@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181626.10388.rjw@sisk.pl>
	<20090418144132.GC7148@flint.arm.linux.org.uk>
	<200904182047.48009.rjw@sisk.pl>
	<alpine.LFD.2.00.0904191357280.12867@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904191357280.12867@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 19, 2009 at 01:57:44PM -0400, Len Brown wrote:
> Acked-by: Len Brown <len.brown@intel.com>

Thanks.  Since there's no objections yet, can we get this merged?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
