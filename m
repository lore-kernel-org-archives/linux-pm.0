From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] cpufreq/intel_pstate: Add additional supported CPU ID
Date: Sat, 18 May 2013 10:09:58 -0400
Message-ID: <20130518140958.GA17314@thunk.org>
References: <1368801497-13072-1-git-send-email-dirk.j.brandewie@gmail.com>
 <1368807024-15251-1-git-send-email-dirk.j.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368807024-15251-1-git-send-email-dirk.j.brandewie@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 17, 2013 at 09:10:24AM -0700, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Add CPU ID for Ivybrigde processor.
> 
> Cc: torvalds@linux-foundation.org
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

BTW, there are some good comments about this by Arjan in this G+ post

https://plus.google.com/117091380454742934025/posts/2vEekAsG2QT

I've tested a patch identical to this on my Thinkpad T430s and it
seems to work quite well for me.

				- Ted
