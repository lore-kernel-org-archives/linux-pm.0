From: "Victor Miasnikov" <vvm@tut.by>
Subject: Re: CONFIG_HYPERVISOR_GUEST=y   {-- replace -- CONFIG_PARAVIRT_GUEST=y {= { # CONFIG_HYPERVISOR_GUEST is not set } Re: 3.10-rc1 system starts regular boot when waking from s2ram Fw: [PATCH 2/2] x86: Make Linux guest support optional
Date: Wed, 15 May 2013 16:44:05 +0300
Message-ID: <293D65E8F6CE48768FF47E438C57ECD2@local.st.by>
References: <20130514160108.GA5055@dhcp22.suse.cz> <925E2E537ECB4D0C8EA18467A4D20174@local.st.by> <20130515133405.GC5455@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@linuxdriverproject.org, olaf@aepfle.de, "\"Andy Whitcroft\"" <apw@canonical.com>, jasowang@redhat.com, Thomas Gleixner <tglx@linutronix.de>, JBeulich@suse.com
List-Id: linux-pm@vger.kernel.org


Hi!

>> >- select PARAVIRT_GUEST
>> >+ select HYPERVISOR_GUEST
> 
> I might have missed the previous discussion but how does this relate to
> the original problem reported to this (https://lkml.org/lkml/2013/5/14/398)
> thread?

 As example:

https://lkml.org/lkml/2013/5/14/398
==
 . . .
# CONFIG_HYPERVISOR_GUEST is not set
 . . .
==

> For record:
> $grep HYPERVISOR_GUEST .config
> # CONFIG_HYPERVISOR_GUEST is not set


Why not
CONFIG_HYPERVISOR_GUEST=y

 ?

> $grep PARAVIRT_GUEST .config
> $


Best regards, Victor Miasnikov
Blog:  http://vvm.blog.tut.by/
