From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 15:11:18 +0100
Message-ID: <20071202141117.GB9516__5402.23025386712$1196605085$gmane$org@lazybastard.org>
References: <20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
	<20071201204747.GA6458@lazybastard.org>
	<20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202135711.GA20434@elte.hu>
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

On Sun, 2 December 2007 14:57:11 +0100, Ingo Molnar wrote:
>=20
> hm, do you have CONFIG_FRAME_POINTERS=3Dy, i.e. are the dumps reliable?

I do.  Went through 10odd runs and annotated the function right below
mcount each time.  Seems to work now.

Trouble is that it doesn't solve my real problem at hand.  Something is
causing significant delays when writing to logfs.  Core logfs code is
not running, but may cause whatever other code is running and burning up
all the cpu time.  Wasting 100ms of "qemu-time" to write a single page
happens fairly frequently.

With the latency tracer the problem appears to have become worse.  Now
the loftlockup code triggers quite frequently.  Which makes a bit of
sense, as the problem is a busy CPU, rather than an idle one.

Guess I'll try oprofile or lcov instead.

J=C3=B6rn

--=20
Joern's library part 5:
http://www.faqs.org/faqs/compression-faq/part2/section-9.html
