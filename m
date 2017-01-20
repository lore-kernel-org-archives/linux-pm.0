From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 09:53:07 -0800
Message-ID: <20170120175307.GA6005@roeck-us.net>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
 <20170120083804.GF4894@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120083804.GF4894@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 20, 2017 at 09:38:04AM +0100, Thierry Reding wrote:
> > 
> > > No such thing exists for poweroff. Guenter also wrote something for
> > > that [1], but Linus intervened [2]. Anyways, pm_power_off is at
> > > least architecture independent.
> > > 
> > That was by far the most frustrating kernel development experience
> > I ever head :-(.
> 
> It was a little difficult to track down all the discussion around this,
> but reading through what I could find, I can understand why this would
> have been frustrating. You obviously spent an enormous amount of work
> only to get it shot down.
> 
> I have to say that I have similar concerns to those voiced by Linus and
> Rafael. Notifier chains and priority seem too little restrictive for
> this kind of functionality, in my opinion. I think those concerns could
> be removed if things got formalized using a framework.
> 

Exactly the same argument applies to the restart handler. I am just glad
I got it in before the objections came up.

I do understand the concerns, which is why I tried to accommodate them
and come up with another solution. However, it boils down to the following:

- Priorities are needed, no matter how they are called.
- Data structures have to be allocated statically, since the code
  still needs to work if the system is out of memory.
- Data structurs need to be maintained in a prioritized list or similar,
  to be able to handle insertions and removals at will, and to be able
  to determine which function should be called first.

So ultimately, no matter what you do, you'll end up re-implementing
parts of the notifier code.

To me the argument, ultimately, boils down to arguing with Amazon that they
should always use the smallest possible packaging (and not ship flash drives
in such a large box that it is hard to find). Just like Amazon has good reasons
to standardize on a limited number of box sizes, an argument can be made to
have only a limited amount of infrastructure code. If some infrastructure code
is "too little restrictive", but does the job, so be it. That should not be
a reason to have separate and highly specialized infrastructure for everything,
just to make it a 100% fit.

That is, however, my personal opinion. If people want to have and implement
a large amount of highly specialized infrastructure instead of more generic
(and less restrictive) infrastructure, so be it. Just don't expect _me_
to implement it.

> Without having spent the amount of time on the topic that you have, the
> following straw-man proposal is perhaps a little naive:
> 
> 	struct system_power_controller;
> 
> 	struct system_power_ops {
> 		int (*power_off)(struct system_power_controller *spc);
> 		int (*restart)(struct system_power_controller *spc,
> 			       enum reboot_mode mode,
> 			       const char *cmd);
> 	};
> 
> 	struct system_power_controller {
> 		struct device *dev;
> 		const struct system_power_ops *ops;
> 		struct list_head list;
> 		...
> 	};
> 
> 	int system_power_controller_add(struct system_power_controller *spc);
> 	void system_power_controller_remove(struct system_power_controller *spc);
> 
> 	int system_power_off(void);
> 	int system_restart(enum reboot_mode mode, const char *cmd);
> 
It seems to me that restart and power off are inherently independent of each
other. I would personally not try to unify them. Having said that, that is my
personal opinion only. I would for sure not object to anything in this area
(nor get involved - once was enough ;-).

Thanks,
Guenter
