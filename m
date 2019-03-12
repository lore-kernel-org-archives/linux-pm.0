From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Date: Tue, 12 Mar 2019 17:11:47 +0530
Message-ID: <20190312114147.emnt4ed4gpnyibyo@vireshk-i7>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan>
 <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
 <20190312090430.GA28905@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312090430.GA28905@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com, yuwei3@hisilicon.com, gengyanping@hisilicon.com, peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12-03-19, 10:04, Pavel Machek wrote:
> On Tue 2019-03-12 08:58:02, Viresh Kumar wrote:
> > On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> > > On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > > > wakeup_source_remove() is the counterpart of wakeup_source_add() helper
> > > > and must undo the initializations done by wakeup_source_add(). Currently
> > > > the timer is initialized by wakeup_source_add() but removed from
> > > > wakeup_source_drop(), which doesn't look logically correct. Also it
> > > > should be okay to call wakeup_source_add() right after calling
> > > > wakeup_source_remove(), and in that case we may end up calling
> > > > timer_setup() for a potentially scheduled timer which is surely
> > > > incorrect.
> > > > 
> > > > Move the timer removal part to wakeup_source_remove() instead.
> 
> > > 
> > > I've merged it with the [2/2], rewritten the subject and changelog and
> > > queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> > > source timer cancellation").
> > 
> > Okay, thanks. We (Android guys) want this to be backported into 4.4+
> > kernels via the stable tree. Can we mark this for stable in the commit
> > itself ? Else I would be required to send this separately for all the
> > kernels. I should have marked it for stable initially though, sorry
> > about forgetting then.
> 
> Greg is normally pretty agressive about backporting everything
> remotely looking like a fix...
> 
> But better changelog would help. How is the bug actually affecting
> users?

The Android wakelock infrastructure (not in mainline) is based on the
wakeup sources stuff and that is where we found the issue. A wakelock
was taken due to a bug in user driver and the board never attempts
going into suspend anymore.

If this patch doesn't go into the stable kernels, I would be required
to send this separately for Android kernels and the Android guys will
suggest getting it via stable tree.

And because this fixes a potential issue it was worth trying getting
it via the stable kernel :)

-- 
viresh
