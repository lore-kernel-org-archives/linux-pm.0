From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Sun, 23 Jul 2006 09:24:50 -0700
Message-ID: <200607230924.52289.david-b@pacbell.net>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Thursday 20 July 2006 1:01 pm, Eugeny S. Mints wrote:
> +struct powerop_point {
> +=A0=A0=A0=A0=A0=A0=A0unsigned int v; =A0 =A0 =A0 =A0 /* voltage in mV */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int dpll;=A0=A0=A0=A0=A0=A0/* in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int cpu;=A0=A0=A0=A0=A0=A0=A0/* CPU freque=
ncy in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int tc;=A0=A0=A0=A0=A0=A0=A0=A0/* in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int per;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int dsp;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int dspmmu;=A0=A0=A0=A0/* in KHz */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int lcd;=A0=A0=A0=A0=A0=A0=A0/* in KHz */
> +};

A few comments:

 - This should be part of patch #4; it's not truly separate.

 - I take it "v" is CPU voltage rather than some random component?
   Either way, there seems to be an omission here since boards
   could have multiple voltages to care about ...

 - In general, shouldn't an operating point be board-specific, so
   that the parts of the system outside the SOC can be included?

 - I'd still rather see operating points be identified by a name
   string of some kind so that the userspace API resembles that
   of /sys/power/state:  just write the state name to that file.

Still looking at the patches, otherwise.

- Dave
  =
