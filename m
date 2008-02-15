From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] move wakeup code to .c
Date: Fri, 15 Feb 2008 18:19:23 -0500
Message-ID: <200802151819.23413.lenb@kernel.org>
References: <20080210222723.GA1865@elf.ucw.cz> <200802150135.07127.lenb@kernel.org> <200802152322.23392.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762875AbYBOXUf@vger.kernel.org>
In-Reply-To: <200802152322.23392.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, hpa@zytor.com, sam@ravnborg.org
List-Id: linux-pm@vger.kernel.org

On Friday 15 February 2008 17:22, Rafael J. Wysocki wrote:

> Ok, below is the version that survives checkpatch.pl, compiles on x86-32
> and has been successfully tested on 32-bit and 64-bit systems.

works on my t61 in 64-bit mode too.

applied to acpi-test.

thanks,
-Len
