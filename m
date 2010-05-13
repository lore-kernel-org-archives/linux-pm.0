From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:34:55 -0700
Message-ID: <20100513213455.GK3428__21754.7023356476$1273786668$gmane$org@atomide.com>
References: <20100513191717.GA3428@atomide.com>
	<20100513192522.GA19256@srcf.ucam.org>
	<20100513194205.GC3428@atomide.com>
	<20100513195349.GB19722@srcf.ucam.org>
	<20100513200003.GE3428@atomide.com>
	<20100513200814.GA20254@srcf.ucam.org>
	<20100513202320.GF3428@atomide.com>
	<20100513203412.GA21244@srcf.ucam.org>
	<20100513211006.GG3428@atomide.com>
	<20100513212108.GA22103@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100513212108.GA22103@srcf.ucam.org>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100513 14:16]:
> On Thu, May 13, 2010 at 02:10:06PM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100513 13:29]:
> > > And if that's the application that's listening to the network socket 
> > > that you want to get a wakeup event from? This problem is hard. I'd love 
> > > there to be an elegant solution based on using the scheduler, but I 
> > > really don't know what it is.
> > 
> > Your system should wake up to an interrupt in that case. Then you have
> > the trusted apps running that can decide if the untrusted apps should
> > be continued or not.
> 
> What race-free mechanism do you use to ensure that? It's very easy to 
> handwave these problems away. It's very difficult to actually write an 
> implementation that works.

Can you describe where do you see the race now?

Your trusted apps should be have in quite a normal way except the system
suspends if no critical timers are on the list. For the untrusted apps
you assume you can stop them at whatever userspace policy you set.

Regards,

Tony
