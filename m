From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] add a printk_init variant storing format
	strings in	__initdata
Date: Wed, 04 Jun 2008 09:56:32 +0100
Message-ID: <1212569792.4042.52.camel__19236.9058532224$1212570030$gmane$org@shinybook.infradead.org>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212485252.0@pinky>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-06-03 at 10:27 +0100, Andy Whitcroft wrote:
> +#define printk_init(fmt, args...) \
> +do { \
> +        static char __printk_init_fmt[] __initdata = fmt; \
> +        __printk_init(__printk_init_fmt, ##args); \
> +} while (0)

Hm, do these strings still get merged? Perhaps we want them in
a .initdata.str section on their own?

Bonus points for letting the linker 'merge' such strings into the
real .rodata.str section if they exist there too.

-- 
dwmw2
