From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 02/15] PM / Hibernate: snapshot cleanup
Date: Wed, 24 Mar 2010 23:35:36 +0100
Message-ID: <201003242335.36816.rjw__28655.6925079369$1269471504$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-2-git-send-email-jslaby@suse.cz>
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
> Remove support of reads with offset. This means snapshot_read/write_next
> now does not accept count parameter.
> 
> /dev/snapshot handler is converted to simple_read_from_buffer/simple_write_to_buffer.

Makes sense.

One coding style comment, though.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/power.h    |   18 +-----
>  kernel/power/snapshot.c |  145 ++++++++++++++++++-----------------------------
>  kernel/power/swap.c     |    8 +-
>  kernel/power/user.c     |   39 ++++++++-----
>  4 files changed, 88 insertions(+), 122 deletions(-)
> 
...  
> @@ -159,13 +160,17 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
>  		res = -ENODATA;
>  		goto Unlock;
>  	}
> -	res = snapshot_read_next(&data->handle, count);
> -	if (res > 0) {
> -		if (copy_to_user(buf, data_of(data->handle), res))
> -			res = -EFAULT;
> -		else
> -			*offp = data->handle.offset;
> -	}
> +	if (!pg_offp) { /* on page boundary? */
> +		res = snapshot_read_next(&data->handle);
> +		if (res <= 0)
> +			goto Unlock;
> +	} else
> +		res = PAGE_SIZE - pg_offp;

The official kernel coding style is to put single instructions under if/else
like this in braces if the other branch of the if/else is multiline (and
therefore naturally in braces).   So please do:

+	if (!pg_offp) { /* on page boundary? */
+		res = snapshot_read_next(&data->handle);
+		if (res <= 0)
+			goto Unlock;
+	} else {
+		res = PAGE_SIZE - pg_offp;
+	}

and analogously wherever applicable.

Thanks,
Rafael
