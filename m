From: Sundar R Iyer <sundar.iyer@stericsson.com>
Subject: Re: Power Domain Framework
Date: Tue, 18 May 2010 11:30:50 +0530
Message-ID: <1274162450.17303.35.camel__28766.3765521303$1274162646$gmane$org@bnru01>
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
	<1274131108.2698.161.camel@finisterre.wolfsonmicro.main>
	<CEE6BB42CAD6E947908279175AF8470A025A72624A@EXDCVYMBSTM006.EQ1STM.local>
	(sfid-20100517_224652_794912_8E56D9D6)
	<1274134636.2698.170.camel@finisterre.wolfsonmicro.main>
Reply-To: sundar.iyer@stericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274134636.2698.170.camel@finisterre.wolfsonmicro.main>
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

Hi,

> Yeah, sure - obviously, the generic concept of power domains is
> something that does exist within the off-SoC hardware, but on-SoC the
> end implementation is a bit different.

Exactly. This is what I can see if we can bridge this "a bit different".

True, I am dumb to miss out some points, but I think with more inputs,
more thinking, we can definitely make it generic!

Thinking out loud ( excuse me if this is dumb), At the end of the day,
how I see this benefiting a lay driver developer is : use the regulator
API for the appropriate power sources - your SoC domain, your external
regulator domain..etc..etc and ensure a very efficient (probably) run
time PM for your device. All that the Platform guy will do is iterate 
a list of domains on the platform, provide hookups, ensure constraints 
etc and the job is done. Even if the same IP is used on a different SoC,
you still ensure efficient savings in your driver itself.

> As I said in reply to the patch I am concerned that this may be an
> oversimplification relative to what general hardware needs.
Ohh. for the patch set, as I said, its only a primitive implementation.
With your inputs, we can definitely make it more efficient!

Regards,
Sundar
