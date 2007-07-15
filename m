From: Al Boldi <a1426z@gawab.com>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 20:40:28 +0300
Message-ID: <200707152040.28744.a1426z__24703.4113076099$1184521454$gmane$org@gawab.com>
References: <200707151433.34625.rjw@sisk.pl>
	<200707151810.33554.a1426z@gawab.com> <469A3EB9.8000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469A3EB9.8000304@gmail.com>
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
To: jimmy bahuleyan <knight.camelot@gmail.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

jimmy bahuleyan wrote:
> Al Boldi wrote:
> > This should be the responsibility of the kexec'd hibernating kernel. 
> > Note though in (6), the normal kernel takes care of preparing devices,
> > then the hibernating kernel dumps the image and either calls S4 or S3. 
> > On resume from S3 it can immediately switch over to the normal kernel,
> > and from S4 the known bootup would occur.
> >
> >> (8) Hibernation and restore should not be too slow
> >>
> >>     In my opinion, if more than one minute is needed to hibernate the
> >> system with the help of certain hibernation framework, then this
> >> framework is not very useful in practice.  It might be useful to
> >> perform some special tasks (eg. moving a server to another place
> >> without taking it down), but it is not very useful, for example, to
> >> notebook users.
> >
> > The latest hibernating kexec patches boot a kexec'd modular kernel with
> > initramfs into crashkernel=16M@16M in less than one second.  Switch-back
> > is almost instant.  Add to this the time required to either store or
> > restore the image, and it may be obvious that this approach isn't
> > slower, but maybe even faster than the current swsusp.
>
> What about (9)? Would it be that a user choosing to build a kernel with
> hibernate support gets a additional modular kernel built (which he
> should then use for resumption) or he should configure & build the
> modular kernel independent of main kernel?
>
> Or will the Linux boot procedure change so that it always goes thru a
> modular part followed by kexec (just to be uniform)?
>
> Although the kexec approach seems interesting, the final user-scenario
> seems a bit complex (or confusing).

Well, it may sound confusing because it is so unexpectedly simple.  I didn't 
answer to (9) because from a user pov nothing should change, and everything 
should be scriptable such that the user wouldn't even notice the kernel 
using a new hibernation approach.


Thanks!

--
Al
