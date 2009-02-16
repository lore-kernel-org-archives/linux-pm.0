From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 07:38:10 -0800
Message-ID: <20090216073810.200be4a6__37639.305581297$1234798956$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org> <adad4di7vef.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Brian@smtp1.linux-foundation.org, Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Feb 2009 22:23:04 -0800
Roland Dreier <rdreier@cisco.com> wrote:

>  > > (2) put given subset of devices into low power states whenever
>  > > they are not used, without putting the entire system into a
>  > > sleep state.
> 
>  > For (2), for me the answer is very obvious:
> 
>  > The Device Driver needs to make the decision to put the device to
>  > sleep. There are no ifs and buts about this.
> 
> For PC-like systems this is probably all that needs to be said.
> However for highly integrated SoC systems (as Android is obviously
> targeting) there is another level of complexity due to the
> interdependency among various devices... eg things like if I know the
> SD controller and the wifi chip are both asleep then I can put my
> SDIO controller to sleep; and if the SDIO controller and the NAND
> controller are both asleep then I can stop clock X and save more
> power; etc etc.

This does not change the rules.
The individual drivers still make up the decision of what state their
own block should be in.

What you're talking about is coordination. Some systems do this in
silicon, and others, like you mention, need a small software layer to
do this coordination. Fine. But this doesn't change the fundamentals.

> 
> This is what the PowerOp/DPM work was all about.  Unfortunately that
> doesn't seem to have made much progress upstream. 

PowerOP/DPM were... more or less hampered because they operated in
global "modes". Everyone (including the OMAP guys) has pretty much gone
away from the idea that modes are global. Power management is not
global; if you treat it as global then you're in trouble, since the
decisions really are local (and in better hw, even done in the hw)



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
