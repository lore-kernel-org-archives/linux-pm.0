From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 14:36:15 +0200
Message-ID: <20070427123615.GF22250@elf.ucw.cz>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Nigel, can I please get a sign-off for these if you're okay with them. 
> Rafael, Pavel, please ACK or NAK. Thanks.

> Adds a new config option CONFIG_PRINTK_NOSAVE which makes the kernel
> preserve printk() output from boot after resume.  This is useful for
> debugging hibernation.

1. This should not be a config option


> @@ -92,9 +93,9 @@ static DEFINE_SPINLOCK(logbuf_lock);
>   * The indices into log_buf are not constrained to log_buf_len - they
>   * must be masked before subscripting
>   */
> -static unsigned long log_start;	/* Index into log_buf: next char to be read by syslog() */
> -static unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
> -static unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
> +static unsigned long POSS_NOSAVE log_start;	/* Index into log_buf: next char to be read by syslog() */
> +static unsigned long POSS_NOSAVE con_start;	/* Index into log_buf: next char to be sent to consoles */
> +static unsigned long POSS_NOSAVE log_end;	/* Index into log_buf: most-recently-written-char + 1 */

2. This does not work. pointers are nosave, but logbuf is not. Eh?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
