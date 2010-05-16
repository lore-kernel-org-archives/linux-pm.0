From: Sundar <sunder.svit@gmail.com>
Subject: Re: Power Domain Framework
Date: Sun, 16 May 2010 16:43:52 +0530
Message-ID: <AANLkTikyqnKDNz7FIUvLDAvBReHskHvRCrEz2qBBqseH__24466.0263568678$1274008529$gmane$org@mail.gmail.com>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
	<20100510140527.GG5199@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100510140527.GG5199@sirena.org.uk>
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
Cc: viresh.kumar@st.com, rajeev-dlh.kumar@st.com, linus.walleij@stericsson.com, armando.visconti@st.com, linux-kernel@vger.kernel.org, vipin.kumar@st.com, shiraz.hashim@st.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi All,

The regulator framework documentation already refers to the concept of
power domains and I think the framework *can* be extended more to
support on-SoC power domains as well.

I have been working with the regulator framework for on-chip power
domains too and....

>2. Maintain a list of the different power domains present.
>3. The devices in a specific power domain, as per the requirements would g=
et the power
>domain...
>4. Typically a usage count of zero for any power domai..
>5. The same could be mapped on to the PM framework..
>6. The model could further be build upon to check any dependency in the po=
wer domains

the above requirements can be leveraged through the current regulator
framework itself.

However, for working with power domains within the framework, I feel that,
- support must be added to allow additional domain-specific states
like retention, idle etc.
- controlling operating points for regulators, unlike setting optimal modes.
- controlling regulator modes via constraints enforced by clients and
managing transition to various states through the client requests and
pushing the client states up to the parent regulator.

>7. The advantages of the framework could be leveraged in the CPU idle time=
, by switching >off the Power domains with zero usage counts.

Yes. A simple platform specific list of all regulators ( and power
domains ) can be easily used in the CPUIdle driver for determining low
power states. Further, enforcing run time PM can club together any
peripheral's power sources in terms of external regulators, on-chip
domains ( and clock sources possibly).

i have a very primitive implementation for adding operating points and
constraints into the framework and currently i am able to control
regulator aka domain states based on various child domains and
contraints.

However, with more inputs, I think we can make the regulator framework
easily manage power sources, whether on-chip domains or external
conventional regulators...

Waiting for opinions and views,

Regards,
Sundar

 Mon, May 10, 2010 at 7:35 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, May 10, 2010 at 07:16:06PM +0530, Deepak Sikri wrote:
>
>> In our System on chip we have several power domains. As such there is no
>> generic framework for the Power Domains in linux , and I find huge poten=
tial
>> in the software to control the domains and exploit the power management
>> capabilities.
>
>> There is one very small model that I could think of, something on the li=
nes
>> of clock framework.
>
> Might be worth looking at what the OMAP and SH Mobile CPUs are doing
> here, they have existing handling for power domains. =A0Off-SoC the
> regulator API should already cope with a lot of this stuff.
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
