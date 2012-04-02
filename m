From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Subject: Re: [PATCH 58/76] idle, x86: Allow off-lined CPU to enter deeper
 C states
Date: Mon, 2 Apr 2012 13:56:12 -0400
Message-ID: <4F79E83C.5090506@amd.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>	<1333102459-23750-1-git-send-email-lenb@kernel.org>	<1a022e3f1be11730bd8747b1af96a0274bf6356e.1333101989.git.len.brown@intel.com>	<CA+8MBbLROfbyfAGZ0xn1tZVHsndeTUNrn=-gHhsfzkocBLh=iQ@mail.gmail.com> <CA+8MBbJnrhKmy5f_pbL8Ogi1ihM-51hfqCDY5gUQ1hkvw7p22Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+8MBbJnrhKmy5f_pbL8Ogi1ihM-51hfqCDY5gUQ1hkvw7p22Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 04/02/12 13:25, Tony Luck wrote:
>>> +       while (1) {
>>> +
>>> +               if (cx->entry_method == ACPI_CSTATE_HALT)
>>> +                       halt();
>
> What's the intent here?  I think that I can just set up a function pointer
> named "halt" on ia64 and point it to my cpu_halt() function (which looks
> for the deepest C-state, and then calls PAL to enter it. Is that equivalent
> to what the x86 "halt()" function does?


x86 halt() causes processor to go to C1 state (which is often not the 
deepest). But other than that it seems similar to what you are describing.

However, the fix that you are proposing will only help ia64 and I wonder 
whether others architectures may have the same problem?

(And I don't think inb/inl should cause you any trouble since they are 
already used, for example, in acpi_idle_do_entry())

-boris


