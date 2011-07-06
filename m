From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/5 v1] PM / Domains: Generic PM domains
	improvements
Date: Wed, 6 Jul 2011 14:08:56 -0700
Message-ID: <20110706210856.GA1215__9496.94125815785$1309986919$gmane$org@suse.de>
References: <201107062248.35586.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107062248.35586.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 06, 2011 at 10:48:35PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> For the last few days I've been working on modifications of the generic
> PM domains code allowing .start_device()/.stop_device() and drivers'
> .runtime_suspend()/.runtime_resume() callbacks to execute things like
> pm_runtime_resume() for other devices in the same PM domain safely
> without deadlocking (the original motivation was a console driver on
> shmobile that pm_runtime_get_*()/pm_runtime_put_*() are called for from
> the other devices' .runtime_suspend()/.runtime_resume() callbacks).
> 
> I think I solved that problem, but in the process I found a few places
> where fixes and/on improvements were necessary.  The patches in this
> series address those issues.  They are on top of the branch at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains
> 
> Patches [1-2/5] are regarded as 3.1 material, the others not necessarily,
> but I'd like to push them for 3.1 too if there are no complaints.

No complaints from me, looks nice.

greg k-h
