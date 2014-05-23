From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 2/4] cris: Update comments for generic idle conversion
Date: Fri, 23 May 2014 11:25:01 +0200
Message-ID: <20140523092501.GI9198@axis.com>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
 <1400835265-21956-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400835265-21956-3-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesper Nilsson <jespern@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 23, 2014 at 10:54:23AM +0200, Geert Uytterhoeven wrote:
> As of commit 8dc7c5ecd8d0f739728d844ee794c4fae169f9c2 ("cris: Use generic
> idle loop"), cris no longer provides cpu_idle().
> 
>   - On cris-v10, etrax_gpio_wake_up_check() is called from
>     default_idle() instead of cpu_idle(),
>   - On cris-v32, etrax_gpio_wake_up_check() is not called from
>     default_idle(), so remove this (copy-and-paste?) part.

Yes, the comment for ETRAX FS (mach-fs) is definitely copy-pasted.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
