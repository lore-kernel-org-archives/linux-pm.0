From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Sun, 2 May 2010 09:05:55 +0200
Message-ID: <20100502070555.GE1790__30337.6552918509$1272784055$gmane$org@ucw.cz>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<1272667021-21312-3-git-send-email-arve@android.com>
	<1272667021-21312-4-git-send-email-arve@android.com>
	<1272667021-21312-5-git-send-email-arve@android.com>
	<1272667021-21312-6-git-send-email-arve@android.com>
	<1272667021-21312-7-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1272667021-21312-7-git-send-email-arve@android.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2010-04-30 15:36:59, Arve Hj??nnev??g wrote:
> Allow work to be queued that will block suspend while it is pending
> or executing. To get the same functionality in the calling code often
> requires a separate suspend_blocker for pending and executing work, or
> additional state and locking. This implementation does add additional
> state and locking, but this can be removed later if we add support for
> suspend blocking work to the core workqueue code.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

Looks ok.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
