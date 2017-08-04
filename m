From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Fri, 4 Aug 2017 08:03:07 -0700
Message-ID: <CALCETrVHGtA7nRaBCy9ZZ48Xu8hTKBgLdoGZeEHnHhPg3tdsxQ@mail.gmail.com>
References: <cover.1501601667.git.luto@kernel.org> <e6df9d038af0a0ce4d4119395aaea58366ade26d.1501601667.git.luto@kernel.org>
 <20170801200313.GC3110@fury> <CALCETrX0zqq3xQgNBx41R9ZCT3_bB4EoXGrY3jWLK0e0Koo=EQ@mail.gmail.com>
 <20170801204040.GH25574@pali> <20170801211702.GF3110@fury>
 <20170801213112.GK25574@pali> <20170801223947.GH3110@fury>
 <CALCETrXFySnB3jq_EAn+NDTb6jsp__4Dc=0ipdFqCbaZEPSOfg@mail.gmail.com>
 <20170802022232.GA21551@fury> <20170802074903.GO25574@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbdHDPD3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Aug 2017 11:03:29 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6B922DA8
        for <linux-pm@vger.kernel.org>; Fri,  4 Aug 2017 15:03:29 +0000 (UTC)
Received: by mail-vk0-f50.google.com with SMTP id d124so6886834vkf.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Aug 2017 08:03:29 -0700 (PDT)
In-Reply-To: <20170802074903.GO25574@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Wed, Aug 2, 2017 at 12:49 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Tuesday 01 August 2017 19:22:32 Darren Hart wrote:

>> Pali, how does the "magic number identifier" in the BMOF map to the object_id?
>> Have we retained that information in what we export today?
>
> MOF describe C++ like object system and for particular structures or
> methods there is GUID and WMI id.
>
> When you want to call WMI function implemented in ACPI you need to know:
> * name of ACPI function
> * instance number
> * WMI id
> * structure of input buffer
>
> Name of ACPI function is taken from _WDG where is mapping from GUID to
> object_id and ACPI function consist of well-known prefix and object_id
> as a suffix. GUID is present in MOF. Where to get correct instance
> number is still question for me. WMI id and structure of input buffer is
> described in MOF.

I assume that any user API for making WMI calls will have userspace
pass in either the GUID or maybe the MOF method name, not the object
id.

--Andy
