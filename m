From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/12][RFC v3] x86-32, hibernate: Use the page size macro
 instead of constant value
Date: Fri, 21 Sep 2018 00:05:44 +0200
Message-ID: <20180920220544.GJ27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <7f11d3a91409a5c3a3a6cf8e05c8e9e9b2d1e6ea.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f11d3a91409a5c3a3a6cf8e05c8e9e9b2d1e6ea.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:42:57, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Convert the hard code into PAGE_SIZE for better scalability.
> 
> No functional change.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
