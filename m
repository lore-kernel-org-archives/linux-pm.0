From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 13:52:07 +0100
Message-ID: <200912201352.07689.rjw__23125.4039136276$1261313552$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912192253200.6618-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912192253200.6618-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 December 2009, Alan Stern wrote:
> On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> 
> > So, seriously, do you think it makes sense to do asynchronous suspend at all?
> > I'm asking, because we're likely to get into troubles like this during suspend
> > for other kinds of devices too and without resolving them we won't get any
> > significant speedup from asynchronous suspend.
> > 
> > That said, to me it's definitely worth doing asynchronous resume with the
> > "start asynch threads upfront" modification, as the results of the tests show
> > that quite clearly.  I hope you agree.
> 
> It's too early to come to this sort of conclusion (i.e., that suspend
> and resume react very differently to an asynchronous approach).  Unless
> you have some definite _reason_ for thinking that resume will benefit
> more than suspend, you shouldn't try to generalize so much from tests
> on only two systems.

In fact I have one reason.  Namely, the things that drivers do on suspend and
resume are evidently quite different and on these two systems I was able to
test they apparently took different amounts of time to complete.

The very fact that on both systems resume is substantially longer than suspend,
even if all devices are suspended and resumed synchronously, is quite
interesting.

Rafael
