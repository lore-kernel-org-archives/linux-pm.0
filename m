From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 11 May 2010 18:03:48 +0100
Message-ID: <20100511170348.GA17443__14904.5104546987$1273597492$gmane$org@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<87632vhbs8.fsf@deeprootsystems.com>
	<201005102225.52431.rjw@sisk.pl>
	<20100511161227.GD13600@atomide.com>
	<20100511161448.GA16148@srcf.ucam.org>
	<20100511163632.GE13600@atomide.com>
	<20100511164554.GA17016@srcf.ucam.org>
	<20100511165821.GA13931@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100511165821.GA13931@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 11, 2010 at 09:58:21AM -0700, Tony Lindgren wrote:
> * Matthew Garrett <mjg@redhat.com> [100511 09:41]:
> > Yes. You still need suspend blocks.
> 
> Maybe not if echo opportunistic > /sys/power/policy gets cleared by
> the kernel if the kernel idle loop can't make it. That means something
> has blocked the suspend attempt in a driver for example. The system
> keeps running, and the userspace can deal with the situation.

So an event arrives just as userspace does this write. How do you avoid 
the race? Plausible answers mostly appear to end up looking like suspend 
blockers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
