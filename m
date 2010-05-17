From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 18:58:20 +0100
Message-ID: <20100517175820.GA29773__23498.3896640644$1274119464$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<87hbm6cz90.fsf@deeprootsystems.com>
	<1274115885.4418.59.camel@mulgrave.site>
	<20100517174647.GA11512@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100517174647.GA11512@gandalf>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 17, 2010 at 08:47:31PM +0300, Felipe Balbi wrote:

> IMO the real fix would be on that particular poll(), changing the
> timeout e.g. based on cpufreq notifications or even relying completely
> on IRQs with poll(pdfs, ARRAY_SIZE(pfds), -1); Of course, this is only a
> crude example trying to show that the real issue lies on the application
> rather than on kernel.

We know that this problem is mostly uninteresting if your userland is 
well written. The sad truth is that it's impossible to trust that your 
userland is well written, and broadly impossible to communicate to users 
that the reason that their battery life is miserable is because of the 
applications and not because of the platform. If you don't believe that 
that's a worthwhile use case to deal with then suspend blockers buy you 
pretty much nothing. But if you do, then nobody's yet demonstrated 
another workable way for this to be handled.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
