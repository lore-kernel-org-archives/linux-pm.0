From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 14:42:09 +0100
Message-ID: <200711181442.09917.rjw__13544.6287728429$1195392373$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
	<4740332A.80002@gmail.com> <474038C9.3040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <474038C9.3040002@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 18 of November 2007, Jiri Slaby wrote:
> On 11/18/2007 01:42 PM, Jiri Slaby wrote:
> > See shot of prints here:
> > http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png
> 
> BTW output from that tree minus the patch:

Hm, it looks like one of the CPU hotplug notifiers is doing something wrong.

Can you try to see what happens (with the patch applied) if
thermal_throttle_cpu_callback() is not registered?

> _cpu_down: s
> _cpu_down: t
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> _cpu_down: u
> notifier_call_chain: c FFFFFFFF80232370 1
> notifier_call_chain: c FFFFFFFF8026EF10 1
> notifier_call_chain: c FFFFFFFF8024B8F0 1
> notifier_call_chain: c FFFFFFFF802419E0 1
> notifier_call_chain: c FFFFFFFF80255B50 1
> notifier_call_chain: c FFFFFFFF80250C40 1
> notifier_call_chain: c FFFFFFFF8028E8F0 1
> notifier_call_chain: c FFFFFFFF802B59C0 1
> notifier_call_chain: c FFFFFFFF80323460 1
> notifier_call_chain: c FFFFFFFF80270990 0
> notifier_call_chain: c FFFFFFFF8023D5D0 1
> notifier_call_chain: c FFFFFFFF80266090 1
> notifier_call_chain: c FFFFFFFF802320A0 1
> notifier_call_chain: c FFFFFFFF80249DA0 1
> notifier_call_chain: c FFFFFFFF80318440 1
> notifier_call_chain: c FFFFFFFF8047BE80 1
> notifier_call_chain: c FFFFFFFF80212F40 0
> notifier_call_chain: c FFFFFFFF80216350 1
> notifier_call_chain: c FFFFFFFF80217220 1
> notifier_call_chain: c FFFFFFFF80218120 1
> _cpu_down: v
> _cpu_down: w
> _cpu_down: x
> _cpu_down: y
> _cpu_down: z
> disable_nonboot_cpus: 3 0
