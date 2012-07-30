From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH] ACPI: replace strlen("string") with sizeof("string") -1
Date: Mon, 30 Jul 2012 15:26:13 +0100
Message-ID: <1343658373.15432.18.camel@zakaz.uk.xensource.com>
References: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
	 <5011F15A.3060007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5011F15A.3060007@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Pavel Vasilyev <pavel@pavlinux.ru>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-07-26 at 21:39 -0400, Len Brown wrote:
> ...both give the number of chars in the string
> without the '\0', as strncmp() wants,
> but sizeof() is compile-time.

I thought gcc optimised strlen("string literal") into a compile time
constant too. It does in a little userspace test I just wrote, but I
didn't look at its behaviour with the kernel's strlen.

Ian.

