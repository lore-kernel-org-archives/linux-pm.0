From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 00:41:35 +0100
Message-ID: <200902090041.36163.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090208140404.GA22084@bulgaria.corp.google.com>
	<20090208210658.GF6369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208210658.GF6369@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> Hi!
> 
> 
> > Being in suspend, where periodic user and kernel timers aren't running,
> > and random userspace threads aren't possibly spinning, rather than just 
> > being in idle in the lowest power possible state, represent a pretty 
> > significant power savings.
> 
> If kernel timers fire too often, fix them. If user land spins, fix it,
> or SIGSTOP.
> 
> And yes, autosleep is useful. That's why I done those "sleepy linux"
> patches.

I agree, it is.  Still, I don't think the wakelocks in the proposed form are
the right way to implement it.

Thanks,
Rafael
