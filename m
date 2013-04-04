From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 12:00:43 +0530
Message-ID: <CAP245DU68CCR9pDSryCv=tu00NjXkvEoerp6H6H9fQaYJgQA1g@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
	<CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
	<CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
	<1364985034.16520.12.camel@pasglop>
	<CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, deepthi@linux.vnet.ibm.com
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robin Randhawa <robin.randhawa@arm.com>, linux-pm@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Steve Bannister <Steve.Bannister@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2013 at 11:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 3 April 2013 16:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
>>> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>>> > Benjamin/Paul/Olof,
>>> >
>>> > Any comments on this?
>>>
>>> Ping!!
>>
>> I'm on vacation until end of April. No objection to the patch but
>> somebody needs to test it.
>
> Hi,
>
> Can somebody else from powerpc world give it a try?

Deepthi, can you help?

> OR
>
> @Rafael: Can we get this pushed in linux-next as is and then people would
> be forced to test it and in case there are any complains, i will fix them or
> you can revert it?
