From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-rc2+: Interrupts enabled after cpufreq_suspend
Date: Sat, 11 Jul 2009 08:23:37 +1000
Message-ID: <1247264617.21776.6.camel__36631.8920664073$1247264695$gmane$org@pasglop>
References: <4A561074.5080407@gmail.com>  <20090710192511.GB6240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090710192511.GB6240@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Marcin Slusarz <marcin.slusarz@gmail.com>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-07-10 at 15:25 -0400, Dave Jones wrote:

> The answer seems to be in 42d4dc3f4e1ec1396371aac89d0dccfdd977191b
> which introduced all this code to work around some failure that only happens
> on PPC...
> 
>     [PATCH] Add suspend method to cpufreq core
>     
>     In order to properly fix some issues with cpufreq vs. sleep on
>     PowerBooks, I had to add a suspend callback to the pmac_cpufreq driver.
>     I must force a switch to full speed before sleep and I switch back to
>     previous speed on resume.
> 
> 
> Ben, is there something better we can do here ?
> 
> I really don't want to add an #ifdef __powerpc__ to core code if we can help it.
> I'd rather we didn't call into driver guts at all from the suspend path.

Wait a minute ... having a suspend/resume method in cpufreq is one
thing, having it muck around with SMP is another :-) The ppc code
doesn't do that.

There's nothing fundamentally "fail" in requiring a switch to a given
frequency before suspend. I don't know what kind of major FAIL the K8
code is doing here though :-)

I'm happy instead of #ifdef's however to push the logic into the ppc
driver, or use a flag that the ppc driver sets to enable that logic.

Cheers,
Ben.
