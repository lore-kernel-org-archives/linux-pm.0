From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 58/76] idle, x86: Allow off-lined CPU to enter deeper C states
Date: Mon, 2 Apr 2012 11:02:44 -0700
Message-ID: <CA+8MBbKv25Uu3fJeBhyj5cQvB6FN+KqgnP67UGhwvF+p635g7w@mail.gmail.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	<1333102459-23750-1-git-send-email-lenb@kernel.org>
	<1a022e3f1be11730bd8747b1af96a0274bf6356e.1333101989.git.len.brown@intel.com>
	<CA+8MBbLROfbyfAGZ0xn1tZVHsndeTUNrn=-gHhsfzkocBLh=iQ@mail.gmail.com>
	<CA+8MBbJnrhKmy5f_pbL8Ogi1ihM-51hfqCDY5gUQ1hkvw7p22Q@mail.gmail.com>
	<4F79E83C.5090506@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4F79E83C.5090506@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@amd.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

> x86 halt() causes processor to go to C1 state (which is often not the
> deepest). But other than that it seems similar to what you are describing.

OK - then Konrad's suggestion of using "safe_halt()" here rather than
"halt()" would work for ia64.

Other architectures don't use APCI - so this should just be localized to
x86 and ia64

-Tony
