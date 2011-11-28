From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle
	power_save=off
Date: Mon, 28 Nov 2011 16:33:25 +0530
Message-ID: <4ED36A7D.9070308__30833.3199973733$1322478237$gmane$org@linux.vnet.ibm.com>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>	<20111117112906.9191.54050.stgit@localhost6.localdomain6>
	<1322435233.23348.19.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1322435233.23348.19.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/28/2011 04:37 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2011-11-17 at 16:59 +0530, Deepthi Dharwar wrote:
>> This patch makes pseries_idle_driver not to be registered when
>> power_save=off kernel boot option is specified. The
>> boot_option_idle_override variable used here is similar to
>> its usage on x86.
> 
> Quick Q. With your changes, the CPU will never get into idle at all
> until cpuidle initializes and the driver loads.
> 
> That means not only much later in the boot process, but potentially
> never if the distro has the driver as a module and fails to load it, or
> similar.
> 
> Can't that be an issue ? Shouldn't we keep at least one of the basic
> idle functions as a fallback ?
> 


On an LPAR if cpuidle is disabled, ppc_md.power_save is still set to
cpuidle_idle_call by default here. This would result in calling of
cpuidle_idle_call repeatedly, only for the call to return -ENODEV. The
default idle is never executed.
This would be a major design flaw. No fallback idle routine.

We propose to fix this by checking the return value of
ppc_md.power_save() call from void to int.
Right now return value is void, but if we change this to int, this
would solve two problems. One being removing the cast to a function
pointer in the prev patch and this design flaw stated above.

So by checking the return value of ppc_md.power_save(), we can invoke
the default idle on failure. But my only concern is about the effects of
changing the ppc_md.power_save() to return int on other powerpc
architectures. Would it be a good idea to change the return type to int
which would help us flag an error and fallback to default idle?

> Cheers,

> Ben.
> 
> 


Regards,
Deepthi
