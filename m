From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] cpuidle: (powerpc) Add
 cpu_idle_wait() to allow switching of idle routines
Date: Tue, 29 Nov 2011 07:35:22 +1100
Message-ID: <1322512522.23348.43.camel@pasglop>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
	<20111117112830.9191.1951.stgit@localhost6.localdomain6>
	<1322434096.23348.6.camel@pasglop>
	<4ED36A37.3030409@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED36A37.3030409@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2011-11-28 at 16:32 +0530, Deepthi Dharwar wrote:

> > Additionally, I'm a bit worried (but maybe we already discussed that a
> > while back, I don't know) but cpu_idle_wait() has "wait" in the name,
> > which makes me think it might need to actually -wait- for all cpus to
> > have come out of the function.
> 
> cpu_idle_wait is used to ensure that all the CPUs discard old idle
> handler and update to new one.  Required while changing idle
> handler on SMP systems.
>
> > Now your implementation doesn't provide that guarantee. It might be
> > fine, I don't know, but if it is, you'd better document it well in the
> > comments surrounding the code, because as it is, all you do is shoot an
> > interrupt which will cause the target CPU to eventually come out of idle
> > some time in the future.
> 
> 
> I was hoping that sending an explicit reschedule to the cpus would
> do the trick but sure we can add some documentation around the code.

Well, the question is what guarantee do you expect. Sending a reschedule
IPI will take the other CPUs out of the actual sleep mode, but it will
be some time from there back to getting out of the handler function
(first back out of hypervisor etc...).

The code as you implemented it doesn't wait for that to happen. It might
be fine ... or not. I don't know what semantics you are after precisely.

Cheers,
Ben.
