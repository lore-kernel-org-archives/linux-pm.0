From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/12][RFC v3] x86-32, hibernate: Switch to original page
 table after resumed
Date: Fri, 21 Sep 2018 00:05:49 +0200
Message-ID: <20180920220548.GK27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <f5dda0f48029c576d754559cfc60c2fef443c5e4.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f5dda0f48029c576d754559cfc60c2fef443c5e4.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:43:05, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> After all the pages are restored to previous address, the page
> table switches back to current swapper_pg_dir. However the
> swapper_pg_dir currently in used might not be consistent with
> previous page table, which might cause issue after resumed.
> 
> Fix this issue by switching to original page table after resumed.

"after resume".

Acked-by: Pavel Machek <pavel@ucw.cz>
