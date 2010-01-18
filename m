From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Mon, 18 Jan 2010 18:00:38 +0100
Message-ID: <201001181800.38574.oliver__17933.8619499051$1263834128$gmane$org@neukum.org>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001170138.37283.rjw@sisk.pl> <201001171455.55909.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001171455.55909.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Sonntag, 17. Januar 2010 14:55:55 schrieb Rafael J. Wysocki:
> +void mm_force_noio_allocations(void)
> +{
> +       /* Wait for all slowpath allocations using the old mask to complete */
> +       down_write(&gfp_allowed_mask_sem);
> +       saved_gfp_allowed_mask = gfp_allowed_mask;
> +       gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
> +       up_write(&gfp_allowed_mask_sem);
> +}

In addition to this you probably want to exhaust all memory reserves
before you fail a memory allocation and forbid the OOM killer to run.

	Regards
		Oliver
