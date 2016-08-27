From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Suspend: Fix missing KERN_CONT for suspend message
Date: Sat, 27 Aug 2016 09:33:09 +0200
Message-ID: <20160827073308.GA13190@xo-6d-61-c0.localdomain>
References: <1477063449-24530-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477063449-24530-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2016-10-21 16:24:09, Jon Hunter wrote:
> Commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
> continuation lines") exposed a missing KERN_CONT from one of the
> messages shown on entering suspend. With v4.9-rc1, the 'done.' shown
> after syncing the filesystems no longer appears as a continuation but
> a new message with its own timestamp.
> 
> [    9.259566] PM: Syncing filesystems ... [    9.264119] done.
> 
> Fix this by adding the KERN_CONT log level for the 'done.' part of the
> message seen after syncing filesystems. While we are at it, convert
> these suspend printks to pr_info and pr_cont, respectively.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
