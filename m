From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 2/3] PM / Domains: Support atomic PM domains
Date: Wed, 10 Jun 2015 14:35:19 -0600
Message-ID: <20150610203519.GB7715@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-3-git-send-email-lina.iyer@linaro.org>
 <7hy4jrmoch.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34991 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbFJUfV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 16:35:21 -0400
Received: by pdbnf5 with SMTP id nf5so44753014pdb.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 13:35:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hy4jrmoch.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On Wed, Jun 10 2015 at 12:04 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Power Domains currently support turning on/off only in process context.
>
>Generic Power Domains...
>
>Also Re: $SUBJECT.  s/atomic/IRQ safe/
>
Okay. 

>> This restricts the usage of PM domains to devices and domains that
>> could be powered on/off in irq disabled contexts as the mutexes used in
>> GenPD allows for cpu sleep while waiting for locks.
>
>That sentence reads the opposite of what you mean.  Rather than "This
>restricts X to Y", I think you menant "This prevents X for Y".
>
Will reword.

>> Genpd inherently provides support for devices, domain hierarchy and can
>
>s/domain heirarchy/nesting/
>
Ok

>> be used to represent cpu clusters like in ARM's big.Little, where, each
>> cpu cluster is in its domain, with supporting caches and other
>> peripheral hardware.
>
>s/domain/power domain/
>
OK

>> Multiple such domains could be part of another domain.
>
>OK, but not important to this change IMO.
>
>> Because mutexes are used to protect and synchronize domain
>
>s/domain/genpd/
>
Ya, genpd is better word.

>> operations and cpu idle operations are inherently atomic,
>
>Be more specific about "CPU idle operations are inherently atomic", as
>it's not obvious that it's true.  I think what you mean is that
>the CPUidle paths for entering of low-power idle states is inherently
>atomic because interrupts are disabled.
>
Will explain

>> the use of
>> genpd is not possible for runtime suspend and resume of the pm domain.
>
>... so, the use of genpd during the idle path of CPUs is not currently
>possible because interrups are disabled in the idle path.
>
>> Replacing the locks to spinlocks would allow cpu domain to be be powered
>                     ^^^^
>s/to/with/
>
Ok

>> off to save power, when all the cpus are powered off.
>
>More accuratly, replacing the locks doesn't allow the domain to be
>powered off, rather it allows genpd to be used in the idle path, which
>would allow genpd to be used
>
>> However, not all domains can operate in irq-safe contexts and usually
>> would need to sleep during domain operations. So genpd has to support
>> both the cases, where the domain is or is not irq-safe. The irq-safe
>> attribute is therefore domain specific.
>>
>> To achieve domain specific locking, set the GENPD_FLAG_IRQ_SAFE flag
>> while defining the domain. This determines if the domain should use a
>> spinlock instead of a mutex. Locking is abstracted through
>> genpd_lock_domain() and genpd_unlock_domain() functions that use the
>> flag to determine the locking to be used for this domain.
>>
>> The restriction this imposes on the domain hierarchy is that subdomains
>> and all devices in the hierarchy also be irq-safe. Non irq-safe domains
>> may continue to have irq-safe devices, but not the other way around.
>
>This might need some corresponding updates to Documentation/ as well.
>
Agreed. Will add documentation in the next spin.

Thanks for the review Kevin.

-- Lina
