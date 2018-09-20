From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 06/12][RFC v3] x86, hibernate: Rename temp_level4_pgt to
 temp_pgt
Date: Fri, 21 Sep 2018 00:05:30 +0200
Message-ID: <20180920220530.GH27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <5e9003beb492444e98a148dfb9413593e53da51c.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e9003beb492444e98a148dfb9413593e53da51c.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:42:39, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> As 32bit system is not using 4-level page, rename it
> to temp_pgt so that it can be reused for both 32bit
> and 64bit hibernation.
> 
> No functional change.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
