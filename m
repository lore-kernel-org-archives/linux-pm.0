From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Thu, 16 Feb 2012 19:04:53 -0800
Message-ID: <20120217030453.GA3266@gs62>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
	<87d39fk2n3.fsf@ti.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87d39fk2n3.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: len.brown@intel.com, markgross@thegnar.org, cpufreq@vger.kernel.org, Antti P Miettinen <amiettinen@nvidia.com>, linux-pm@lists.linux-foundation.org, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 15, 2012 at 05:06:40PM -0800, Kevin Hilman wrote:
> Hello,
> 
> Antti P Miettinen <amiettinen@nvidia.com> writes:
> 
> > This is a continuation to "RFC: CPU frequency min as PM QoS param"
> > patchset. This patchset adds CPU frequency maximum as a PM QoS
> > parameter and modifies CPU frequncy core to enforce the limit. CPU
> > frequency ceiling can be used to improve the energy efficiency of
> > workloads that would cause the cpufreq governors to enforce an
> > unnecessarily high operating point. In other words, CPU frequency
> > maximum can act as an energy efficiency level request.
> >
> > Tested on Dell E6420 with the ACPI cpufreq driver against Ubuntu
> > 3.2. Patches are against linux-next, compile tested.
> 
> I know there were some earlier discussions about the usefulness of a max
> frequency QoS parameter, so I wanted to throw in a reason to include max
> as well as min frequency parameters.
> 
> IMO, having a max frequency QoS parameter would be very useful from a
> thermal perspective.  
> 
> There are some ongoing projects in the PM working group at Linaro that
> are exploring plugins to the thermal framework that implment a "cooling
> device" by capping CPU frequency.  Having a QoS parameter do do this
> would be the logical interface.
> 
> I also agree with some earlier requests that these should probably be
> per-CPU instead of global.  That would make it simple to cap frequency
> of one cluster while leaving another alone.
>
Hi,

My problem is that overloading pm_qos with a performance limits is a
hack that will likely have problems coexisting with the core notion of
throttling limiting that is pm_qos as thermal limiting enabling expands
its scope.

Sure limiting performance governors seem to need the same notifications
and infrastructure as pm_qos but I worry that as its really doing the
opposite to qos I really don't see the logic of having it in pmqos.

Lets consider thermal throttling a bit maybe I can convince you to that
maybe we need some new mechanism for energy and thermal limiting.  (BTW
I agree something is needed for this).

For thermals the culprit's are:
cpu -- cpufreq governor currently not-thermal aware
Display -- brightness not thermal aware
GFX -- graphics driver not thermal aware
battery charging -- somewhat thermal aware but needs more than just bat
temp to count.
Flash -- led flash light  not thermal aware.

Other devices may have other heat sources of course.

Wouldn't it be better to have thermal awareness as part of the driver
model and then have a pm_qos like thing to do out of band signaling of
devices and user mode when a temperature is hit?

Putting it a qos class for limiting the high end of the performance that
a governor really doesn't go far enough IMO.  It looks like a hack just
for cpufreq that already has sysfs interfaces for limiting the top
frequency.

ok, maybe my argument is not so strong. but as long as its named pm QOS
and not pm-constraints I don't like the idea of having the max
parameter in the pm_qos code.  

It feature creeps the infrastructure and violates the spirit of what
pm_qos was to solve.  i.e. constrain the lower power states not upper
states.

But, for thermal / energy management I think we need more notification
of thermal or energy events than what is needed for the pm_qos problem.

For pm_qos its mostly a static problem that is tuned in the lab.  Know
the workload needs and block too much throttling.  For thermal / energy
management you isn't any tuning you can do.  You don't apply the
constraint until it gets too hot.  You don't know if or when you'll get
too hot.

Note: its more than just temperature that we need to worry about.  Peak
current is also a related issue (that is much more transient)

Shouldn't we do something more forward looking than hack pm_qos with
max-freq so that cpufreq can check a redundant parameter to what it
already has exported through sysfs?


--mark
