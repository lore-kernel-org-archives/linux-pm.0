From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Power Domain Framework
Date: Sun, 16 May 2010 20:16:16 -0700
Message-ID: <20100517031613.GA3130__4626.86912292174$1274066307$gmane$org@opensource.wolfsonmicro.com>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
	<20100510140527.GG5199@sirena.org.uk>
	<AANLkTikyqnKDNz7FIUvLDAvBReHskHvRCrEz2qBBqseH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikyqnKDNz7FIUvLDAvBReHskHvRCrEz2qBBqseH@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar <sunder.svit@gmail.com>
Cc: viresh.kumar@st.com, rajeev-dlh.kumar@st.com, linus.walleij@stericsson.com, armando.visconti@st.com, linux-kernel@vger.kernel.org, vipin.kumar@st.com, shiraz.hashim@st.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 16, 2010 at 04:43:52PM +0530, Sundar wrote:

Please don't top post, it breaks the thread of discussion.

> However, for working with power domains within the framework, I feel that,
> - support must be added to allow additional domain-specific states
> like retention, idle etc.

I'm really not convinced that this is a good idea.  Generally I suspect
the implementations of these concepts that I've seen would introduce
layering violations if done via the regulator API - from what I've seen
the power domains can end up knowing rather more about the things that
are being powered than is healthy for the regulator API and...

> - controlling operating points for regulators, unlike setting optimal modes.
> - controlling regulator modes via constraints enforced by clients and
> managing transition to various states through the client requests and
> pushing the client states up to the parent regulator.

...knowing a lot about the specifics of the internal structures of the
device you're trying to model.  Cross talk with the clock API also seems
fairly common here.

I do think it's likely that you'll want something that looks like the
regulator API at the edges, but that a separate implementation that
avoids having to shoehorn through the abstractions of the regulator API
for the on-chip work seems much more sensible (and is what OMAP and SH
are already doing).  This is fairly similar to the relationship between
the clock and regulator APIs - they look a lot alike, especially from a
user point of view, but they are separate because there are enough
differences in what they are trying to represent to make it sensible to
keep them apart.

However, if you have patches it's probably easier to talk about those
than architecture astronauting; perhaps your implementation avoids my
concerns.
