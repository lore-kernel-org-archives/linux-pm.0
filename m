From: "Leo L. Schwab" <lschwab@tapwave.com>
Subject: Re: Clock Policy Goes Where?
Date: Fri, 24 Jun 2005 14:26:25 -0700
Message-ID: <42BC7A81.4000307@tapwave.com>
References: <42BB2173.2010101@tapwave.com> <20050624131853.GA29336@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19430109330764767=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050624131853.GA29336@atomide.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============19430109330764767==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

tony@atomide.com wrote:
> Well since they're needed for the system to work, I'd say low-level init
> of clock.c is where they need to be. Otherwise you cannot use clock.c :)
>
	Ah.  I was using arch_initcall() to setup the clocks, which is far too late 
in the boot sequence.  Looking more closely at the OMAP support, I see their 
clocks are initialized as part of the map_io vector in the ARM machine_desc 
structure.  I'll go fix that.

> You probably have all the required clocks on already from bootloader. If
> they need to be on all the time, I guess you could just leave those clocks
> out of the clock.c. But depending on the hardware you may also want to be
> able to idle them.
>
	The Zodiac only has a 1500mAH battery in it, which we want to last as long 
as possible between visits to the cradle, especially when we're, 
"suspended."  So we need to be able to idle/spin down all unused clocks -- 
essentially turn off everything that's not actually in use.

	Thank you very much for taking the time to respond.

					Schwab

--===============19430109330764767==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19430109330764767==--
