From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2] cpupower: Fix no-rounding MHz frequency output
Date: Thu, 2 Nov 2017 14:20:01 -0600
Message-ID: <fea531d0-666a-8c15-fcee-18adc0351a9c@osg.samsung.com>
References: <20171025135132.16324-1-prarit@redhat.com>
 <54215387-96b8-07d3-0b0e-4df4a0b0dca6@kernel.org>
 <CAJZ5v0hKmVeAbPtr06_JCDMd1U5TXxs+VW-7jYUnAwseXaiX7A@mail.gmail.com>
 <5a15dfc3-9dca-92a3-063c-b9a653ccbf0b@osg.samsung.com>
 <CAJZ5v0j6hC=eUnNKFO3dgTBd572AOngtnetGNjjm1kXWjeCrOg@mail.gmail.com>
 <a6f19fbd-3bc8-f8a1-4515-1a1bcecddce7@osg.samsung.com>
 <CAJZ5v0gkFYyJPewqHrCFQsfVHyqzn=H_mbUtqNEmDmPDpVGuVA@mail.gmail.com>
 <0023af85-a643-edaf-f6d4-fba1c3756e6e@osg.samsung.com>
 <cc10ec84-e016-3f1b-163f-21cea09f7173@redhat.com>
 <126a1373-cd76-3f1e-2f91-5b5ea8a664ec@osg.samsung.com>
 <012f54bd-b4cc-22fb-83d4-9606ba7c50c8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:33099 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdKBUUD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Nov 2017 16:20:03 -0400
In-Reply-To: <012f54bd-b4cc-22fb-83d4-9606ba7c50c8@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, Shuah Khan <shuah@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuahkh@osg.samsung.com>

On 11/02/2017 02:18 PM, Prarit Bhargava wrote:
> 
> 
> On 11/02/2017 02:59 PM, Shuah Khan wrote:
>> On 11/01/2017 06:42 PM, Prarit Bhargava wrote:
>>
>> Hi Prarit,
>>
>> Does this tool build for you? I am seeing:
>>
>> utils/helpers/amd.c:7:21: fatal error: pci/pci.h: No such file or directory
>>  #include <pci/pci.h>
>>                      ^
>> compilation terminated.
>> Makefile:221: recipe for target 'utils/helpers/amd.o' failed
>> make: *** [utils/helpers/amd.o] Error 1
>>
> 
> Got it ... you have to have the pciutils-devel package installed which
> installs /usr/include/pci/pci.h.
> 
> That file contains:
> 
> struct pci_access {
>   /* Options you can change: */
>   unsigned int method;                  /* Access method */
>   int writeable;                        /* Open in read/write mode */
>   int buscentric;                       /* Bus-centric view of the world */
> <snip>
> 

Thanks for looking into this.

-- Shuah
