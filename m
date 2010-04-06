From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Regulators vis-a-vis Power Domains
Date: Tue, 06 Apr 2010 21:44:00 +0100
Message-ID: <1270586640.3229.72.camel__910.487460396503$1270586806$gmane$org@odin>
References: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6@EXDCVYMBSTM006.EQ1STM.local>
	<20100404131058.GA11705@opensource.wolfsonmicro.com>
	<20100406155812.GR31126@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100406155812.GR31126@trinity.fluff.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-04-06 at 16:58 +0100, Ben Dooks wrote: 
> On Sun, Apr 04, 2010 at 02:10:58PM +0100, Mark Brown wrote:
> > On Sat, Apr 03, 2010 at 08:12:56PM +0200, Sundar R IYER wrote:
> > 
> > Please fix your mail client to word wrap within paragraphs; not doing
> > this makes your messages harder to read and reply to.  I've reflowed below.
> > 
> > > 1. The documentation for the regulators mentions "power domains" and
> > > "switches" to be modeled as regulators. I am planning to model multiple
> > > "switches" for controlling supplies to various peripherals from a main
> > > master regulator as multiple regulators, childed from the parent
> > > regulator. Is this the right way to proceed ahead? Further the options
> > 
> > If you want to do this in the regulator framework, yes.
> > 
> > > for these switches will be only a logical on/off. (BTW, I saw lots of TI
> > > stuff which is something related to power domains, but it doesn't model
> > > the regulator framework.)
> > 
> > Nor does the SH stuff.  With the power domains of a CPU it often doesn't
> > buy terribly much to use the regulator framework - the power domains are
> > often a small part of a much bigger picture for the CPU internal power
> > management, often incorporating thing 
> 
> I personally think there is merit to having the regulator framework at
> least play a part in these, as is possible the powerdomains are being
> fed from external regulators and/or power switches. I see it as good
> way of using existing support to do useful work.

I tend to agree here, although I think it's still early days for this
technology and maybe some hybrid approach will eventually emerge.

Fwiw, I'm adding regulator support to other types of tightly coupled
CPU/DSP voltage control i.e. OMAP4 SmartReflex. 

Liam  

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
