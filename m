From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6 patch] unexport pm_power_off_prepare
Date: Sun, 29 Jul 2007 18:38:18 +0200
Message-ID: <200707291838.19309.rjw__33873.8067810938$1185726611$gmane$org@sisk.pl>
References: <20070729145935.GJ16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070729145935.GJ16817@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 July 2007 16:59, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(pm_power_off_prepare).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> --- linux-2.6.23-rc1-mm1/kernel/sys.c.old	2007-07-28 07:38:45.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/kernel/sys.c	2007-07-28 07:38:59.000000000 +0200
> @@ -104,7 +104,6 @@ EXPORT_SYMBOL(cad_pid);
>   */
>  
>  void (*pm_power_off_prepare)(void);
> -EXPORT_SYMBOL(pm_power_off_prepare);
>  
>  static int set_one_prio(struct task_struct *p, int niceval, int error)
>  {
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
