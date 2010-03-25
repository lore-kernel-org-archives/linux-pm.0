From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 14/15] PM / Hibernate: dealign swsusp_info
Date: Thu, 25 Mar 2010 23:46:56 +0100
Message-ID: <201003252346.56189.rjw__12138.7831205086$1269557473$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-14-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-14-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Jiri Slaby wrote:
> From: Jiri Slaby <jirislaby@gmail.com>
> 
> Now there is no need to have swsusp_info page aligned thanks to chunk
> i/o support. We may add more info after it on the very same page.
> Later...
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Fine by me.

Rafael


> ---
>  kernel/power/power.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 842d27b..cf1450f 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -13,7 +13,7 @@ struct swsusp_info {
>  	unsigned long		image_pages;
>  	unsigned long		pages;
>  	unsigned long		size;
> -} __attribute__((aligned(PAGE_SIZE)));
> +};
>  
>  #ifdef CONFIG_HIBERNATION
>  #ifdef CONFIG_ARCH_HIBERNATION_HEADER
> 
