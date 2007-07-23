From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 10:04:43 +1000
Message-ID: <18083.61595.217126.824924__25272.7759922438$1185149150$gmane$org@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707230842.22121.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707230842.22121.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Nigel Cunningham writes:

> I guess I want to persist because all of these issues aren't utterly
> unsolvable. It's just that we don't have the infrastructure yet to
> figure out the solutions to these issues trivially. Take, for example,

Ever heard of the halting problem? :)  It's not just a matter of
infrastructure.  You very quickly get into questions that are
mathematically undecideable.

> the locking issue. If we could call some function to say "What process
> holds this lock?", then task A could know that it's waiting on task B
> and put that information somewhere. We could then use the information
> to freeze task B before task A.

But how would that help?  If task B holds the lock, then we can't
freeze it until it's released the lock.  Then the question is, what
does task B need in order to get to the point where it releases the
lock?  And so on.  It rapidly gets not just extremely messy, but
actually impossible to compute in general.

Paul.
