From: Sundar R Iyer <sundar.iyer@stericsson.com>
Subject: Re: Power Domain Framework
Date: Mon, 17 May 2010 23:15:32 +0530
Message-ID: <1274118332.17303.17.camel__49039.4368106083$1274118567$gmane$org@bnru01>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
	<20100510140527.GG5199@sirena.org.uk>
	<AANLkTikyqnKDNz7FIUvLDAvBReHskHvRCrEz2qBBqseH@mail.gmail.com>
	<20100517031613.GA3130@opensource.wolfsonmicro.com>
	<AANLkTimDdBCnRFMDiUkuNKanOzuPNwCpfRv9Gsi03Lsy@mail.gmail.com>
	<AANLkTinZRhUpFTOOUCdH5dEl3QaXn10USL_hPPQX8cie@mail.gmail.com>
	<20100517143319.GC5257@opensource.wolfsonmicro.com>
	<AANLkTiniwUDg8rQzwgm_X7EbkQJ9tHzBfVtaJRiNE9az@mail.gmail.com>
	<1274114107.20589.64.camel@bnru01>
	(sfid-20100517_173524_963855_B42F2966)
	<1274115886.2698.22.camel@finisterre.wolfsonmicro.main>
Reply-To: sundar.iyer@stericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274115886.2698.22.camel@finisterre.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

> This implementation is assuming that the implementation in hardware only
> has two levels, and that the decision to go to the higher level is done
> by a simple or of requests for the full level from the consumers. I'm
> not convinced that this will be true in general, or that it's always
> going to be true that the different power domains are all isolated from
> each other. There doesn't seem to be any immediate reason why hardware
> won't ever implement more than two modes, and I'm not convinced that the
> straight or of requests will always be sufficient to determine the

Yes. Two modes is not the only level that hardware can support.
An ideal case is Full OPP/Half OPP (which is the normal operating
point)/Retention(which is the least so that the device is on).

> operating mode for the entire power domain. For example, I can see
> hardware requiring that if more than a given number of blocks are
> enabled at any level a higher operating point is selected.
Hmm...very much possible. Need to think on this further.

> Are you sure that this interface is sufficiently general to work with
> all hardware, not just your own? How does this map on to the OMAP or SH
> hardware, for example?
AFAIK and with my experience (and my current memory) with TI Davinci
arch, most of the power domains are simpler ones with on/off and
possibly some retention too. And the latest TI code also exposes domains
with on/off/retention states. So, I think if we make this sturdy, I dont
see any reason why we cannot map any generic architecture. CCing Kevin
for his inputs.

This is one of the most important aspect for such a change in the
regulator framework: bringing in the domain aspect can encourage all
newer (possibly older) architectures to come under a generic umbrella.

Anyways, let me have a bit more on the "number of blocks" thing!

Regards,
Sundar
