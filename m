From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 16:28:51 +0200
Message-ID: <1274970531.27810.5024.camel__48082.2870777503$1274970585$gmane$org@twins>
References: <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<20100526120242.5c9b73ad@schatten.dmk.lab>
	<AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	<20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	<AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527140655.GA28048@srcf.ucam.org>
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
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-27 at 15:06 +0100, Matthew Garrett wrote:

> I don't entirely see how this works. In order to deal with poorly 
> written applications, it's necessary to (optionally, based on some 
> policy) ignore them when it comes to the scheduler. The problem is how 
> to implement the optional nature of this in a race-free manner. This is 
> obviously a pathological case, but imagine an application that does 
> something along the following lines:
> 
> int input = open ("/dev/input", O_RDONLY|O_NONBLOCK);
> char foo;
> 
> while (1) {
> 	suspend_block();
> 	if (read(input, &foo, 1) > 0) {
> 		(do something)
> 		suspend_unblock();
> 	} else {
> 		suspend_unblock();
> 		(draw bouncing cows and clouds and tractor beams briefly)
> 	}
> }
> 
> Now, if the user is playing this game, you want it to be scheduled. If 
> the user has put down their phone and the screen lock has kicked in, you 
> don't want it to be scheduled. So we could imagine some sort of cgroup 
> that contains untrusted tasks - when the session is active we set a flag 
> one way which indicates to the scheduler that tasks in TASK_RUNNING 
> should be scheduled, and when the session is idle we set the flag the 
> other way and all processes in that cgroup get shifted to 
> TASK_INTERRUPTIBLE or something.

What's wrong with simply making the phone beep loudly and displaying:
bouncing cows is preventing your phone from sleeping!
