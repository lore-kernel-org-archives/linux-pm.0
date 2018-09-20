From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/12][RFC v3] x86-32, hibernate: Switch to relocated
 restore code during resume on 32bit system
Date: Fri, 21 Sep 2018 00:05:53 +0200
Message-ID: <20180920220553.GL27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2018-09-19 15:43:12, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Code should be executed in a safe page during page
> restoring, as the page where instruction is running
> during resume might be scribbled and causes issues.
> 
> Backport the code from 64 bit system to fix this bug.

On 32 bit, we only suspend resuming by same kernel that did the suspend.

64 bit does not have that restriction. So 32 bit code should not be actually
bugy.

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

But we'd like to remove that restriction in future, so:

Acked-by: Pavel Machek <pavel@ucw.cz>
