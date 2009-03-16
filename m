From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [v3 PATCH 3/4] timers: /proc/sys sysctl hook to
	enable timer	migration
Date: Mon, 16 Mar 2009 18:29:56 +0300
Message-ID: <20090316152956.GA2344__12138.5187296712$1237246157$gmane$org@x200.localdomain>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111444.GD4686@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090316111444.GD4686@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 16, 2009 at 04:44:44PM +0530, Arun R Bharadwaj wrote:
> echo 0 > /proc/sys/kernel/timer_migration

There should be no sysctl for this.

Timer migration should be good enough to be always enabled.
