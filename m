From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 11 May 2010 09:36:33 -0700
Message-ID: <20100511163632.GE13600__33517.9621157751$1273596043$gmane$org@atomide.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<87632vhbs8.fsf@deeprootsystems.com>
	<201005102225.52431.rjw@sisk.pl>
	<20100511161227.GD13600@atomide.com>
	<20100511161448.GA16148@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100511161448.GA16148@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100511 09:10]:
> On Tue, May 11, 2010 at 09:12:28AM -0700, Tony Lindgren wrote:
> 
> > To me it sounds like this should only be allowed to happen when you do:
> > 
> > # echo 1 > /sys/power/suspend_while_idle
> > 
> > As it kills the timers and leads to non-standard behaviour of the apps
> > as they won't run :)
> > 
> > And then the remaining question is how to make sure the use cases
> > below can be handled in a clean way.
> 
> That's handled by the /sys/power/policy opportunistic/forced switch.

OK, so can the suspend blocker then become just:

# Block suspend while idle, system stays running
# echo default > /sys/power/policy

and the when it's OK to suspend:

# Allow suspend while idle, system suspends when it hits kernel idle loop
# echo opportunistic > /sys/power/policy

or do you still need something more to ensure the data gets into your
app and be handled?

The part I really don't like is the idea of patching all over the drivers
and userspace for the wakelocks/suspendblocks.

Regards,

Tony
