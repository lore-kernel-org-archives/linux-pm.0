From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 4/4] tile: Update comments for generic idle conversion
Date: Fri, 23 May 2014 13:32:53 -0400
Message-ID: <537F8645.6060502@tilera.com>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be> <1400835265-21956-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400835265-21956-5-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5/23/2014 4:54 AM, Geert Uytterhoeven wrote:
> As of commit 0dc8153cfebac68c9523b8852b14f10b31209f08 ("tile: Use generic
> idle loop"), this applies to arch_cpu_idle() instead of cpu_idle().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>   arch/tile/include/asm/thread_info.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!  Taken into the linux-tile tree.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
