From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 11:54:40 -0700
Message-ID: <87k4r24avj.fsf__25757.6356911615$1274122661$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<87hbm6cz90.fsf@deeprootsystems.com>
	<1274115885.4418.59.camel@mulgrave.site>
	<20100517174647.GA11512@gandalf>
	<1274119179.4418.68.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274119179.4418.68.camel@mulgrave.site> (James Bottomley's
	message of "Mon\, 17 May 2010 13\:59\:39 -0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>, me@felipebalbi.com, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

James Bottomley <James.Bottomley@suse.de> writes:

> The technical reason for wanting suspend blockers (as has been stated
> more times than I can be bothered to go back and count) is that no-one
> can currently produce a working model for race free kernel to user work
> handoff

At least I've never heard this technial reason stated so succinctly.  It's
not in the changelogs or in the Documentation file included.

The way I undertand things, today's mainline kernel has a race-free
kernel-to-user work handoff already.

The possibility of races is introduced by the opportunistic suspend
feature itself (patch 1.)  The use of suspend blockers later in the
series is needed to avoid the potential races introduced by
opportunistic suspend.

Kevin
