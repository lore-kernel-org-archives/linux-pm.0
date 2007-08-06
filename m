From: "Huang, Ying" <ying.huang@intel.com>
Subject: RE: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Mon, 6 Aug 2007 21:22:46 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC2437517__14275.7988338873$1186415824$gmane$org@pdsmsx415.ccr.corp.intel.com>
References: <20070806090210.GA15329@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070806090210.GA15329@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz]
>> > Did the trick, I got the kernel to load, and it even attempted
>> > exec... but I got doublefault (or what is it?)
>> >
>> > Int 6: ... EIP: c4739906. Address is in reserve_bootmem_core.
>> >
>> > Do I have to disable ACPI completely? I tried with acpi=off,
>> > nosmp... but problem does not seem device related.
>>
>> It seems that the problem has nothing to do with device or ACPI. Can
you
>> do a normal kexec? That is:
>>
>> kexec -l <...>
>> kexec -e
>>
>> or
>>
>> kexec -p <...>
>> ALT-SysRq-c to trigger a crash dump.
>
>...that was indeed a problem. I can do successful kexec, as long as I
>load bzImage (and not vmlinux). (Both kernels 2.6.22 and
>2.6.23-rc2-git). Problem is, I can only load bzImage using -l, attempt
>to load bzImage using -p results in
>
>"Could not find a free area of memory of 9000 bytes"
>locate_hole failed
>
>. Any ideas?

The Kexec-tools 1.101 can not deal with bzImage with "-p" properly. So
vmlinux must be used with "-p". And the tricks previous mentioned must
be used for normal kexec -p too. The example command line is as follow:

kexec -p --args-linux vmlinux --append="root=/dev/<xxx> ..."

Best Regards,
Huang Ying
