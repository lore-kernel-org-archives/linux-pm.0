From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: intel_pstate: Lowest frequency not reached with Intel i7-6700
Date: Wed, 12 Dec 2018 15:06:30 -0800
Message-ID: <000701d4926f$533eb270$f9bc1750$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
References: XCF0g8mvUQvFWXCF1gj1RM
In-Reply-To: XCF0g8mvUQvFWXCF1gj1RM
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Paul Menzel' <pmenzel@molgen.mpg.de>
Cc: linux-pm@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Len Brown' <lenb@kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.12.12 13:40 Paul Menzel wrote:

> Using *powersave* as P-state selection algorithm, on an idle system

Define "idle system".
If your computer is running a GUI, or is even a server without a GUI
but with many services running, then "idle" really isn't.
Below is from my test server, with many services disabled, so
"idle" really is quite "idle"

doug@s15:~/temp$ sudo turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
Busy%   Bzy_MHz PkgTmp  PkgWatt
0.01    1608    27      3.71
0.01    1619    27      3.71
0.01    1600    28      3.71
0.01    1600    28      3.70

Note that p state 16 (1600 MHz) is the minimum for my older i7-2600k =
processor.

> Shouldn=E2=80=99t it go down until 800 MHz?

We would need some actual busy information, turbostat is the recommended =
tool,
to know for sure.

... Doug
