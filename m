From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCHv3 1/2] arch: Move CONFIG_DEBUG_RODATA and
 CONFIG_SET_MODULE_RONX to be common
Date: Tue, 7 Feb 2017 12:42:11 +0100
Message-ID: <20170207114211.GB4973@osiris>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-2-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44309 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754047AbdBGLm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 06:42:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v17BdvQi028652
        for <linux-pm@vger.kernel.org>; Tue, 7 Feb 2017 06:42:26 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28faeks8e6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2017 06:42:25 -0500
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 7 Feb 2017 11:42:22 -0000
Content-Disposition: inline
In-Reply-To: <1486427518-14819-2-git-send-email-labbott@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Jason Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jessica Yu <jeyu@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradea

On Mon, Feb 06, 2017 at 04:31:57PM -0800, Laura Abbott wrote:
> 
> There are multiple architectures that support CONFIG_DEBUG_RODATA and
> CONFIG_SET_MODULE_RONX. These options also now have the ability to be
> turned off at runtime. Move these to an architecture independent
> location and make these options def_bool y for almost all of those
> arches.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Make these configs selectable for arm. Include some documentation about
> how the setup of the optional Kconfigs work as well. Stop spelling 'kenrel'
> in prompt text.
> ---
>  Documentation/security/self-protection.txt |  6 ++++++
>  arch/Kconfig                               | 34 ++++++++++++++++++++++++++++++
>  arch/arm/Kconfig                           |  4 ++++
>  arch/arm/Kconfig.debug                     | 11 ----------
>  arch/arm/mm/Kconfig                        | 12 -----------
>  arch/arm64/Kconfig                         |  5 ++---
>  arch/arm64/Kconfig.debug                   | 11 ----------
>  arch/parisc/Kconfig                        |  1 +
>  arch/parisc/Kconfig.debug                  | 11 ----------
>  arch/s390/Kconfig                          |  5 ++---
>  arch/s390/Kconfig.debug                    |  3 ---
>  arch/x86/Kconfig                           |  5 ++---
>  arch/x86/Kconfig.debug                     | 11 ----------
>  13 files changed, 51 insertions(+), 68 deletions(-)

For the s390 bits:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

