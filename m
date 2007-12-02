From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 22:08:27 +0100
Message-ID: <20071202210826.GA11522__13654.9322437078$1196630113$gmane$org@lazybastard.org>
References: <20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
	<20071202195501.GB10657@lazybastard.org>
	<20071202200722.GA12101@elte.hu>
	<20071202203016.GC10657@lazybastard.org>
	<20071202204559.GA28550@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202204559.GA28550@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 December 2007 21:45:59 +0100, Ingo Molnar wrote:
>=20
> to capture a 1 second trace of what the system is doing. I think your=20
> troubles are due to running it within a qemu guest - that is not a=20
> typical utilization so you are on unchartered waters.

Looks like it.  Guess I'll switch to something else for the moment.

J=C3=B6rn

--=20
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle
