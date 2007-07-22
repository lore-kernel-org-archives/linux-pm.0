From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 16:09:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707221608140.16031-100000__31306.0811757625$1185135082$gmane$org@netrider.rowland.org>
References: <E1ICeHX-00025u-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICeHX-00025u-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: david@lang.hm, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Miklos Szeredi wrote:

> > The only thing to do is what Rafael has been working on: unfreeze
> > things, hope the tasks sort themselves out, and try again.
> 
> Have we some proof, that this will untangle the freezing tasks in a
> limited time?  Or will it just make the problem harder to trigger?

Of course there's no proof.  Just the opposite -- if things get hung up
the first time, they might get hung up the second time.  And the
third...

But it ought to make the problem harder to trigger.  For the present 
that's a worthwhile improvement.

Alan Stern
