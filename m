From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 17 Aug 2006 16:20:36 +0900
Message-ID: <20060817072036.GA23027@localhost>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<6165fac0fa0cf9faa26b2c15b7b2378e@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <6165fac0fa0cf9faa26b2c15b7b2378e@comcast.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matthew.a.locke@comcast.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 16, 2006 at 10:20:42PM -0700, Matthew Locke wrote:
> On Aug 15, 2006, at 12:04 PM, Dave Jones wrote:
> > If there are dependancies inherently linking core1 and core2, cpufreq
> > should already be programming both parts. For example, the SA1100
> > driver programs both CPU and SDRAM controller.  If there isn't any =

> > dependancy between them, I don't see the attraction of creating an
> > artificial one in the way suggested for no real purpose.
> =

> Are you arguing against the operating point concept because it creates =

> an artificial dependency?  I assume your definition of dependency means =

> a physical dependency.
> =

>   The operating point represents both a physical and operational =

> dependency.  It is a collection of parameters that can/will be adjusted =

> to reduce power consumption.  However, adjusting these parameters can =

> have a severe impact to performance and operational state of the =

> system.  The parameters can not be adjusted individually and still =

> achieve the goal of an operational and power efficient system.   SoC's =

> have a fixed number of values in a fixed number of combinations that =

> keep the system operational and power efficient.  Using power op,  a =

> piece of controlling software can tell the system to go to  specific =

> instance of the power parameters that provide the best combination of =

> power savings and performance/operational integrity according to the =

> current state of the system.  This instance is represented by a string.
> =

The core1 and core interdependencies are something that cpufreq doesn't
handle particularly well. If it's something as simple as recalibrating
your baud rate generator or adjusting the SDRAM controller, these are
all things that need to be done for normal operation to continue, not
things that end up being exposed or configurable, so it tends to largely
ignore the interdependency issue.

The problem occurs when you have independent cores that want to be
throttled or scaled independently, yet still have some fixed dependency
between them (say, enabling a synchronization circuit), where failure to
handle this will ultimately result in core reset or otherwise undefined
behaviour.

In order to handle this cleanly, one would need multiple drivers for
each core, as well as some shared common code for handling the clocks,
voltage, and sanity checks. This alone already begins to enter the scope
for what things like PowerOP are reasonably suited for. The operating
point semantics work well here, as independent core states can be
trivially defined based off of vendor-defined usage profiles. It's
necessary to have a big picture view of the operating point in order to
sanely handle sanity checks and rate validation, which is something that
gets rather ugly with cpufreq without referencing common validation code
between each core (which will also cause problems for code reuse in the
cases where one of the cores is used in another processor).

PowerOP seems well suited for these sorts of cases, and it's not clear
that trying to beat cpufreq in to submission will offer any benefits in
this case, particularly since it's something x86 people largely don't
seem to care about, given that ACPI does most of the heavy lifting.
