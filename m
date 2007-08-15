From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6 patch] make kernel/power/main.c:suspend_enter()
	static
Date: Wed, 15 Aug 2007 13:25:34 +0200
Message-ID: <200708151325.35648.rjw__25547.5293416113$1187176603$gmane$org@sisk.pl>
References: <20070814212626.GB18945@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070814212626.GB18945@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 14 August 2007 23:26, Adrian Bunk wrote:
> suspend_enter() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
> This patch has been sent on:
> - 29 Jul 2007
> 
> --- linux-2.6.23-rc1-mm1/kernel/power/main.c.old	2007-07-26 14:49:44.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/kernel/power/main.c	2007-07-26 14:50:05.000000000 +0200
> @@ -120,7 +120,7 @@
>   *
>   *	This function should be called after devices have been suspended.
>   */
> -int suspend_enter(suspend_state_t state)
> +static int suspend_enter(suspend_state_t state)
>  {
>  	int error = 0;
>  
> 
> 
> 
