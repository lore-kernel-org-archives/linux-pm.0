From: Cyrill Gorcunov <gorcunov@openvz.org>
Subject: Re: [PATCH] freezer: configure user space process frozen along with
 kernel threads
Date: Wed, 20 Feb 2013 13:05:07 +0400
Message-ID: <20130220090507.GV20312@moon>
References: <1361326525.9753.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:55541 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab3BTJFL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 04:05:11 -0500
Content-Disposition: inline
In-Reply-To: <1361326525.9753.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Li Fei <fei.li@intel.com>
Cc: pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, ebiederm@xmission.com, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

On Wed, Feb 20, 2013 at 10:15:25AM +0800, Li Fei wrote:
>  
> +#ifdef CONFIG_FREEZER
> +
> +static ssize_t freeze_late_read(struct file *file, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = get_proc_task(file->f_path.dentry->d_inode);
> +	char buffer[PROC_NUMBUF];
> +	int freeze_late;
> +	size_t len;
> +	if (!task)
> +		return -ESRCH;
> +	freeze_late = (task->flags & PF_FREEZER_LATE) ? 1 : 0;
> +	len = snprintf(buffer, sizeof(buffer), "%d\n", freeze_late);
> +	return simple_read_from_buffer(buf, count, ppos, buffer, len);
> +}

Don't you need put_task_struct() once you grabbed it?
