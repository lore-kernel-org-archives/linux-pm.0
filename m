From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] intel_idle: correct/improve BXT support
Date: Thu, 16 Jun 2016 01:59:53 -0600
Message-ID: <5762789902000078000F58EF@prv-mh.provo.novell.com>
References: <574C4D9002000078000EFAAC@prv-mh.provo.novell.com>
 <CAJvTdK=wLx0Te2fPG_hVPDDDKuhmamsZqjo-zinnzQbxgXBpfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:57252 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcFPH7z convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:2:1>);
	Thu, 16 Jun 2016 03:59:55 -0400
In-Reply-To: <CAJvTdK=wLx0Te2fPG_hVPDDDKuhmamsZqjo-zinnzQbxgXBpfQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

>>> On 16.06.16 at 06:46, <lenb@kernel.org> wrote:
> On Mon, May 30, 2016 at 8:26 AM, Jan Beulich <JBeulich@suse.com> wrote:
>> Commit 5dcef69486 ("intel_idle: add BXT support") added an 8-element
>> lookup array with just a 2-bit value used for lookups. As per the SDM
>> that bit field is really 3 bits wide. Since the top two array entries
>> are zero, deal with the resulting invalid (zero) values by moving the
>> zero-MSR-value check into irtl_2_usec() and having that function's
>> caller check the function result instead.
> 
> Thanks, Jan, for reviewing this code!
> 
> There are 3 logical changes here,
> which should be 3 different patches.
> 
> #1:
> 
>> -       ns = irtl_ns_units[(irtl >> 10) & 0x3];
>> +       ns = irtl_ns_units[(irtl >> 10) & 0x7];
> 
> This is a latent bug.  It is latent because this code is currently used
> only on BXT, and BXT doesn't use high index.  However, this could be
> a functional bug if this code is re-used elsewhere, so we should fix it.

I can see this getting split out, but then not as the first patch.

> #2
> 
>> +       unsigned int usec;
> 
>> -               unsigned int usec = irtl_2_usec(msr);
>> +       usec = irtl_2_usec(msr);
> 
>> -               unsigned int usec = irtl_2_usec(msr);
>> +       usec = irtl_2_usec(msr);
> 
>> -               unsigned int usec = irtl_2_usec(msr);
>> +       usec = irtl_2_usec(msr);
> 
>> -               unsigned int usec = irtl_2_usec(msr);
>> +       usec = irtl_2_usec(msr);
> 
>> -               unsigned int usec = irtl_2_usec(msr);
>> +       usec = irtl_2_usec(msr);
> 
> I'm okay with this cleanup, if you want to send as a 2nd patch.
> 
> (I'm also okay leaving it how it is, since the value of of usec
>  has no meaning across these blocks, and so a local is actually
>  more logical, at least to me.)
> 
> #3
> 
> Checking for 0
> 
> There are two cases:
> 1. MSR returns 0
> This actually happens, when a state is not supported.
> Though when a state is not supported, this is actually
> dead code, as the value we calculate will not be used.
> So technically we don't really need to check
> and could, indeed, keep it simple and write 0.
> 
> This code was written when the ucode was in flux,
> so it is already more paranoid than it has to be....
> 
> 2. MSR returns index 0 - 5.
> It will never return 6 or 7 -- the 0 padding on the array
> is just my own coding style.  Could just as well specify
> the size of the array as 8, or truncate it to 6 and check the
> max index.  But all of this is just paranoia, because
> the index will never be above 5.  This value is written
> by ucode, not by the BIOS -- think of it has hardware.
> 
> So I'm neutral on this change, but if you like how it reads
> enough to send me a patch #3, I'll apply it.

But I can't really see #2 and #3 to be separate patches: The
change to check usecs instead of msr against zero is coupled
with calculating usecs outside the if() bodies, and having an
intermediate state of

	usec = irtl_2_usec(msr);
	if (msr) {
		bxt_cstates[2].exit_latency = usec;
		bxt_cstates[2].target_residency = usec;
	}

would look rather odd to me.

IOW I could see #2 and #3 together go as a cleanup patch
first, and #1 become the 2nd patch, fixing the latent bug (but
really all that cleanup was done to accommodate the latent
bug fix - despite what you say I don't think the software should
make itself dependent on how ucode behaves -, so to me it
seemed more natural to do this in one go). Please let me know.

Jan

