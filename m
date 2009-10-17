From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: how can we modify voltage on DVFS through Linux
Date: Sat, 17 Oct 2009 20:18:10 +0100
Message-ID: <1255807090.19139.289.camel@vega>
References: <9c3f89cc0910161227l599965c9me23d563642592cfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9c3f89cc0910161227l599965c9me23d563642592cfc@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Priya Sehgal <priya.sehgal@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-10-16 at 15:27 -0400, Priya Sehgal wrote:
> Hello,
> I am working on DVFS capable CPU - Nehalem quad core and I need to
> modify the
> CPU speed and voltage. I disabled cpuspeed service on my machine and
> modified 
> some piece of cpuspeed code, to change the frequency of all the CPUs
> the way I want.
> 
> I am curious whether the voltage gets increased and decreased in
> proportion to the 
> frequency, or can we control the voltage separately. I could not
> locate any /sys entries for voltage
> only for frequency.
> 

Have a look at voltage regulator framework in include/linux/regulator.
It's used for CPU DVFS on ARM atm. 

Liam
