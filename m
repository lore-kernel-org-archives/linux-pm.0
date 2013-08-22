From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v4 03/19] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Thu, 22 Aug 2013 14:29:41 +0100
Message-ID: <52161245.3080404@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>  <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1377152143.25016.289.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377152143.25016.289.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On 22/08/13 07:15, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-20 at 10:30 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
>>
>> It's better to consolidate them by adding support for getting cpu
>> device node for a given logical cpu index in DT core library. However
>> logical to physical index mapping can be architecture specific.
>>
>> PowerPC has it's own implementation to get the cpu node for a given
>> logical index.
>>
>> This patch refactors the current implementation of of_get_cpu_node.
>> This in preparation to move the implementation to DT core library.
>> It separates out the logical to physical mapping so that a default
>> matching of the physical id to the logical cpu index can be added
>> when moved to common code. Architecture specific code can override it.
> 
> So the patch unfortunately collides with other changes in powerpc -next,
> though it's not a huge deal and not hard to fixup, but expect Linus
> to tick unless we sort it out some other way.
> 
> Appart from that, it's fine, builds on all my test configs and doesn't
> seem to negatively impact things as far as I can tell so far...
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 

Hi Ben,

Thanks a lot for testing and ACK.
I will check with Rafael about these (trivial) conflicts.

Regards,
Sudeep
