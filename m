From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:02:04 +0100
Message-ID: <20100527190204.14546caa__22377.9030530297$1274983608$gmane$org@lxorguk.ukuu.org.uk>
References: <20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	<AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<20100527160543.2228fc17@lxorguk.ukuu.org.uk>
	<20100527160714.GB31937@srcf.ucam.org>
	<20100527174131.18fd1c72@lxorguk.ukuu.org.uk>
	<20100527165210.GA1062@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527165210.GA1062@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, felipe.balbi@nokia.com, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> network packet arrives. The difference between these scenarios is large.

Your application seems to change desired outcome every email. Sorry but
you need to explicitly explain and define a policy in full that we can
test ideas against. Otherwise this is useless.

> > If you have wake-on-lan then the network stack might be smarter and
> > choose to express itself as
> > 
> > 	'the constraint is C6 unless the input queue is empty in which
> > 	 case suspend is ok as I have WoL and my network routing is such
> > 	 that I can prove that interface will be used'
> 
> This is still racy. Going back to this:
> 
> int input = socket(AF_INET, SOCK_STREAM|SOCK_NONBLOCK, 0);
> char foo;
> struct sockaddr addr;
> connect (input, &addr, sizeof(addr))
> while (1) {
>        if (read(input, &foo, 1) > 0) {
>                (do something)
>        } else {
> 		* SUSPEND OCCURS HERE *

Fine but then the packet will arrive and we will wake back up process the
packet and wake the task. See suspend is just like a deep sleep. If we
went to sleep there and the packet arrival doesn't rewake the box the
driver was buggy.

> reaches the end of its timeslice. At this point the application has not 
> had an opportunity to indicate in any way whether or not the packet has 
> altered its constraints in any way. What stops us from immediately 
> suspending again?

If my app level constraint before the packet is 'don't suspend' then my
constraint on receipt is 'don't suspend' so I won't suspend. If my
constraint is then lowered and I suspend I will suspend *after* the
lowering.

If my constraint is tightened then the decision to tighten is run under
the previous constraint. Which is fine, because if I have a case where I
must tighten my constraint within the tight constraint time I've screwed
up my app and need to fix it.

In reality almost all your userspace is going to look like 'trusted app'
or 'untrusted app' in droidthink and won't be transitioning in user space
(but may well be adding/losing kernel constraints)

This is good because it's another thing app authors don't have to care
about. It's good because apps can be run trusted/untrusted without
recompiling.

Alan
