From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 20:55:02 +0100
Message-ID: <20071202195501.GB10657@lazybastard.org>
References: <20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
	<20071201204747.GA6458@lazybastard.org>
	<20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202154746.GA27069@elte.hu>
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

On Sun, 2 December 2007 16:47:46 +0100, Ingo Molnar wrote:
>=20
> well what does the trace say, where do the delays come from? To get a=20
> quick overview you can make tracing lighter weight by doing:
>=20
>  echo 0 > /proc/sys/kernel/mcount_enabled
>  echo 1 > /proc/sys/kernel/trace_syscalls

I mistyped and did=20
 echo 1 > /proc/sys/kernel/mcount_enabled

Result looked like a livelock and finally convinced me to abandon the
latency tracer.  Sorry, but it appears to be the right tool for the
wrong job.

J=C3=B6rn

--=20
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
