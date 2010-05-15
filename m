From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Sat, 15 May 2010 17:19:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005151716180.24645-100000__23753.0137332671$1273958558$gmane$org@netrider.rowland.org>
References: <AANLkTinwJdPneNSlAeTml5fHW2LFy53Dz3DRf95y1Bcl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinwJdPneNSlAeTml5fHW2LFy53Dz3DRf95y1Bcl@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 May 2010, Brian Swetland wrote:

> In tickless mode, the time until next timer is a signed int, so the
> longest the kernel will ever sleep is ~2 seconds at a go.  In
> practice, userspace entities often have polling behavior that can
> trigger more often than that, and I've observed some kernel periodic
> timers (haven't cataloged them recently) that happen more often than
> once a second.

Paul and Kevin, how does the OMAP implementation handle these 
difficulties?

Also, how does it handle the issue of ill-behaved apps?

Alan Stern
