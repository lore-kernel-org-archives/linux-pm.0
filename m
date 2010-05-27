From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 21:53:47 +0100
Message-ID: <20100527215347.431c4934__37007.9703200192$1274993270$gmane$org@lxorguk.ukuu.org.uk>
References: <20100527160714.GB31937@srcf.ucam.org>
	<20100527174131.18fd1c72@lxorguk.ukuu.org.uk>
	<20100527165210.GA1062@srcf.ucam.org>
	<20100527190204.14546caa@lxorguk.ukuu.org.uk>
	<20100527181239.GF3543@srcf.ucam.org>
	<20100527194840.5bca973f@lxorguk.ukuu.org.uk>
	<20100527185658.GA5703@srcf.ucam.org>
	<20100527202538.7d2d7f3c@lxorguk.ukuu.org.uk>
	<20100527192926.GA6977@srcf.ucam.org>
	<20100527205333.676ad65e@lxorguk.ukuu.org.uk>
	<20100527201155.GB7449@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527201155.GB7449@srcf.ucam.org>
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

> > The event was not lost.
> 
> Not lost, but not delivered. So you need your policy agent to send 

it will be delivered next time the process wakes. It's not lost.

> SIGCONT when you receive any wakeup event, which either means proxying 
> all your network traffic through your policy agent or having some 
> mechanism for alerting the policy agent whenever you leave the deep idle 
> state.

You didn't mention that requirement last time.

> > > also the race of an application being in the middle of handling a wakeup 
> > > event when you send it the signal.
> > 
> > sigmask()
> 
> Doesn't help - I may be hit by the signal between the poll() unblocking 
> and me having the opportunity to call sigmask().

ppoll(). This is all existing solved stuff.

Alan
