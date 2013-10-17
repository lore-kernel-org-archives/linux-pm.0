From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v2 0/5] PM / OPP: updates to enable sharing OPPs info
Date: Thu, 17 Oct 2013 18:26:50 +0100
Message-ID: <52601DDA.1020105@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <3220965.oF35vmiThF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3220965.oF35vmiThF@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 17/10/13 00:12, Rafael J. Wysocki wrote:
> On Tuesday, October 01, 2013 02:32:57 PM Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Hi,
>>
>> These are few updates to existing device tree binding and the PM/OPP
>> library to support sharing of OPPs between different device nodes.
>>
>> Currently all the cpu nodes are parsed until the OPPs are found. This
>> is essential to support cpuhotplug without having to replicate OPP
>> information in all the cpu nodes.
>>
>> However in systems with multiple cpu power domain, its better to have
>> OPP entry for each cpu. To avoid replication, phandle can be specified
>> to the node which contains the full OPP information.
>>
>> The table node containing all the OPPs and device nodes pointing to an
>> entry into it through phandle might also solve the problem of describing
>> multiple OPP profiles.
> 
> It looks like this still is under discussion, isn't it?
> 
> If not, care to obtain ACKs from the people involved and resubmit?
> 

Thanks for following up on this patches. Since the entire series is based on the
DT binding in PATCH 1, which is still in discussion and subject to change, I
don't think its ready yet.

Regards,
Sudeep

