From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 20:08:33 +0300
Message-ID: <AANLkTik3FN5tTO8sgwz32b8s2SLnc8D1=14yU-a2betp__13886.7430658594$1281292253$gmane$org@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100808160810.GA7968@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: david@lang.hm, kevin granade <kevin.granade@gmail.com>, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 8, 2010 at 7:08 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sun, Aug 08, 2010 at 04:35:13PM +0300, Felipe Contreras wrote:
>
>> appropriately; that's not the case.
>>
>> 1) Install a bad application that requests PM permissions and is granted those
>>
>> In this case you've gained nothing with user-space suspend blockers.
>
> It's clearly possible for a pathological Android application to destroy
> the power management policy. But to do that, the author would have to
> explicitly take a wakelock. That's difficult to do by accident.

The writer can take a wakelock the whole time the application is
running (isn't that the typical case?), because perhaps the author
realizes that way the application works correctly, or he copy-pasted
it from somewhere else.

-- 
Felipe Contreras
