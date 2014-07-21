From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Mon, 21 Jul 2014 09:40:32 -0400
Message-ID: <53CD1850.8000904@ti.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>	<53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Arvind Chauhan <arvind.chauhan@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 July 2014 08:07 AM, Viresh Kumar wrote:
> On 19 July 2014 20:54, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> Sorry for jumping late
> 
> No, you aren't late. Its just 2 days old thread :)
> 
>> but one of the point I was raising as part of your
>> other series was to extend the CPU topology bindings to cover the voltage
>> domain information which is probably what is really needed to let the
>> CPUfreq extract the information. Not sure if it was already discussed.
> 
> Not it wasn't.
> 
>> After all the CPU clocks, cluster, clock-gating, power domains are pretty much
>> related. So instead of having new binding for CPUFreq, I was wondering whether
>> we can extend the CPU topology binding information to include missing information.
>> Scheduler work anyway needs that information.
>>
>> Ref: Documentation/devicetree/bindings/arm/topology.txt
>>
>> Does that make sense ?
> 
> Yeah it does, but I am not sure what exactly the bindings should look then.
> So, the most basic step could be moving the new bindings to topology.txt
> and name clock-master to dvfs-master.
> 
> What else?
> 
> If its going to be much controversial then we *can* go for just dvfs bindings
> for now and then update them later.
> 
Would be good to get others opinion. As you said if it is controversial then
it will stall the development.

Regards,
Santosh
