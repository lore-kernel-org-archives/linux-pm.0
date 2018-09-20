From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/12][RFC v3] x86-32, hibernate: Adjust in_suspend after
 resumed on 32bit system
Date: Fri, 21 Sep 2018 00:06:01 +0200
Message-ID: <20180920220601.GN27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <e2b157a14ddadb557c07ed2e081637c0e1dbff5e.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2b157a14ddadb557c07ed2e081637c0e1dbff5e.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:43:42, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Update the in_suspend variable to reflect the actual hibernation
> status. Back-port from 64bit system.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
