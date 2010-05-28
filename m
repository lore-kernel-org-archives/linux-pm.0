From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:26:41 +0300
Message-ID: <4BFFB681.1000105__1487.24216637692$1275048359$gmane$org@nokia.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528114123.GA22947@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

ext Matthew Garrett wrote:

> On Fri, May 28, 2010 at 10:37:13AM +0100, Alan Cox wrote:
>
>   
>> The other vendors appear to be managing nicely without magic blockers. I
>> conjecture therefore there are other solutions.
>>     
>
> Actually, no. A badly behaved application will kill the N900's battery 
> life. Nobody else has "managed nicely" - they've just made life harder 
> for application developers and users, which may have something to do 
> with the relative levels of market adoption of Maemo and Android. I'm 
> not aware of any form of resource management framework in MeeGo either, 
> so as far as I know it'll have exactly the same problem.
>
>   
It's true that a braindead app can kill the battery.

However we provide a version of powertop that is tailored to the N900, 
there is a nokia energy profiler meant to give graphical representation 
of the battery current, there is htop available and you can even get the 
processor activity visualized on the leftmost and rightmost keyboard 
backlight LEDS, when in RD mode and with screen blanked.

I would advice you to not start debating on company strategies, this is 
not the right place.

Otherwise I'll have to ask what's the expected threshold of devices sold 
with broken sw design to get automatic admission into the mainline 
kernel source tree.

But this is not the direction we want to take.

Notice also that we _do_ have a store and official repository where apps 
are monitored for sanity, also with feedback from users and their help 
to promote new apps to trusted state.

Former Maemo 6, now MeeGo do introduce resource management from security 
POV, but that will also have the side effect of discriminating between 
signers.

igor
