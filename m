From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 13:35:15 +0100
Message-ID: <20100806123515.GF31326__778.752569067542$1281098276$gmane$org@sirena.org.uk>
References: <AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<AANLkTimWqFkDWvGwVGWD94488gs+CXgpB9juwM5G11ud@mail.gmail.com>
	<alpine.DEB.2.00.1008060106260.30564@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008060106260.30564@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 06, 2010 at 01:07:47AM -0700, david@lang.hm wrote:

> on a given piece of hardware, does suspend always leave the same  
> peripherals on, or do you sometimes power more things down than other  
> times when suspending?

Different bits of hardware get powered down depending on current system
state.  In the audio case (which is so far as I know the only case for
this sort of stuff that currently does anything in mainline) we'll keep
alive any active paths (that is, paths carrying live audio) between
endpoints in the audio subsystem which have been explicitly marked as
staying alive during suspend.  Other audio paths will be powered down
when the system suspends.  During normal run time only paths that are
active will be powered up.
