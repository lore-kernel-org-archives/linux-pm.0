From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.31-rc2+: Interrupts enabled after cpufreq_suspend
Date: Fri, 10 Jul 2009 19:46:47 -0400
Message-ID: <20090710234646.GA11669__12183.387290179$1247269777$gmane$org@redhat.com>
References: <4A561074.5080407@gmail.com> <20090710192511.GB6240@redhat.com>
	<1247264617.21776.6.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247264617.21776.6.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Marcin Slusarz <marcin.slusarz@gmail.com>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 11, 2009 at 08:23:37AM +1000, Ben Herrenschmidt wrote:
 > On Fri, 2009-07-10 at 15:25 -0400, Dave Jones wrote:
 > 
 > > The answer seems to be in 42d4dc3f4e1ec1396371aac89d0dccfdd977191b
 > > which introduced all this code to work around some failure that only happens
 > > on PPC...
 > > 
 > >     [PATCH] Add suspend method to cpufreq core
 > >     
 > >     In order to properly fix some issues with cpufreq vs. sleep on
 > >     PowerBooks, I had to add a suspend callback to the pmac_cpufreq driver.
 > >     I must force a switch to full speed before sleep and I switch back to
 > >     previous speed on resume.
 > > 
 > > 
 > > Ben, is there something better we can do here ?
 > > 
 > > I really don't want to add an #ifdef __powerpc__ to core code if we can help it.
 > > I'd rather we didn't call into driver guts at all from the suspend path.
 > 
 > Wait a minute ... having a suspend/resume method in cpufreq is one
 > thing, having it muck around with SMP is another :-) The ppc code
 > doesn't do that.
 > 
 > There's nothing fundamentally "fail" in requiring a switch to a given
 > frequency before suspend. I don't know what kind of major FAIL the K8
 > code is doing here though :-)

The fail part comes from the fact that interrupts get reenabled.
And that's something that can easily happen out of our control if
we call into acpi_cpufreq's ->get method for example, so powernow-k8 isn't
the sole reason.

 > I'm happy instead of #ifdef's however to push the logic into the ppc
 > driver, or use a flag that the ppc driver sets to enable that logic.

Cool.

	Dave
