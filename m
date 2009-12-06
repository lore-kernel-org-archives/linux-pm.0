From: Philippe De Muyter <phdm@macqel.be>
Subject: apm/pm bug [was Re: tulip : kernel BUG in
	tulip_up/tulip_resume]
Date: Sun, 6 Dec 2009 18:10:57 +0100
Message-ID: <20091206171057.GA4363__30443.0366996259$1260202962$gmane$org@frolo.macqel>
References: <20091108223305.GA21072@frolo.macqel>
	<20091129001710.GA4055@ami.dom.local>
	<20091129113659.GA2971@ami.dom.local>
	<20091202.222526.237239384.davem@davemloft.net>
	<20091203084742.GA23867@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091203084742.GA23867@frolo.macqel>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kyle@mcmartin.ca, linux-pm@lists.linux-foundation.org, linux-laptop@vger.kernel.org, grundler@parisc-linux.org, jarkao2@gmail.com
List-Id: linux-pm@vger.kernel.org

[CCing linux-laptop@vger.kernel.org and linux-pm@lists.linux-foundation.org]

On Thu, Dec 03, 2009 at 09:47:42AM +0100, Philippe De Muyter wrote:
> Hi Jarek and David,
> On Wed, Dec 02, 2009 at 10:25:26PM -0800, David Miller wrote:
> > From: Jarek Poplawski <jarkao2@gmail.com>
> > Date: Sun, 29 Nov 2009 12:36:59 +0100
> > 
> > > On Sun, Nov 29, 2009 at 01:17:10AM +0100, Jarek Poplawski wrote:
> > >> Philippe De Muyter wrote, On 11/08/2009 11:33 PM:
> > >> > Does someone know what could be wrong and have a fix or should I look myself ?
> > >> 
> > >> Don't know, guess only...
> > > 
> > > ...And maybe a second guess btw. (to try together or separate).
> > 
> > Philippe please test Jarek's patches.
> 
> Busy doing that. I had some problems trying to activate apm's debug.
> Will report later.

The problem seems not to be in tulip driver, but in apm or power management.
I see, with some debugging added by me :

[  488.585707] eth0: Digital DS21142/43 Tulip rev 17 at Port 0xec00, 00:00:f8:02:cf:08, IRQ 11.
[  508.888374] eth0: 21143 10baseT link beat good.
[  530.754453] apm: BIOS version 1.1 Flags 0x03 (Driver version 1.16ac)
[  530.754723] apm: entry f690:7ca cseg16 f690 dseg 40 cseg len ffff, dseg len ffff
[  531.016684] apm: Connection version 1.1
[  531.018853] apm: AC on line, battery status unknown, battery life unknown
[  531.028277] apm: battery flag 0x80, battery life unknown
[  864.060751] apm: received system standby notify
[  864.063111] check_events : calling standby()
[ 1141.088550] apm: received system standby resume notify
[ 1141.090195] check_events : calling dpm_resume_end(PMSG_RESUME)
[ 1141.096173] tulip_resume

I do not see there a call to tulip_suspend after the call to standby(),
but I think there should be one.

Philippe
