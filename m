From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to disk now broken
Date: Sun, 26 Jul 2009 00:18:03 +0200
Message-ID: <200907260018.03705.rjw__22662.6001102433$1248560395$gmane$org@sisk.pl>
References: <20090712151947.25446ceb.celejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090712151947.25446ceb.celejar@gmail.com>
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
To: Celejar <celejar@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 12 July 2009, Celejar wrote:
> Hi,
> 
> A recent change to the kernel has apparently broken suspend to disk on
> my machine.  It still works fine in 2.6.30.1, but hangs during the
> 'devices' phase of suspension with 2.6.31-rc2.  [I originally saw the
> problem using the wireless-testing git repo, but I've subsequently
> reproduced it using the mainline code from the kernel.org homepage.]  I
> saw a rumor that the problem may have something to do with recent
> changes to the Intel graphics drivers, so  I've tried to remove the
> driver (i915) before suspending, but it won't come out.
> 
> The machine is an Acer Aspire 3690 laptop, with Intel motherboard and
> chipsets and Broadcom networking.  The last message seen on the console
> during the failed suspend is:
> 
> Suspending console(s) (use no_console_suspend to debug)
> 
> The machine has no serial port, but I do have a Prolific USB-serial
> converter; will that be useful?
> 
> I'm attaching the output of 'grep ^C .config', since I assume that it
> contains relevant information.
> 
> Please cc. me on responses.

Well, I guess it's still a problem with 2.6.31-rc4?

Rafael
