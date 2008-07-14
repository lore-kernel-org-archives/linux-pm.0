From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Mon, 14 Jul 2008 21:30:31 +0800
Message-ID: <851fc09e0807140630w6edfa613oc176c6479808a6bd__34071.1855249994$1216042447$gmane$org@mail.gmail.com>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080711122131.b6461ab1.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 12, 2008 at 3:21 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:
>
>> On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
>> > This patch provides an enhancement to kexec/kdump. It implements
>> > the following features:
>> >
>> > - Backup/restore memory used by the original kernel before/after
>> >   kexec.
>> >
>> > - Save/restore CPU state before/after kexec.
>> >
>>
>> Hi Huang,
>>
>> In general this patch set looks good enough to live in -mm and
>> get some testing going.
>>
>> To me, adding capability to return back to original kernel looks
>> like a logical extension to kexec functionality.
>
> Exciting ;)  It's much less code than I expected.
>
> I don't think I understand the feature any more.  Once upon a time we
> thought that this might become a new and better (or at least
> better-code-sharing) way of doing suspend-to-disk.  How far are we from
> that?

At least there are still issues as follow:

- We need a mechanism to pass some information (such as backup pages
map) from hibernated kernel to hibernating kernel. Maybe in C calling
convention.
- To load hibernation image via /sbin/kexec, the segment number
constraint of sys_kexec_load needs to be extended (maybe via
multi-stage loading).
- Make kexec based hibernation compatible with ACPI S4.
- Extend makedumpfile utility for kexec based hibernation.

> What are the prospects of supporting other architectures?

I will work on x86_64 supporting.

> Who maintains kexec-tools, and are they OK with merging up the
> corresponding changes?

I will work with kexec-tools mailing list for corresponding kexec-tools patches.

Best Regards,
Huang Ying
