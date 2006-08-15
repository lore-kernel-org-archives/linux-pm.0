From: Dave Jones <davej@redhat.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 15 Aug 2006 15:04:40 -0400
Message-ID: <20060815190439.GI7612@redhat.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1155638115.6736.135.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 15, 2006 at 01:35:15PM +0300, Amit Kucheria wrote:

 > Here is my shot at providing a 10,000ft view:
 > =

 > a. For embedded platforms, cpufreq just does not cut it when specifying
 > an operating point for the device. These platforms use tuples such as
 > =

 >   <voltage, pll_freq, core1_freq, core2_freq, interconnect_freq> =

 > =

 > to signify an 'operating point'. Note that core1 and core2 can be
 > totally different processors e.g. ARM and DSP. x86 platforms hide this
 > complexity behind ACPI.

If there are dependancies inherently linking core1 and core2, cpufreq
should already be programming both parts. For example, the SA1100
driver programs both CPU and SDRAM controller.  If there isn't any dependan=
cy
between them, I don't see the attraction of creating an artificial one
in the way suggested for no real purpose.

Things like voltage and frequency are closely tied together, so offering
any means of controlling them independantly makes no sense afaics.

 > b. The clocking and voltage dependency tree in embedded devices can be
 > summarised in the clock framework ( find ./arch -name clock* ) and
 > soon-to-be-available voltage framework. These is again done to large
 > extent by ACPI on x86.

Of the 14 x86 cpufreq drivers, 3 of them _optionally_ use ACPI.
powernow-k7 for example doesn't use it, and is possibly one of the most
stable cpufreq drivers we've had in the tree (for x86 at least).

 > d. In the end, all this is leading to an interface for a user-space
 > policy manager that will control _system_ power state based on
 > constraints imposed by HW peripherals or on policies implemented by
 > device manufacturer/distro maintainer.

How does that interface look from a userspace point of view ?
Hopefully not anything like the tuple described above.
Why would userspace ever care about "interconnect freq" ?

Userspace cares about "save power" or "go fast".
Historically, I wish we had never exposed frequencies, but instead
a performance percentage, so that the various userspace tools
didn't have to care about things like 'what frequencies are available'.
Adding the same mistake for voltages doesn't strike me as a fantastic idea.

 > At this point, PowerOP is an optional component in mainline tree.
 > Cpufreq drivers can _choose_ to use it or not. But now embedded
 > platforms can do the PM dance in a consistent way.

That's about the only part I really like so far. The option to opt-out
where it makes absolutely no sense to pointlessly abstract stuff
(which for x86 seems to be the case).  For ARM, I'm going to leave
Russell to comment/review.

		Dave

-- =

http://www.codemonkey.org.uk
