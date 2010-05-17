From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Power Domain Framework
Date: Mon, 17 May 2010 14:18:28 -0700
Message-ID: <1274131108.2698.161.camel__32890.9481796019$1274131304$gmane$org@finisterre.wolfsonmicro.main>
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
	<1274118332.17303.17.camel@bnru01>
	<CEE6BB42CAD6E947908279175AF8470A025A726240@EXDCVYMBSTM006.EQ1STM.local>
	(sfid-20100517_213915_202336_5BFAA478)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A726240@EXDCVYMBSTM006.EQ1STM.local>
	(sfid-20100517_213915_202336_5BFAA478)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-05-17 at 22:38 +0200, Linus WALLEIJ wrote:
> [Sundar]

> > This is one of the most important aspect for such a change in the
> > regulator framework: bringing in the domain aspect can encourage all
> > newer (possibly older) architectures to come under a generic umbrella.

> I have the same view, and I've been enouraging Sundar to bring this
> discussion with the community in order to avoid code duplication.

> Of course we can start inventing our own power-domain machine
> like everyone else, but before we do that, let's atleast try to
> do something generic, so bear with us...

So, there's two separate issues here: one is if it makes sense to do a
generic power domain framework and/or, and the other is if it makes
sense for that generic power domain framework to be part of the
regulator API. I do agree that separating out the common bits of power
domain implementation would be good, my concerns here are around the
level of integration with the regulator API.
