From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 3 Mar 2008 14:04:06 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2__23708.0543920912$1204582260$gmane$org@orsmsx423.amr.corp.intel.com>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx><20080303211842.6f492782@mjolnir.drzeus.cx><20080303204603.GA19775@elf.ucw.cz><20080303220310.0cab7213@mjolnir.drzeus.cx><20080303210839.GJ13869@elf.ucw.cz><924EFEDD5F540B4284297C4DC59F3DEEA2E81B@orsmsx423.amr.corp.intel.com>
	<20080303221752.5169f91d@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080303221752.5169f91d@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 

>-----Original Message-----
>From: Pierre Ossman [mailto:drzeus-list@drzeus.cx] 
>Sent: Monday, March 03, 2008 1:18 PM
>To: Pallipadi, Venkatesh
>Cc: Pavel Machek; Adam Belay; 
>linux-pm@lists.linux-foundation.org; LKML; Andi Kleen; Lee Revell
>Subject: Re: [PATCH] cpuidle: avoid singing capacitors
>
>On Mon, 3 Mar 2008 13:14:28 -0800
>"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
>> 
>> I prefer leaving it off my default and enabling it on faulty 
>hardware by
>> some blacklist.
>> 
>
>But are these kind of shoddy components really trackable by 
>model? I'd suspect it has more to do with the shipment of 
>parts the day when the computer was manufactured.
>

But, with this patch:
- we are penalizing good hardware and making them less power efficient
to match the bad ones.
- There may also be server systems which first may not have these sort
of power fluctuations and even when buggy and have this noise, system
may be in some corner of some lab with fans making more noise than the
capacitors.

Thanks,
Venki
