From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 3/8] Hibernation: Simplify memory bitmap
Date: Thu, 10 Jul 2008 13:34:41 +0200
Message-ID: <20080710113441.GC15412__27327.4012878121$1215702963$gmane$org@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100200.55473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807100200.55473.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-07-10 02:00:54, Rafael J. Wysocki wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> Subject: Hibernation: Simplify memory bitmap
> 
> This patch simplifies the memory bitmap manipulations.
> 
> - remove the member size in struct bm_block
> 
> It is not necessary for struct bm_block to have the number of bit chunks
> that can be calculated by using end_pfn and start_pfn.
> 
> - use find_next_bit() for memory_bm_next_pfn
> 
> No need to invent the bitmap library only for the memory bitmap.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
