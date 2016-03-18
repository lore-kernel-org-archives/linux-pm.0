From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Fri, 18 Mar 2016 22:44:19 +0100
Message-ID: <CAJZ5v0ijyXsrK7512oV0cM=jj9P+fXkq36RRc-iTDaAsSq7ugg@mail.gmail.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
	<10670722.U2p4NnYGsS@vostro.rjw.lan>
	<CA+5PVA78uXrqgm5a9h5ytbrd5sun4mVU5+u9V9GnY1V6rizhzg@mail.gmail.com>
	<6130650.QZM8FIW1Fl@vostro.rjw.lan>
	<E8E228AA-B140-4C15-8984-EFACDC95FB9F@linux.intel.com>
	<1458323535.3861.76.camel@linux.intel.com>
	<2FBA4108-2F11-438D-B521-62B577967B94@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36483 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbcCRVoV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 17:44:21 -0400
In-Reply-To: <2FBA4108-2F11-438D-B521-62B577967B94@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Josh Boyer <jwboyer@fedoraproject.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Fri, Mar 18, 2016 at 7:32 PM, Stephane Gasparini
<stephane.gasparini@linux.intel.com> wrote:
>
> =E2=80=94
> Steph
>
>
>
>
>> On Mar 18, 2016, at 6:52 PM, Srinivas Pandruvada <srinivas.pandruvad=
a@linux.intel.com> wrote:
>>
>> On Fri, 2016-03-18 at 17:13 +0100, Stephane Gasparini wrote:
>>> Rafael,
>>>
>>> Why in step 3) both atom_set_pstate() and atom_set_pstate() were no=
t
>>> both
>>> changed to use wrmsrl ?
>> Initial Atom support was experimental as there were no users, till
>> Chrome started using. So it was just a miss.
>>
>> We should never have to use wrmsrl_on_cpu. But looks like
>> cpufreq_driver.init() can't guarantee that.
>>
>>> BTW, what is the interest of setting the pstate to LFM during
>>> initialization ?
>>> The BIOS is setting the pstate to either LFM, HFM or BFM, and why
>>> bothering
>>> changing it.
>> This is a different issue. BIOS has different configuration option t=
o
>> enable fast boot modes which are not necessarily optimized for Linux=
=2E
>> Some aggressive setting will force system to reboot on boot. So I wi=
ll
>> leave the way it is.
>>
>> Thanks,
>> Srinivas
>>
>
> Still it does not answer my question, why when implementing a4675fbc4=
a7a
> we did changed core for wrmsrl and not atom ?

By mistake?

> My point is that the issue was more due to a miss in the patch a4675f=
bc4a7a
> rather than a difference of behavior between atom and core.

The issue is due to the fact that wrmsrl_on_cpu() is used in atom_set_p=
state().

Moreover, core_set_pstate() doesn't use wrmsrl_on_cpu(), so in fact it
is different from atom_set_pstate() in that respect.

Now, why and when that difference was introduced doesn't really
matter.  What matters is whether or not it makes sense and what to do
about it.

To me, it doesn't make sense.  wrmsrl() should be used on both Core
and Atom to update the MSR in intel_pstate_adjust_busy_pstate().  In
turn, wrmsrl_on_cpu() should be used by both of them on init/exit.
That's exactly what happens with my patch applied, with a twist that
on init/exit the P-state is always set to the minimum, so it is not
even necessary to pass the pstate argument between functions in that
case.

> The commit message is a bit misleading around this.
> The wrmrl_on_cpu() is needed on both core and atom during init.

Yes, it is, but how is that related to the changelog of this patch?

Thanks,
Rafael
