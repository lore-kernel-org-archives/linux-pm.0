From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
Date: Thu, 25 Aug 2016 00:48:38 +1000
Message-ID: <fe9a9667-cbbb-8fa2-5db0-2edd3220ca7b@gmail.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
 <57BDB2D8.4080507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <57BDB2D8.4080507@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <michael.neuling@au1.ibm.com>, Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
List-Id: linux-pm@vger.kernel.org



On 25/08/16 00:44, Daniel Lezcano wrote:
> On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> Currently all the idle states registered by a cpu-idle driver are
>> enabled by default. This patch adds a mechanism which allows the
>> driver to hint if an idle-state should start in a disabled state. The
>> cpu-idle core will use this hint to appropriately initialize the
>> usage->disable knob of the CPU device idle state.
> 
> Why do you need to do that ?
> 

I think patch 2/2 explains the reason as it uses this infrastructure

Balbir Singh
