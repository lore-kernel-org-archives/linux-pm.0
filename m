From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] FS: libfs,
	implement simple_write_to_buffer
Date: Thu, 29 Apr 2010 00:10:33 +0200
Message-ID: <201004290010.33950.rjw__15359.3402741992$1272492694$gmane$org@sisk.pl>
References: <1272356118-10012-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1272356118-10012-1-git-send-email-jslaby@suse.cz>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 27 April 2010, Jiri Slaby wrote:
> It will be used in suspend code and serves as an easy wrap around
> copy_from_user. Similar to simple_read_from_buffer, it takes care
> of transfers with proper lengths depending on available and count
> parameters and advances ppos appropriately.

Will anyone object if I take this one into the suspend-2.6 tree?

Rafael


> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/libfs.c         |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |    2 ++
>  2 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index ea9a6cc..cfab42a 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -547,6 +547,40 @@ ssize_t simple_read_from_buffer(void __user *to, size_t count, loff_t *ppos,
>  }
>  
>  /**
> + * simple_write_to_buffer - copy data from user space to the buffer
> + * @to: the buffer to write to
> + * @available: the size of the buffer
> + * @ppos: the current position in the buffer
> + * @from: the user space buffer to read from
> + * @count: the maximum number of bytes to read
> + *
> + * The simple_write_to_buffer() function reads up to @count bytes from the user
> + * space address starting at @from into the buffer @to at offset @ppos.
> + *
> + * On success, the number of bytes written is returned and the offset @ppos is
> + * advanced by this number, or negative value is returned on error.
> + **/
> +ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
> +		const void __user *from, size_t count)
> +{
> +	loff_t pos = *ppos;
> +	size_t ret;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= available || !count)
> +		return 0;
> +	if (count > available - pos)
> +		count = available - pos;
> +	ret = copy_from_user(to + pos, from, count);
> +	if (ret == count)
> +		return -EFAULT;
> +	count -= ret;
> +	*ppos = pos + count;
> +	return count;
> +}
> +
> +/**
>   * memory_read_from_buffer - copy data from the buffer
>   * @to: the kernel space buffer to read to
>   * @count: the maximum number of bytes to read
> @@ -864,6 +898,7 @@ EXPORT_SYMBOL(simple_statfs);
>  EXPORT_SYMBOL(simple_sync_file);
>  EXPORT_SYMBOL(simple_unlink);
>  EXPORT_SYMBOL(simple_read_from_buffer);
> +EXPORT_SYMBOL(simple_write_to_buffer);
>  EXPORT_SYMBOL(memory_read_from_buffer);
>  EXPORT_SYMBOL(simple_transaction_set);
>  EXPORT_SYMBOL(simple_transaction_get);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 66f3caa..e594a8d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2372,6 +2372,8 @@ extern void simple_release_fs(struct vfsmount **mount, int *count);
>  
>  extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
>  			loff_t *ppos, const void *from, size_t available);
> +extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
> +		const void __user *from, size_t count);
>  
>  extern int simple_fsync(struct file *, struct dentry *, int);
>  
> 
