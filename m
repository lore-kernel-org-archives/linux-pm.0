From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/12][RFC v3] x86-32, hibernate: Set up temporary text
 mapping for 32bit system
Date: Fri, 21 Sep 2018 00:05:57 +0200
Message-ID: <20180920220557.GM27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:43:22, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Set up the temporary text mapping for the final jump address
> so that the system could jump to the right address after all
> the pages have been copied back to their original address.
> 
> Back-port from 64bit system.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
