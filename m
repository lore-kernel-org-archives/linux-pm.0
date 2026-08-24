Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA853AEF3E;
	Mon, 24 Aug 2026 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553377; cv=none; b=mbfsiFedgGCZvWsK+9fsyQxnat6TYsNBaJyFhHRrJJjtUXSlifKVDKdR4T69OEZnuu8982Iy5GmYYXtmKHgMrMDWAhVlThijGqyyHqGkpj1tk+dQOM3F2TnrapMbuRx5qOc0bwPJQPW8pHg0zrp0/TDv8pQjjW5WXhUTgBildHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553377; c=relaxed/simple;
	bh=JjT5CnkhEwXWKHCp5vcd75naMQ88yY8fBymV3FLZgIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfA4/5hNl5jReBLJ2MbGI8sUm7CUQqSbdWftzdRiTfmO/wFn4S7WS4Z5S4OX+H3uPpyvEq2eK+Y9+vbdNbZ6gVC+4C+GxXWlPbun3VhZM4C+tCKhypndFgW3aaK98SLGO3Tus6dBaR/2C9ZjfG9d8wD7Y2gX6V41oTUOC8ddBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1dcQ3e5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1dcQ3e5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FCB1F00A3A;
	Mon, 24 Aug 2026 06:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787553375;
	bh=U8VtGb2NKndAaPTn5SAVJTFXQN83mhgHX4TNHY4C+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q1dcQ3e5meKm5O3ajEK+aHSkHZkkofm91E/qbuYhkiIpFcq3+4Lq5xqpY7V0ZWfiS
	 QPhAIPCRBt4jfubDmuAfo8w8QgrqndU8Kd8aurIRTQiudzx9tM7yuhfdeZHiNxMCqs
	 GTC/MSS6sKKUWarj84R88maPLFiol4zHo7fbMR5w=
Date: Mon, 24 Aug 2026 08:34:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, lenb@kernel.org, pavel@kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: power: Fix "sucessfully" typo in comment
Message-ID: <2026082413-treason-krypton-b0b5@gregkh>
References: <20260824061621.356483-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824061621.356483-1-yogeshdangal66@gmail.com>

On Mon, Aug 24, 2026 at 12:01:21PM +0545, Chhabilal Dangal wrote:
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  drivers/base/power/clock_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 59bb37e82..3b8ba2780 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
>   *
>   * Add the clock to the list of clocks used for the power management of @dev.
>   * The power-management code will take control of the clock reference, so
> - * callers should not call clk_put() on @clk after this function sucessfully
> + * callers should not call clk_put() on @clk after this function successfully
>   * returned.
>   */
>  int pm_clk_add_clk(struct device *dev, struct clk *clk)
> -- 
> 2.55.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
