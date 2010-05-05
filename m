From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 11:35:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051133210.1885-100000__24433.6116513752$1273073838$gmane$org@iolanthe.rowland.org>
References: <20100504235644.GA5231@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504235644.GA5231@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Mark Brown wrote:

> Now, the solution here if we're going to use opportunistic suspend like
> this is to provide some method for the audio subsystem to figure out
> that the system doesn't actually want it to suspend when it gets told do
> do so.  Like I say ideally we'd provide some standard interface in the
> PM subsystem for userspace to communicate this to subsystems and drivers
> so that we've got a joined up story when people run into issues in cases
> like this, though obviously if this goes in then we'll have to put in
> something subsystem or driver specific for affected areas.  I know what
> I'd implement generically for audio, but I've held back since the option
> is fairly messy when not used in conjunction with a deliberate choice to
> use opportunistic suspend and I was expecting a standard mechanism to
> slot into to provide control for userspace.
> 
> In other words, the issue is that we run into situations where we need
> an element of suspend control to go along with the opportunistic suspend
> in order to allow some elements to be kept running - since suspend
> blocking is taken suspend suppression seems like a reasonable term.

Android must already include some solution to this problem.  Why not 
use that solution more generally?

Alan Stern
