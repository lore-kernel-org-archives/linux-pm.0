Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CF31E845;
	Thu,  6 Aug 2026 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006943; cv=none; b=cTxamUwsH+HLOiFQp3tJo44krnLsrXL4bbv3UlNMrfQuheAF6Zu1EL78nWlp4YXin/ZjTnQY34KTnl/yeovCsThHkRw6dAGmW/iq5G8VoEv2yvGuPdb95GD0iH1z8AIPvi/Xh4SfH3ophdGNODE2e6xwpGRWEpKSfCrs6OEL4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006943; c=relaxed/simple;
	bh=BhoAIRSSw12dwlgtkrUG8lawrlcOm1C2AjCzInw67mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2SARmgEOU4vr44PZUh6hp81fK3owHrI6qxHr60hZ/0Uc1kaqdPLPwAMmMMMfWMD1FXY+ljY5iqMF0qpuc7UG8RiNvkMiA58P78kw68SYDOcKwz+spVPMMSt1WYy1+QIDP0IEc4xNwdxg6xlSIPOpZgwT3YCMEjT21Qize0X39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHioQw1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHioQw1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8681F000E9;
	Thu,  6 Aug 2026 09:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786006941;
	bh=fP86ssXPihe2gMNpYTG8Xgq5ose0BM8EMTaFtieBwMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHioQw1JYiKx68eTF6pCOnzKC1rHeHuuwJ8b7f1TmUtHMxRv2bNp7z0jdDKNEjjZa
	 9UpqaJghk4zpTXEVXkB3NmZiPSERlpSqLNdF1+HW9FG+KFbXBaz3UPGIRkPaI8sPJo
	 U0/hsCoNHHni3FWmPhHfFUmSPxsbyE64pnpPUNnk=
Date: Thu, 6 Aug 2026 11:02:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: rafael@kernel.org, dakr@kernel.org, djakov@kernel.org,
	quic_mdtipton@quicinc.com, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soundwire: debugfs: replace writable string helper
Message-ID: <2026080613-expert-primary-a222@gregkh>
References: <20260806084854.1019789-1-chenyichong@uniontech.com>
 <20260806084854.1019789-3-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806084854.1019789-3-chenyichong@uniontech.com>

On Thu, Aug 06, 2026 at 04:48:53PM +0800, Yichong Chen wrote:
> debugfs_create_str() is being made read-only because its generic write path
> is hard to make safe without adding more locking to the helper.
> 
> Convert the SoundWire firmware_file entry to a local write-only file
> operation before removing writable string support from
> debugfs_create_str().
> 
> Copy the firmware name before request_firmware() so later debugfs writes
> cannot replace the string while it is being used.
> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  drivers/soundwire/debugfs.c | 56 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 099eb84a548e..bba2b65a0668 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -145,6 +145,38 @@ static u32 start_addr;
>  static size_t num_bytes;
>  static u8 read_buffer[MAX_CMD_BYTES];
>  static char *firmware_file;
> +static DEFINE_MUTEX(firmware_file_lock);
> +
> +static ssize_t firmware_file_write(struct file *file,
> +				   const char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
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
> +	mutex_lock(&firmware_file_lock);
> +	old = firmware_file;
> +	firmware_file = new;
> +	mutex_unlock(&firmware_file_lock);

scoped lock?

> +
> +	kfree(old);
> +	return count;
> +}
> +
> +static const struct file_operations firmware_file_fops = {
> +	.open = simple_open,
> +	.write = firmware_file_write,
> +	.llseek = default_llseek,
> +};
>  
>  static int set_command(void *data, u64 value)
>  {
> @@ -246,6 +278,7 @@ static int cmd_go(void *data, u64 value)
>  {
>  	const struct firmware *fw = NULL;
>  	struct sdw_slave *slave = data;
> +	char *fw_name = NULL;
>  	ktime_t start_t;
>  	ktime_t finish_t;
>  	int ret;
> @@ -265,15 +298,24 @@ static int cmd_go(void *data, u64 value)
>  	}
>  
>  	if (cmd == 0) {
> -		ret = request_firmware(&fw, firmware_file, &slave->dev);
> +		mutex_lock(&firmware_file_lock);

Again, scoped lock?

> +		if (firmware_file)
> +			fw_name = kstrdup(firmware_file, GFP_KERNEL);
> +		mutex_unlock(&firmware_file_lock);
> +		if (!fw_name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = request_firmware(&fw, fw_name, &slave->dev);
>  		if (ret < 0) {
> -			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
> +			dev_err(&slave->dev, "firmware %s not found\n", fw_name);
>  			goto out;
>  		}
>  		if (fw->size < num_bytes) {
>  			dev_err(&slave->dev,
>  				"firmware %s: firmware size %zd, desired %zd\n",
> -				firmware_file, fw->size, num_bytes);
> +				fw_name, fw->size, num_bytes);
>  			goto out;
>  		}
>  	}
> @@ -306,6 +348,7 @@ static int cmd_go(void *data, u64 value)
>  out:
>  	if (fw)
>  		release_firmware(fw);
> +	kfree(fw_name);
>  
>  	pm_runtime_mark_last_busy(&slave->dev);
>  	pm_runtime_put(&slave->dev);
> @@ -358,7 +401,8 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
>  
>  	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
>  	if (firmware_file)
> -		debugfs_create_str("firmware_file", 0200, d, &firmware_file);
> +		debugfs_create_file("firmware_file", 0200, d, NULL,
> +				    &firmware_file_fops);
>  
>  	slave->debugfs = d;
>  }
> @@ -370,8 +414,10 @@ void sdw_slave_debugfs_exit(struct sdw_slave *slave)
>  
>  void sdw_debugfs_init(void)
>  {
> +	mutex_lock(&firmware_file_lock);
>  	if (!firmware_file)
>  		firmware_file = kstrdup("", GFP_KERNEL);
> +	mutex_unlock(&firmware_file_lock);

Same here.

>  
>  	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
>  }
> @@ -379,6 +425,8 @@ void sdw_debugfs_init(void)
>  void sdw_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(sdw_debugfs_root);
> +	mutex_lock(&firmware_file_lock);

And here.

>  	kfree(firmware_file);
>  	firmware_file = NULL;

This doesn't need to get set to NULL, right?

thanks,

greg k-h
