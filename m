Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC23DD503;
	Thu,  6 Aug 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006887; cv=none; b=QtxpJQ6WAsPH7iMFvKQ+6j6mIbCuiweGrfQR4Bt9I0f+3IEKgqBDEnUwE1dEyiSmZgn2SOGKguaqoQnjUV8euarRRQZjNnU4A/5Locn2M7E4UT/4VVgJJa+ftORd9f90cNB5AK6Tou0EP63I3Ob2lrfU376MH+vzMrlS4ly/HDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006887; c=relaxed/simple;
	bh=QPeb6M2iCPCZMs8c9dwgYHumyO34WqnHwJvzcycTgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9ddhym8dNCckuUCk4EorvWAnm28i4egREbhGaVNXIvhEqQGtDk/5BwcOVtevZblVuupZovUU35ao3OJw3eLmNmOOIq0VvSxf0NKDDVwkOqZ9G4UPpyjA3pG5wE86ju8F2dMEfNm8GdsS6XqKhSEf85UtYuzCpo8JCIbgKWZkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/fMIERL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/fMIERL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B74C1F000E9;
	Thu,  6 Aug 2026 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786006885;
	bh=BFIPNtqlQDio3zu8anhXqcJnHiAHEd5OCYYW3ygP5rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/fMIERLf3DnkVBBBpX/DgXd+ILZ2zjw8i3J4VAFOyRJ8tiZr+fIvnWdw3oT+MDwO
	 97Q/jdEKy6O1itc6zggqJwPjUfEHPn7wHo6gNbQSpvIXCzluvgL0xAYXUjE7kkWkTa
	 5UEY+wcl68dG+8T6PxHsfaN6YU5eczKyETTy5pJg=
Date: Thu, 6 Aug 2026 11:01:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: rafael@kernel.org, dakr@kernel.org, djakov@kernel.org,
	quic_mdtipton@quicinc.com, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 1/3] interconnect: debugfs: replace writable string
 helper
Message-ID: <2026080632-delighted-bonsai-18b7@gregkh>
References: <20260806084854.1019789-1-chenyichong@uniontech.com>
 <20260806084854.1019789-2-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806084854.1019789-2-chenyichong@uniontech.com>

On Thu, Aug 06, 2026 at 04:48:52PM +0800, Yichong Chen wrote:
> debugfs_create_str() is being made read-only because its generic write path
> is hard to make safe without adding more locking to the helper.
> 
> Convert the interconnect debugfs client src_node and dst_node entries to
> local file operations before removing writable string support from
> debugfs_create_str().  Protect the string replacement and path lookup with
> the existing debugfs_lock.
> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  drivers/interconnect/debugfs-client.c | 75 ++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
> index 08df9188ef94..b71c25fd9314 100644
> --- a/drivers/interconnect/debugfs-client.c
> +++ b/drivers/interconnect/debugfs-client.c
> @@ -5,6 +5,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/interconnect.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  #include "internal.h"
>  
> @@ -36,6 +37,59 @@ struct debugfs_path {
>  	struct list_head list;
>  };
>  
> +static ssize_t icc_node_read(struct file *file, char __user *user_buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	char **node = file->private_data;
> +	char *copy;
> +	size_t len;
> +	ssize_t ret;
> +
> +	mutex_lock(&debugfs_lock);
> +	copy = kstrdup(*node ?: "", GFP_KERNEL);
> +	mutex_unlock(&debugfs_lock);

scoped guard?

> +	if (!copy)
> +		return -ENOMEM;
> +
> +	len = strlen(copy);
> +	copy[len++] = '\n';
> +	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
> +	kfree(copy);
> +	return ret;
> +}
> +
> +static ssize_t icc_node_write(struct file *file, const char __user *user_buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	char **node = file->private_data;
> +	char *old, *new;
> +
> +	if (*ppos)
> +		return -EINVAL;
> +	if (count + 1 > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	new = memdup_user_nul(user_buf, count);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +	strim(new);
> +
> +	mutex_lock(&debugfs_lock);
> +	old = *node;
> +	*node = new;
> +	mutex_unlock(&debugfs_lock);

Same here.

> +
> +	kfree(old);
> +	return count;
> +}
> +
> +static const struct file_operations icc_node_fops = {
> +	.open = simple_open,
> +	.read = icc_node_read,
> +	.write = icc_node_write,
> +	.llseek = default_llseek,
> +};
> +
>  static struct icc_path *get_path(const char *src, const char *dst)
>  {
>  	struct debugfs_path *path;
> @@ -56,24 +110,17 @@ static int icc_get_set(void *data, u64 val)
>  
>  	mutex_lock(&debugfs_lock);
>  
> -	rcu_read_lock();
> -	src = rcu_dereference(src_node);
> -	dst = rcu_dereference(dst_node);
> -
>  	/*
>  	 * If we've already looked up a path, then use the existing one instead
>  	 * of calling icc_get() again. This allows for updating previous BW
>  	 * votes when "get" is written to multiple times for multiple paths.
>  	 */
> -	cur_path = get_path(src, dst);
> -	if (cur_path) {
> -		rcu_read_unlock();
> +	cur_path = get_path(src_node, dst_node);
> +	if (cur_path)
>  		goto out;
> -	}
>  
> -	src = kstrdup(src, GFP_ATOMIC);
> -	dst = kstrdup(dst, GFP_ATOMIC);
> -	rcu_read_unlock();
> +	src = kstrdup(src_node, GFP_KERNEL);
> +	dst = kstrdup(dst_node, GFP_KERNEL);

Why is GFP_KERNEL now ok, while GFP_ATOMIC wasn't?  Is this the rcu
stuff interacting somehow?

thanks,

greg k-h
