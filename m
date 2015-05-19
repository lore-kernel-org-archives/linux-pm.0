From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Tue, 19 May 2015 09:39:58 +0200
Message-ID: <20150519073958.GD19282@twins.programming.kicks-ass.net>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <20150518093150.GC21418@twins.programming.kicks-ass.net>
 <CA+55aFzx2j-yZH0CgMGJ_uw0KbdqaUanEJPKwdm-yXYaFLhRXw@mail.gmail.com>
 <20150519071259.GA6847@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150519071259.GA6847@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 19, 2015 at 09:12:59AM +0200, Michal Hocko wrote:
> On Mon 18-05-15 10:10:50, Linus Torvalds wrote:
> > On Mon, May 18, 2015 at 2:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > Subject: watchdog: Fix merge 'conflict'
> > >
> > > Two watchdog changes that came through different trees had a non
> > > conflicting conflict, that is, one changed the semantics of a variable
> > > but no actual code conflict happened. So the merge appeared fine, but
> > > the resulting code did not behave as expected.
> > 
> > Ok, I see that people are still discussing this, but I'll apply it
> > as-is since I want to get rc4 out the door, and I guess people can
> > tweak this if there's anything else we want to do longer-term.
> 
> The final patch from Peter has a typo. Without the following the system
> deadlocks obviously:

Duh, sorry about that. :/
