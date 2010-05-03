From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 3 May 2010 22:50:28 +0100
Message-ID: <20100503215028.GB18910__41770.9361332983$1272923898$gmane$org@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wrvl5479.fsf@deeprootsystems.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 03, 2010 at 09:40:26AM -0700, Kevin Hilman wrote:

> In my view, the truly significant difference between suspend blockers
> and runtime PM is what happens to userspace.  So far, to me the only
> compelling argument for suspend blockers is the goal of forcibly
> shutting down userspace and thus forcing the system into idle
> (although drivers could still reject a suspend request.)

I'd say that this is certainly the main issue, though the remaining 
periodic timers in the kernel are also inconvenient.

> And if untrusted userspace apps remain as the major problem, maybe we
> should aim for a solution directly targetting that problem.  I'm just
> shooting from the hip now, but maybe containing (cgroups?) untrusted
> processes together into a set that could be frozen/idled so that runtime PM
> would be more effective would be a workable solution?

I considered this. The problem is that not all of your wakeup events 
pass through trusted code. Assume we've used a freezer cgroup and the 
applications are now frozen. One of them is blocking on a network 
socket. A packet arrives and triggers a wakeup of the hardware. How do 
we unfreeze the userspace app?

I agree that the runtime scenario is a far more appealing one from an 
aesthetic standpoint, but so far we don't have a very compelling 
argument for dealing with the starting and stopping of userspace. The 
use-cases that Google have provided are valid and they have an 
implementation that addresses them, and while we're unable to provide an 
alternative that provides the same level of functionality I think we're 
in a poor position to prevent this from going in.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
