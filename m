From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 19:34:12 +0100
Message-ID: <EA6E0E5D-0F18-4F9A-BB39-11958E82BC69__7980.36043202064$1281292921$gmane$org@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<20100806123047.GE31326@sirena.org.uk>
	<20100806172226.GH2432@linux.vnet.ibm.com>
	<20100806173325.GA25367@rakim.wolfsonmicro.main>
	<20100806181832.GJ2432@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061517130.30564@asgard.lang.hm>
	<20100807001431.GA3252@opensource.wolfsonmicro.com>
	<alpine.DEB.2.00.1008061741460.30564@asgard.lang.hm>
	<20100807062828.GB28087@thunk.org>
	<AANLkTinTfKRfAUJqggcK9Cgo9BTXfqMjJ2SXZS=D1bmT@mail.gmail.com>
	<20100808160810.GA7968@srcf.ucam.org>
	<AANLkTik3FN5tTO8sgwz32b8s2SLnc8D1=14yU-a2betp@mail.gmail.com>
	(sfid-20100808_180840_654689_2C4E6C39)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik3FN5tTO8sgwz32b8s2SLnc8D1=14yU-a2betp@mail.gmail.com>
	(sfid-20100808_180840_654689_2C4E6C39)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "david@lang.hm" <david@lang.hm>, kevin granade <kevin.granade@gmail.com>, Ted Ts'o <tytso@mit.edu>, "peterz@infradead.org" <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "florian@mickler.org" <florian@mickler.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 8 Aug 2010, at 18:08, Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Sun, Aug 8, 2010 at 7:08 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> It's clearly possible for a pathological Android application to destroy
>> the power management policy. But to do that, the author would have to
>> explicitly take a wakelock. That's difficult to do by accident.
> 
> The writer can take a wakelock the whole time the application is
> running (isn't that the typical case?), because perhaps the author
> realizes that way the application works correctly, or he copy-pasted
> it from somewhere else.

That would be exceptionally unusual. A more common case is that the application will take a wakelock while performing some specific long running task which needs no user intervention such as downloading a file or displaying constantly update status that the user is not expected to respond to. There's no need for applications to take wakelocks while the user is directly interacting with them since the system will be kept awake as a result of the user interaction, the wakelocks are used to override the default suspend that occurs when the user is not interacting with the device.
