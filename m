From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: documentation update
Date: Sun, 5 Feb 2006 09:18:03 +0100
Message-ID: <200602050918.03785.rjw@sisk.pl>
References: <200602050903.48678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48289327737142496=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602050903.48678.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============48289327737142496==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Update]

On Sunday 05 February 2006 09:03, Rafael J. Wysocki wrote:
> Hi,
> 
> This patch updates the swsusp documentation to reflect the recent change
> that prevented the kernel from setting to console loglevel to 10
> unconditionally during suspend.  It also removes one obsolete paragraph.
> 
> Please review.
> 
> Greetings,
> Rafael
> 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
>  Documentation/power/swsusp.txt |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.16-rc1-mm5/Documentation/power/swsusp.txt
> ===================================================================
> --- linux-2.6.16-rc1-mm5.orig/Documentation/power/swsusp.txt	2006-02-03 21:26:42.000000000 +0100
> +++ linux-2.6.16-rc1-mm5/Documentation/power/swsusp.txt	2006-02-05 08:49:07.000000000 +0100
> @@ -33,12 +33,13 @@ echo N > /sys/power/image_size
>  
>  before suspend (it is limited to 500 MB by default).
>  
> -Encrypted suspend image:
> -------------------------
> -If you want to store your suspend image encrypted with a temporary
> -key to prevent data gathering after resume you must compile
> -crypto and the aes algorithm into the kernel - modules won't work
> -as they cannot be loaded at resume time.
> +Kernel messages during suspend
> +------------------------------
> +If you want to see any kernel messages on the virtual terminal the kernel

s/any kernel messages/any non-error kernel messages/

[Sorry.]

> +switches to during suspend, you have to set the kernel console loglevel to
> +at least 4 (KERN_WARNING), for example by doing
> +
> +# echo 4 > /proc/sys/kernel/printk

Rafael

--===============48289327737142496==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48289327737142496==--
