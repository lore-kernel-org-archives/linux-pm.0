From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 0/4] timers: Timer migration
Date: Fri, 17 Oct 2008 10:43:24 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE08A3CEFD3A__7681.34601316905$1224214888$gmane$org@pdsmsx502.ccr.corp.intel.com>
References: <20081016114239.GA7641@linux.vnet.ibm.com>
	<20081016073749.4f944a19@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081016073749.4f944a19@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 'Arjan van de Ven' <arjan@infradead.org>, "arun@linux.vnet.ibm.com" <arun@linux.vnet.ibm.com>
Cc: "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "vatsa@linux.vnet.ibm.com" <vatsa@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>From: Arjan van de Ven
>Sent: Thursday, October 16, 2008 10:38 PM
>On Thu, 16 Oct 2008 17:12:39 +0530
>>
>>
>> Here's a brief introduction as to why we need timer migration.
>>
>
>as I've said before, for reducing power consumption I don't buy into
>needing this concept....
>
>If you have high frequency timers, you've lost no matter what (and we
>fixed almost all of them in the ecosystem); if you don't have those
>then this patch doesn't really add anything.
>(and the range-hrtimers fixes the intermediate state)
>

Does range-hrtimers work in per-cpu style or globally? If the former
I guess this timer migration may help range-hrtimers feature to
further align rest timers. If globally, then small room remains.

Arun, did you have any actual power improvement data with it?

Thanks,
Kevin
