From: Mark Gross <mgross@linux.intel.com>
Subject: Re: cpufreq user<->kernel interface removal [was Re:
	community PM requirements/issues and PowerOP]
Date: Thu, 14 Sep 2006 09:26:23 -0700
Message-ID: <20060914162623.GA6867@linux.intel.com>
References: <20060911210026.GG11901@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
	<20060911213930.GJ11901@elf.ucw.cz> <4505E62F.1000203@gmail.com>
	<20060911230529.GC13474@elf.ucw.cz>
	<20060911235025.GA14234@linux.intel.com>
	<20060912033537.GC27397@kroah.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060912033537.GC27397@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: lkml@elf.ucw.cz.kroah.org, Pavel Machek <pavel@ucw.cz>, Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 11, 2006 at 08:35:37PM -0700, Greg KH wrote:
> On Mon, Sep 11, 2006 at 04:50:25PM -0700, Mark Gross wrote:
> > The PowerOP patch has nothing to do with the removal of cpufreq.  You
> > may be confusing this work with the david signleton patch.
> =

> I am totally confused about who is working on what, and what provides
> what.
> =

> Can someone make  quick cheat-sheet that shows the different
> developers/companies and projects here?  The fact that it's impossible
> to keep this straight in the first place does not bode well...

Power-OP: Matt, Eugeny, Igor, myself to a much lesser extent
Oppoint: David

Interested parties to getting operating point concepts into the main
line kernel are CELF and MLI members.

> =

> Or, can each of the different projects send a _short_, 1 paragraph, 4
> sentance maximum summary of the different things.  Think of it as your
> "elevator pitch".  The different multi-page summaries ware making my
> eyes glaze over...
> =


CE and embedded Linux users have not been able to use cpufreq, mostly
because those platforms don't have ACPI like FW for controlling all the
power parameters NOT exposed on PC's and laptops, where the PM control
possibilities are much more exposed to the OS requiring OS support to
leverage.

The notion of operating point has become very popular in the CE
/embedded space.  Some variant of it is used in every CE device and
there is a need to get some common way to tickle the platform PM for non
PC hardware.

PowerOP is the derived from Operating Point interface portion of the DPM
and is an attempt to provide a common way for this.  It started life as
a patch that came out about 1 year ago by Todd Poyner.  This version of
PowerOP has been a collaboration of a group of folks that got together
at the PM-Summit last April.

Oppoint is also derived from the interface portion of DPM but goes
farther to include more of DPM, causes confusion and controversy and was
pushed at a bad time.  It would be nice if the Oppoint patch be
re-submitted as a patch to the PowerOP patch once it gets some traction
in the MM tree.


> thanks,
> =

> greg k-h
