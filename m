From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] kernel/fs: fix I/O wait not accounted for RW O_DSYNC
Date: Tue, 9 Feb 2016 09:27:34 -0700
Message-ID: <56BA1376.8080505@kernel.dk>
References: <1455034058-84181-1-git-send-email-stephane.gasparini@intel.com>
 <1455034058-84181-2-git-send-email-stephane.gasparini@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36217 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbcBIQ1h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 11:27:37 -0500
Received: by mail-ob0-f180.google.com with SMTP id ba1so189995267obb.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 08:27:36 -0800 (PST)
In-Reply-To: <1455034058-84181-2-git-send-email-stephane.gasparini@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@intel.com>, linux-block@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: Stephane Gasparini <stephane.gasparini@linux.intel.com>, len.brown@linux.intel.com, philippe.longepe@linux.intel.com

On 02/09/2016 09:07 AM, Stephane Gasparini wrote:
> From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
>
>   When a process is doing Random Write with O_DSYNC flag
>   the I/O wait are not accounted in the kernel (get_cpu_iowait_time_us).
>   This is preventing the governor or the cpufreq driver to account for
>   I/O wait and thus use the right pstate

Applied, thanks.

-- 
Jens Axboe

