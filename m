From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] swsusp: simplify memory_bm_find_bit()
Date: Mon, 7 Jul 2008 14:43:07 +0200
Message-ID: <200807071443.08156.rjw__36709.1345986866$1215434608$gmane$org@sisk.pl>
References: <20080705110946.GA17071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080705110946.GA17071@localhost.localdomain>
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
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 of July 2008, Akinobu Mita wrote:
> The bit obtained by the function memory_bm_find_bit() is represented
> by addr and bit_nr. The callers of memory_bm_find_bit() just use addr
> and bit_nr as the arguments of set_bit/clear_bit/test_bit.
> 
> This patch simplifies the representation of the obtained bit without
> using BM_BITS_PER_CHUNK.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linux-pm@lists.linux-foundation.org
> ---
>  kernel/power/snapshot.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: 2.6-git/kernel/power/snapshot.c
> ===================================================================
> --- 2.6-git.orig/kernel/power/snapshot.c
> +++ 2.6-git/kernel/power/snapshot.c
> @@ -478,8 +478,8 @@ static int memory_bm_find_bit(struct mem
>  	}
>  	zone_bm->cur_block = bb;
>  	pfn -= bb->start_pfn;
> -	*bit_nr = pfn % BM_BITS_PER_CHUNK;
> -	*addr = bb->data + pfn / BM_BITS_PER_CHUNK;
> +	*bit_nr = pfn;
> +	*addr = bb->data;
>  	return 0;
>  }

Hm, I think it's better to fold that into patch 2/2.

Thanks,
Rafael
