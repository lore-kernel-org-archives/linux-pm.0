From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Power Domain Framework
Date: Mon, 10 May 2010 15:05:28 +0100
Message-ID: <20100510140527.GG5199__47631.4000938602$1273500379$gmane$org@sirena.org.uk>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Sikri <deepak.sikri79@gmail.com>
Cc: viresh.kumar@st.com, rajeev-dlh.kumar@st.com, armando.visconti@st.com, linux-kernel@vger.kernel.org, vipin.kumar@st.com, shiraz.hashim@st.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 10, 2010 at 07:16:06PM +0530, Deepak Sikri wrote:

> In our System on chip we have several power domains. As such there is no
> generic framework for the Power Domains in linux , and I find huge potential
> in the software to control the domains and exploit the power management
> capabilities.

> There is one very small model that I could think of, something on the lines
> of clock framework.

Might be worth looking at what the OMAP and SH Mobile CPUs are doing
here, they have existing handling for power domains.  Off-SoC the
regulator API should already cope with a lot of this stuff.
