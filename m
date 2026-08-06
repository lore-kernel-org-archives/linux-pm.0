Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C83420E71;
	Thu,  6 Aug 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006995; cv=none; b=tlv/IYPlzo1Ek/iVuWf0jQAV6zIVBafJ/mXn3vAD3Vd+4es4s4lRsiS0A6G/I6Y8dFXkkkkIZK9OHN22lciR7m12fS8smYG5ppph9FSvNfXvUjzMhUUHJSj7xwB/DHmcLaUlSGtSrpA2OcCLzRfExOg8foWWE12KMk/Ty2H/GT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006995; c=relaxed/simple;
	bh=hYaaeHxtlIUX9RPbGzHTyde5bpDQO814QzMaZajkgfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk7QrtCejrKix+/RttfrWOBm9wdqaKPGrXscBI3aK5/2cXmTJJHmgC1/8m6vnClwiXLKYyGyla4Q1F1yG/x8/7tdygUQHPo5lXzfsY79StpN1Bgwb1+lRwxLqki+9Rlc5HiXVj6H86DC6dhmo9Y27qpLpg7+ITE2/shVIWsQerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3+h6QPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3+h6QPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1AC1F000E9;
	Thu,  6 Aug 2026 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786006994;
	bh=lAncwb5tYNHbDlWx4NpQRxZtFZ2L75sRaN3vi62T2wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B3+h6QPqgiSowBB0AJR2JZ3YfkDEugzvz27sphIFrTVe9UUI8a7NcpcXG+TppDcke
	 cAavuAi95kE/DxD/etVUQMGEg8WDOx1uIQvsFVrT5QiqBYMI1UZ5qzUUorufSR2NoG
	 I4Zi/m/y+VRsVvi+dy0OEmA2cmq8TOpWOA2bkSh4=
Date: Thu, 6 Aug 2026 11:02:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: rafael@kernel.org, dakr@kernel.org, djakov@kernel.org,
	quic_mdtipton@quicinc.com, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 3/3] debugfs: make debugfs_create_str() read-only
Message-ID: <2026080614-unlimited-likewise-e6e0@gregkh>
References: <20260806084854.1019789-1-chenyichong@uniontech.com>
 <20260806084854.1019789-4-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806084854.1019789-4-chenyichong@uniontech.com>

On Thu, Aug 06, 2026 at 04:48:54PM +0800, Yichong Chen wrote:
> debugfs_create_str() supports replacing the backing string from userspace.
> Concurrent writers can race and free the same old string twice.
> 
> All writable in-tree users have been converted to local file operations.
> Remove the generic write support from debugfs_create_str(), and refuse to
> create a file when the caller passes write permission bits.
> 
> This makes unsupported writable use visible instead of silently creating a
> file with different permissions.
> 
> Fixes: 86b5488121db ("debugfs: Add write support to debugfs_create_str()")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  fs/debugfs/file.c | 81 ++++++-----------------------------------------
>  1 file changed, 10 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 08de6652a4f3..f5abd067b260 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1049,98 +1049,37 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  	return ret;
>  }
>  
> -static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
> -				      size_t count, loff_t *ppos)
> -{
> -	struct dentry *dentry = F_DENTRY(file);
> -	char *old, *new = NULL;
> -	int pos = *ppos;
> -	int r;
> -
> -	r = debugfs_file_get(dentry);
> -	if (unlikely(r))
> -		return r;
> -
> -	old = *(char **)file->private_data;
> -
> -	/* only allow strict concatenation */
> -	r = -EINVAL;
> -	if (pos && pos != strlen(old))
> -		goto error;
> -
> -	r = -E2BIG;
> -	if (pos + count + 1 > PAGE_SIZE)
> -		goto error;
> -
> -	r = -ENOMEM;
> -	new = kmalloc(pos + count + 1, GFP_KERNEL);
> -	if (!new)
> -		goto error;
> -
> -	if (pos)
> -		memcpy(new, old, pos);
> -
> -	r = -EFAULT;
> -	if (copy_from_user(new + pos, user_buf, count))
> -		goto error;
> -
> -	new[pos + count] = '\0';
> -	strim(new);
> -
> -	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
> -	synchronize_rcu();
> -	kfree(old);
> -
> -	debugfs_file_put(dentry);
> -	return count;
> -
> -error:
> -	kfree(new);
> -	debugfs_file_put(dentry);
> -	return r;
> -}
> -
>  static const struct file_operations fops_str = {
>  	.read =		debugfs_read_file_str,
> -	.write =	debugfs_write_file_str,
> -	.open =		simple_open,
> -	.llseek =	default_llseek,
> -};
> -
> -static const struct file_operations fops_str_ro = {
> -	.read =		debugfs_read_file_str,
> -	.open =		simple_open,
> -	.llseek =	default_llseek,
> -};
> -
> -static const struct file_operations fops_str_wo = {
> -	.write =	debugfs_write_file_str,
>  	.open =		simple_open,
>  	.llseek =	default_llseek,
>  };
>  
>  /**
> - * debugfs_create_str - create a debugfs file that is used to read and write a string value
> + * debugfs_create_str - create a debugfs file that is used to read a string value
>   * @name: a pointer to a string containing the name of the file to create.
>   * @mode: the permission that the file should have
>   * @parent: a pointer to the parent dentry for this file.  This should be a
>   *          directory dentry if set.  If this parameter is %NULL, then the
>   *          file will be created in the root of the debugfs filesystem.
> - * @value: a pointer to the variable that the file should read to and write
> - *         from. This pointer and the string it points to must not be %NULL.
> + * @value: a pointer to the variable that the file should read from. This
> + *         pointer and the string it points to must not be %NULL.
>   *
>   * This function creates a file in debugfs with the given name that
> - * contains the value of the variable @value.  If the @mode variable is so
> - * set, it can be read from, and written to.
> + * contains the value of the variable @value.  The file can be read from.
> + * Writable files are not supported; if @mode contains write permission bits,
> + * no file is created.
>   */
>  void debugfs_create_str(const char *name, umode_t mode,
>  			struct dentry *parent, char **value)
>  {
>  	if (WARN_ON(!value || !*value))
>  		return;
> +	if (WARN_ONCE(mode & 0222,
> +		      "%s() does not support writable files\n", __func__))

Why WARN_ONCE()?  multiple callers could be hitting this.

thanks,

greg k-h
