From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/8] PM: suspend_block: Abort task freezing
 if a suspend_blocker is active.
Date: Sun, 2 May 2010 08:57:31 +0200
Message-ID: <20100502065731.GB1790__22171.5234722526$1272783665$gmane$org@ucw.cz>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<1272667021-21312-3-git-send-email-arve@android.com>
	<1272667021-21312-4-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1272667021-21312-4-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> If a suspend_blocker is active, suspend will fail anyway. Since
> try_to_freeze_tasks can take up to 20 seconds to complete or fail, aborting
> as soon as someone blocks suspend (e.g. from an interrupt handler) improves
> the worst case wakeup latency.
> 
> On an older kernel where task freezing could fail for processes attached
> to a debugger, this fixed a problem where the device sometimes hung for
> 20 seconds before the screen turned on.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

I acked this one before, please preserve such tags.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
