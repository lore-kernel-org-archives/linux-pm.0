From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Thu, 10 Jul 2008 09:40:09 -0500
Message-ID: <20080710144009.GA8619__34307.308929465$1215704786$gmane$org@us.ibm.com>
References: <20080707225823.502032693@us.ibm.com>
	<20080708123150.3034d83f.kamezawa.hiroyu@jp.fujitsu.com>
	<1215545954.9023.120.camel@localhost.localdomain>
	<6599ad830807081306l61622eadk215a25d02ee94b00@mail.gmail.com>
	<6599ad830807081307j811689aldf0f6cb38579c450@mail.gmail.com>
	<1215640723.7149.35.camel@localhost.localdomain>
	<20080710094231.58d9e1b9.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080710094231.58d9e1b9.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Quoting KAMEZAWA Hiroyuki (kamezawa.hiroyu@jp.fujitsu.com):
> On Wed, 09 Jul 2008 14:58:43 -0700
> Matt Helsley <matthltc@us.ibm.com> wrote:
> 
> > 
> > On Tue, 2008-07-08 at 13:07 -0700, Paul Menage wrote:
> > > On Tue, Jul 8, 2008 at 1:06 PM, Paul Menage <menage@google.com> wrote:
> > > > On Tue, Jul 8, 2008 at 12:39 PM, Matt Helsley <matthltc@us.ibm.com> wrote:
> > > >>
> > > >> One is to try and disallow users from moving frozen tasks. That doesn't
> > > >> seem like a good approach since it would require a new cgroups interface
> > > >> "can_detach()".
> > > >
> > > > Detaching from the old cgroup happens at the same time as attaching to
> > > > the new cgroup, so can_attach() would work here.
> > 
> > Update: I've made a patch implementing this. However it might be better
> > to just modify attach() to thaw the moving task rather than disallow
> > moving the frozen task. Serge, Cedric, Kame-san, do you have any
> > thoughts on which is more useful and/or intuitive?
> > 
> 
> Thank you for explanation in previous mail.
> 
> Hmm, just thawing seems atractive but it will confuse people (I think).
> 
> I think some kind of process-group is freezed by this freezer and "moving
> freezed task" is wrong(unexpected) operation in general.  And there will
> be no demand to do that from users.
> I think just taking "moving freezed task" as error-operation and returning
> -EBUSY is better.
> 
> Thanks,
> -Kame

I'm torn.  Allowing the moves is kind of cool, but I think I agree that
we should start out with the simpler semantics, which in this case is
disallowing the move.  The race Li may have found will only become more
complicated when both sides of the race can change the task's frozen
state.

-serge
