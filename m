From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Wed, 3 Aug 2011 22:16:21 -0700
Message-ID: <20110804051621.GA12336@suse.de>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573B@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573B@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 04, 2011 at 01:09:51PM +0800, Liu, ShuoX wrote:
> From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17 00:00:00 2001
> From: ShuoX Liu <shuox.liu@intel.com>
> Date: Thu, 28 Jul 2011 10:54:22 +0800
> Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.
> 
> Record S3 failure time about each reason and the latest two failed
> devices' name in S3 progress.
> We can check it through /sys/power/suspend_stats.
> 
> Change-Id: Ieed7fd74e27d3b482675a20cb0bb26b9054a1624

What is that line for?

Also, your patch is corrupted and can not be applied.

Oh, and, as you are adding a sysfs file, you MUST add a
Documentation/ABI file that describes the file and what it is for and
what it does.

Also, why is this file needed?  Who needs this file?  What's wrong with
the kernel log instead?

thanks,

greg k-h
