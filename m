From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 15:06:17 +0200
Message-ID: <1274879177.27810.386.camel__48684.4040141024$1274879216$gmane$org@twins>
References: <1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<20100526120242.5c9b73ad@schatten.dmk.lab>
	<AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	<20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526122932.GB1990@nokia.com>
	<20100526143323.7c6f8705@schatten.dmk.lab>
	<20100526123532.GA2629@nokia.com>
	<20100526145452.685337db@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526145452.685337db@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-05-26 at 14:54 +0200, Florian Mickler wrote:

> It really comes down to a policy decision by the distribution maker.
> And I don't think kernel upstream should be the one to force one way or
> the other.

That's exactly what we always do. If we were not to do so, the kernel
would be a bloated incoherent piece of crap.

>  So merging this patch set will allow android to continue
> their work _on mainline_ while everybody else can continue as before.

> Nonetheless, I really think the kernel needs to allow for the android
> way of power saving. It misses out on a big feature and a big user-base
> if not.

I really think we should not do so. Let them help in fixing the real
issue instead of creating a new class of userspace that is more
important than another.

> But look at it this way: Suspend blockers are a way for the kernel
> to make user space programs accountable for using the resource "power".

How is userspace without suspend blockers not accountable? We can easily
account runtime and in fact have several ways to do so.
