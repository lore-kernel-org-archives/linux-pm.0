From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH] ACPI: replace strlen("string") with sizeof("string") -1
Date: Mon, 30 Jul 2012 16:41:48 +0200
Message-ID: <CAFLxGvz=cYJQhCi99trBN8=hGA9XmY8Z7weNmnASYTqAbr0PEw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
	<5011F15A.3060007@kernel.org>
	<1343658373.15432.18.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1343658373.15432.18.camel@zakaz.uk.xensource.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Pavel Vasilyev <pavel@pavlinux.ru>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 30, 2012 at 4:26 PM, Ian Campbell <ijc@hellion.org.uk> wrote:
> I thought gcc optimised strlen("string literal") into a compile time
> constant too. It does in a little userspace test I just wrote, but I
> didn't look at its behaviour with the kernel's strlen.

It depends whether you use the built-in strlen() or not.
AFAIK the kernel does not use the built-in variant.

-- 
Thanks,
//richard
