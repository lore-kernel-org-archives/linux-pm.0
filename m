From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Syncthreads support.
Date: Fri, 22 Jul 2005 13:21:35 +1000
Message-ID: <1122002495.3030.37.camel@localhost>
References: <1121923564.2936.231.camel@localhost>
	<Pine.LNX.4.50.0507211254140.12779-100000@monsoon.he.net>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============099471665835143774=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0507211254140.12779-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============099471665835143774==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Fri, 2005-07-22 at 06:05, Patrick Mochel wrote:
> On Thu, 21 Jul 2005, Nigel Cunningham wrote:
> 
> > This patch implements a new PF_SYNCTHREAD flag, which allows upcoming
> > the refrigerator implementation to know that a thread is syncing data to
> > disk. This allows the refrigerator to be more reliable, even under heavy
> > load, because it can separate userspace processes that are submitting
> > I/O from those trying to sync it and freezing the former first. We can
> > thus ensure that syncing processes complete their work more quickly and
> > the refrigerator is far less likely to incorrectly give up (thinking a
> > syncing process is completely failing to enter the refrigerator).
> 
> I don't have any strong feelings for this, one way or another. It seems
> kinda hacky, and it needs to be discussed publically, and it seems like it
> definitely seems like it doesn't need to go in immediately.

I'm concerned about reducing the potential data loss (if the user
doesn't resume) to nil, so I'd argue that it's important.

> I have just a couple of suggestions below..
> 
> >  int fsync_super(struct super_block *sb)
> >  {
> > +	int ret;
> > +
> > +	/* A safety net. During suspend, we might overwrite
> > +	 * memory containing filesystem info. We don't then
> > +	 * want to sync it to disk. */
> > +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> 
> Please do not add any new BUG()s. Figure out another way to gracefully
> fail, perhaps some place else.

In the case of Suspend2, if we let the call continue, we are potentially
overwriting valid data. I think that's important enough for a BUG_ON. I
don't add them lightly!

> > +	current->flags |= PF_SYNCTHREAD;
> 
> Is all the modification of current->flags safe? It seems like you could be
> pre-empted in the middle and things could get wacky.

In the middle of setting the flag or in the middle of the routine? If
we're preempted prior to setting the flag, get refrigerated and don't
continue with the call until post resume (can this happen?), it won't
matter.

> Another note is that these changes will have to go through Al Viro, who
> might have some suggestions on the Right(tm) way to do it.

Ok. I'll wait to see the feedback from Greg before sending to Al.
Hopefully he'll either convince me I'm wrong or tell Pavel he's wrong.
Whatever the case, if Greg says no, I'll not bother anymore with
submitting it - even if I still disagree.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============099471665835143774==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============099471665835143774==--
