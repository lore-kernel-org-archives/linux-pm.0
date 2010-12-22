From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 21 Dec 2010 20:48:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012212045220.11252-100000__27824.6824550026$1292982541$gmane$org@netrider.rowland.org>
References: <87ipymwysi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ipymwysi.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 21 Dec 2010, Kevin Hilman wrote:

> That being said, another thing we discussed briefly at LPC was wondering
> about reason(s) behind the DPM core locking out runtime PM transitions
> in the first place.

The reason is to prevent confusion from unwanted runtime-PM state 
changes during a system sleep transition.

> Currently runtime PM transitions are blocked in dpm_prepare() and only
> allowed again in dpm_complete().  How about locking out runtime PM
> transitions only until the DPM suspend operation is complete.  IOW,
> rather than waiting for dpm_complete() to re-allow runtime PM
> transitions, what about allowing them after dpm_suspend()?  I haven't
> actually tested this yet, since I'm busy with getting OMAP PM stuff
> ready for the merge window, so it's just and idea so far.  Of course
> similar will be needed to block runtime PM transitions during
> dpm_resume().  

That would defeat the purpose.  We need to prevent unwanted state
changes during the entire sleep transition, not just during the time 
that dpm_suspend is running.

Alan Stern
