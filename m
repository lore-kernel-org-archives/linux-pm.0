From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] turbostat: Running on virtual machine is not supported
Date: Fri, 28 Jul 2017 07:54:27 -0400
Message-ID: <8aa1f7ec-1d21-f027-f4c4-7c3d8e88b8d2@redhat.com>
References: <1500987324-507-1-git-send-email-prarit@redhat.com>
 <20170725155911.ihtjkz5cuwdpwoxp@khazad-dum.debian.net>
 <CAJvTdKmZqPkvUrgEJitYrBv7EJzpemLjN-nfYUnT3b127LNSQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbdG1Ly3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 07:54:29 -0400
In-Reply-To: <CAJvTdKmZqPkvUrgEJitYrBv7EJzpemLjN-nfYUnT3b127LNSQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 07/26/2017 11:09 PM, Len Brown wrote:
> Henrique,
> 
> I like your suggestion, thanks!
> 
> BTW. let's discuss (and patch) turbostat on linux-pm, rather than on lkml.
> 
> thanks,
> -Len
> 
> 
> On Tue, Jul 25, 2017 at 11:59 AM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
>> On Tue, 25 Jul 2017, Prarit Bhargava wrote:
>>> A common way of determining if the system is a virtual machine is to
>>> search /proc/cpuinfo flags entry for "hypervisor".  turbostat must output
>>> a proper error message when found.
>>
>> Maybe you could output that message only if it fails to both use
>> /dev/msr and perf *and* it is under a virtual machine?  That would have
>> better forward compatibility, maybe someday /dev/msr or perf will work
>> inside a VM for what turbostat needs...

To answer Len's previous question: I was wrong in my description.  perf does
work (mostly) under virt.  So this would only be for the msr code.  I'll post a
v2 to linux-pm, and take Henrique's suggestion to only trigger on an msr read
failure.

P.

>>
>> --
>>   Henrique Holschuh
> 
> 
> 
