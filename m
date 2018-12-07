From: Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
Date: Fri, 7 Dec 2018 13:34:28 +0000
Message-ID: <20181207133428.GG31508@suse.de>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>
 <001a01d48b24$9aa38c00$cfeaa400$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001a01d48b24$9aa38c00$cfeaa400$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 03, 2018 at 08:23:56AM -0800, Doug Smythies wrote:
> In the README file, I did see that for reporting I am 
> somehow supposed to use compare-kernels.sh, but
> I couldn't figure that out.
> 

cd work/log
../../compare-kernels.sh

> By the way, I am running these tests as a regular user, but
> they seem to want to modify:
> 
> /sys/kernel/mm/transparent_hugepage/enabled
> 

Red herring in this case. Even if transparent hugepages are left as the
default, it still tries to write it stupidly. An irritating, but
harmless bug.

-- 
Mel Gorman
SUSE Labs
