From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 23:47:41 +0100
Message-ID: <20090216224741.GE1370__7757.67617528817$1234824623$gmane$org@ucw.cz>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org> <adad4di7vef.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <adad4di7vef.fsf@cisco.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2009-02-15 22:23:04, Roland Dreier wrote:
>  > > (2) put given subset of devices into low power states whenever they
>  > > are not used, without putting the entire system into a sleep state.
> 
>  > For (2), for me the answer is very obvious:
> 
>  > The Device Driver needs to make the decision to put the device to sleep.
>  > There are no ifs and buts about this.
> 
> For PC-like systems this is probably all that needs to be said.  However
> for highly integrated SoC systems (as Android is obviously targeting)
> there is another level of complexity due to the interdependency among
> various devices... eg things like if I know the SD controller and the
> wifi chip are both asleep then I can put my SDIO controller to sleep;
> and if the SDIO controller and the NAND controller are both asleep then
> I can stop clock X and save more power; etc etc.
> 
> This is what the PowerOp/DPM work was all about.  Unfortunately that
> doesn't seem to have made much progress upstream.  But there's no doubt
> in my mind that we need some framework beyond individual drivers that
> manages the system's power as a whole.  And the current device tree is
> probably not sufficient -- eg the bus hierarchy of a device may not
> match up with the clock tree at all.

Well, that's why clock framework exists. But none  of this is visible
to userland. 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
