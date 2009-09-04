From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: Montreal Linux Power Management Mini-Summit, July 13,
 2009 -  Meeting Notes
Date: Fri, 04 Sep 2009 09:34:38 +0200
Message-ID: <4AA0C30E.4080908@st.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>
	<20090902215832.GB21292@n2100.arm.linux.org.uk>
	<4A9FD7C7.7070301@st.com>
	<20090903171213.GB9507@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090903171213.GB9507@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Linux Power Management List <linux-pm@lists.osdl.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Russel.
Thanks for your feedback.

I know several point are already covered by other cf implementation.
And I didn't create a new API... I use the same API linux already has.
> Point 4 is something that OMAP might be able to use, though OMAP already
> does this within its clk API implementation without notification of
> drivers - the clock rates are driven by drivers requesting rates for
> their own clocks rather than one driver influencing the clock rate for
> another.
>    
This is the major feature of cf ( without this point the cf is just an other
  cf...)... Moreover it's required when clocks are shared resource....
If each device has its own clock... than also this feature isn't really 
important
  because each driver can manage its own clock.

Basically the cf manages each clock operation (enable/disable/set_rate),
  as a transaction with several states.

During the transaction all the clock frequencies are evaluated (before
  the real change) and all the devices can check if they agree the new
  clock rate.
Moreover this is done also in hierarchical manner (i.e.: if you change
  a PLL which several clock child).
Basically the clock propagation involves both clocks and devices.

Regards
  Francesco
