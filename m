From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [444/2many] MAINTAINERS - SUSPEND TO RAM:
Date: Mon, 13 Aug 2007 22:52:54 +0200
Message-ID: <200708132252.55738.rjw@sisk.pl>
References: <46bffbd5.kKrnXsYdLyNKojxF%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46bffbd5.kKrnXsYdLyNKojxF%joe@perches.com>
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
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 08:36, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ae90a2..e9e7a00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4226,6 +4226,7 @@ P:	Rafael J. Wysocki
>  M:	rjw@sisk.pl
>  L:	linux-pm@lists.linux-foundation.org
>  S:	Maintained
> +F:	kernel/power/

+F:	drivers/base/power
+F:	arch/x86_64/kernel/acpi
+F:	arch/i386/kernel/acpi/

>  
>  SONIC NETWORK DRIVER
>  P:	Thomas Bogendoerfer
> 
> 

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
