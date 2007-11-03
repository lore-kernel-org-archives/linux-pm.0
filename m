From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Move function prototypes to
	header
Date: Sat, 3 Nov 2007 19:18:56 +0100
Message-ID: <20071103181856.GA13202@elf.ucw.cz>
References: <200711031930.52378.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711031930.52378.rjw@sisk.pl>
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
Cc: Adrian Bunk <bunk@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> [Len, please add this patch to the suspend branch, thanks.]
> ---
> From: Adrian Bunk <bunk@kernel.org>
> 
> This patch moves the prototypes of count_highmem_pages() and 
> restore_highmem() to kernel/power/power.h
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
