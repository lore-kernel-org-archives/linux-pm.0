From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 13:52:04 -0800
Message-ID: <20090216135204.064f553b__39747.4540900022$1234825237$gmane$org@infradead.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<Pine.LNX.4.44L0.0902161537080.19732-100000@netrider.rowland.org>
	<20090216124520.315320dc@infradead.org>
	<13B9B4C6EF24D648824FF11BE896716203771DCF1E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203771DCF1E@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Benjamin@smtp1.linux-foundation.org, Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 15:32:06 -0600
"Woodruff, Richard" <r-woodruff2@ti.com> wrote:
> 
> - It provides a way to handle overdrive/turbo operating points out of
> band from the generically tuned cpufreq governors like ondemand.  The
> way we characterize overdrive is stricter then what Intel has talked
> about for x86.

if you have an improved-for-your-systems governor then I'm sure that is
very welcome in the kernel.

I agree that perfect is the enemy of good.

I think just about all of us agree that the final decision needs to be
in the driver (possibly followed by something that gets various device
requests and combines it into hw settings); we're just talking about
what inputs feed into that decision ;)

And for different types of devices that's guaranteed to be different...
and sometimes we'll be hampered by existing interfaces, so we might end
up with hacky stuff.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
