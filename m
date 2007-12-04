From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Tue, 4 Dec 2007 01:06:55 +0100
Message-ID: <20071204000655.GA17212__3143.21776754714$1196727238$gmane$org@lazybastard.org>
References: <20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
	<20071202195501.GB10657@lazybastard.org>
	<20071202200722.GA12101@elte.hu>
	<20071202203016.GC10657@lazybastard.org>
	<20071202204559.GA28550@elte.hu>
	<20071202211026.GB11522@lazybastard.org>
	<20071202211900.GB7439@elte.hu>
	<20071203005702.GA12215@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071203005702.GA12215@lazybastard.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Cc: len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 December 2007 01:57:02 +0100, J=C3=B6rn Engel wrote:
>=20
> After an eternity of compile time, this config does generate some usefu=
l
> output.  qemu is not to blame.

Or is it?  The output definitely looks suspicious.  Large amounts of
code get processed within a microsecond, while update_wall_time()
appears to cause huge delays every time it is called:
http://logfs.org/~joern/trace

Does this output make sense or does it rather indicate some sloppiness
wrt. time in the qemu virtual machine?

J=C3=B6rn

--=20
tglx1 thinks that joern should get a (TM) for "Thinking Is Hard"
-- Thomas Gleixner
