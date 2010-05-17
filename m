From: Sundar <sunder.svit@gmail.com>
Subject: Fwd:  Power Domain Framework
Date: Mon, 17 May 2010 19:03:57 +0530
Message-ID: <AANLkTinZRhUpFTOOUCdH5dEl3QaXn10USL_hPPQX8cie__33690.4347561815$1274103475$gmane$org@mail.gmail.com>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
	<20100510140527.GG5199@sirena.org.uk>
	<AANLkTikyqnKDNz7FIUvLDAvBReHskHvRCrEz2qBBqseH@mail.gmail.com>
	<20100517031613.GA3130@opensource.wolfsonmicro.com>
	<AANLkTimDdBCnRFMDiUkuNKanOzuPNwCpfRv9Gsi03Lsy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimDdBCnRFMDiUkuNKanOzuPNwCpfRv9Gsi03Lsy@mail.gmail.com>
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
Cc: viresh.kumar@st.com, rajeev-dlh.kumar@st.com, linus.walleij@stericsson.com, armando.visconti@st.com, linux-kernel@vger.kernel.org, vipin.kumar@st.com, shiraz.hashim@st.com, STEricsson_nomadik_linux@list.st.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, May 17, 2010 at 8:46 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, May 16, 2010 at 04:43:52PM +0530, Sundar wrote:
>
> Please don't top post, it breaks the thread of discussion.
Sorry.

> I'm really not convinced that this is a good idea. =A0Generally I suspect
> the implementations of these concepts that I've seen would introduce
> layering violations if done via the regulator API - from what I've seen
> the power domains can end up knowing rather more about the things that
> are being powered than is healthy for the regulator API and...

I am sorry but I do not understand how this can violate the framework APIs.
Even know, a regulator knows about its machine constraints, valid features
w.r.t operating modes, DRMS, load currents etc. What additional information
the regulator would be associated with would be operating points, constrain=
ts
w.r.t peripherals etc.

> I do think it's likely that you'll want something that looks like the
> regulator API at the edges, but that a separate implementation that
> avoids having to shoehorn through the abstractions of the regulator API
> for the on-chip work seems much more sensible (and is what OMAP and SH

True. But a separate implementation is not needed because the current
framework already provides me support for a majority of features. Features =
like
OPP control, power states which are usually associated with SoC power domai=
ns
are available on modem regulators. When such features will eventually creep=
 in
the regular framework, then why distinguish between on-SoC power sources
and on-board power sources..

> are already doing). =A0This is fairly similar to the relationship between
> the clock and regulator APIs - they look a lot alike, especially from a
> user point of view, but they are separate because there are enough
> differences in what they are trying to represent to make it sensible to
> keep them apart.

Agreed. But if I compare a SoC power domain and a regulator power domain, I
dont see differences to keep them apart. Please correct me if I am wrong.

> However, if you have patches it's probably easier to talk about those
> than architecture astronauting; perhaps your implementation avoids my
> concerns.
>
Okay. I will surely send them out.

Regards,
Sundar
