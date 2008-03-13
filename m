From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Thu, 13 Mar 2008 09:47:30 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEB33CDD__25006.0188737281$1205427843$gmane$org@orsmsx423.amr.corp.intel.com>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org><20080310100008.GA9520@elf.ucw.cz><20080310134915.45ae7446@mjolnir.drzeus.cx><200803121511.17389.lenb@kernel.org>
	<20080313173437.5f00f70e@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080313173437.5f00f70e@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>, Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Pierre Ossman
>Sent: Thursday, March 13, 2008 9:35 AM
>To: Len Brown
>Cc: linux-pm@lists.linux-foundation.org; Pavel Machek; LKML; 
>Adam Belay; Andi Kleen; Lee Revell
>Subject: Re: [linux-pm] [PATCH] cpuidle: avoid singing capacitors
>
>On Wed, 12 Mar 2008 15:11:17 -0400
>Len Brown <lenb@kernel.org> wrote:
>
>> > 
>> > So for now, the only viable workaround is processor.max_cstate....
>> 
>> yup, that's why we put it in.  Is it insufficient?
>> 
>
>For some value of insufficient. It is sub-optimal. I'm hoping 
>there is a way to enter C3 in a pattern that avoids the noise 
>and still gives a reduced power usage.
>

Can you try using /dev/cpu_dma_latency from an user space application.
Refer Documentation/pm_qos_interface.txt for usage. With this interface
you can change menu governor behavior from userspace, by dynamically
allowing it to use C3 or not. I am thinking that something like allowing
C3 for few seconds and blocking it for few seconds may help.

Thanks,
Venki
