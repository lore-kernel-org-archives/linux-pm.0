From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 10:15:44 +0200
Message-ID: <20050428081544.GF1906@elf.ucw.cz>
References: <1114664707.3580.12.camel@desktop.cunningham.myip.net.au>
	<1114665714.22110.45.camel@sli10-desk.sh.intel.com>
	<1114667366.3580.19.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28896563390431007=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114667366.3580.19.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============28896563390431007==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > > Do you have a particular example in mind? I haven't seen or heard of
> > > any
> > > freezing failures in Suspend2 for ages, so I'm struggling to see what
> > > is
> > > lacking.
> > No, actually. Maybe I should send the proposal till I really find a case
> > :). I only noticed the syslogd case. Somebody reported the
> > 'mdnsresponder' process case, but didn't look at it yet.
> > http://bugme.osdl.org/show_bug.cgi?id=3964
> 
> Ah. Ok. The ipw2100 driver starts a workqueue. Since I also have patches
> to make kthreads freezable, we sometimes have to tell people to add an
> extra parameter to the create_workqueue call. Once that's done, I
> believe it all works fine.
> 
> I keep saying I must seek to merge these patches. I've gotten caught up
> on trying to get everything ready to merge at once, and confused by what
> Pavel is and isn't changing :> Pavel, since you're cc'd I might as well
> ask, am I still right to submit those patches again? If so, I'll try to
> do it this evening.

Yes, I'd like those patches...

> On a related topic, I've tried to get hotplug cpu support working with
> suspending, but it looks like more is needed. In particular, the 'dead'
> cpu still needs state saved and restored, so we're not really gaining
> anything with the current implementation. If hotplug really killed the
> CPU and rebooted it, the story might be different.

It works for me, but you need to play with -mm kernel where neccessary
support is implemented...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============28896563390431007==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28896563390431007==--
