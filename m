From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH 4/6 v5] arm highbank: add support for pl320 IPC
Date: Tue, 27 Nov 2012 13:53:37 -0600
Message-ID: <50B51A41.8030006@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com> <1354028674-23685-5-git-send-email-mark.langsdorf@calxeda.com> <20121127171250.3984e990@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20121127171250.3984e990@skate>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Omar Ramirez Luna <omar.luna@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On 11/27/2012 10:12 AM, Thomas Petazzoni wrote:
> Dear Mark Langsdorf,
> 
> On Tue, 27 Nov 2012 09:04:32 -0600, Mark Langsdorf wrote:
> 
>> +int ipc_transmit(u32 *data);
> 
> ipc_transmit() looks to me like a way to generic name to be exposed to
> the entire kernel.

Good point. Changed to pl320_ipc_transmit()

>> +extern int pl320_ipc_register_notifier(struct notifier_block *nb);
>> +extern int pl320_ipc_unregister_notifier(struct notifier_block *nb);
> 
> Why some "extern" here? You don't have these for the other functions in
> this header file.

Nice catch. Fixed to export them in cpufreq.

--Mark Langsdorf
Calxeda, Inc.

