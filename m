From: Mark Gross <mgross@linux.intel.com>
Subject: OLS 2006 PM-BOF notes
Date: Thu, 10 Aug 2006 14:18:18 -0700
Message-ID: <20060810211818.GA18032@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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
List-Id: linux-pm@vger.kernel.org

OLS 2006 PM BOF notes

I'm sorry for taking so long to get these out, I misplaced my notes such as
there are.  The discussions where fragmented and hard to keep up with.  =


The following is what I've managed to recall from my chicken scratches.  Fe=
el
free to correct and amend these notes or discuss the items.

--mgross

CPUFREQ :
Too many governors.  Can we collapse some of the governors that have a lot =
of
code in common?  Should the conservative governor be implemented as a
constraint to the on demand driver / implemented by passing tuning paramete=
rs?

Can we remove the power save and performance governors?

Profiling applications:

Influence is coming from the embedded folks.  About 33% or more of BOF the
attendees where representing the embedded Linux users.

Application hints to OS PM behaviors needed.

How to make dynamic policy changes? (e.g. "shut down cpus on 36-way box on =
low
demand times")

Device / driver Policy manager for application based PM:

Can drivers be put into lower power states based on application hints, such=
 as
I'm doing DVD play back and don't need HD, Ethernet, USB, BT so shut those =
down
for now.

Need drivers to support going to low power states:
Building the driver knowledge of clock dependencies?
Nokia's clock/voltage frame work for OMAP

Predicable suspend and resume times:
