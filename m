From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] USB / PM: Drop CONFIG_PM_RUNTIME from the USB core
Date: Thu, 27 Nov 2014 23:46:36 +0100
Message-ID: <3884361.r5D4k6hhsp@vostro.rjw.lan>
References: <1736553.sGOphfkJmV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1736553.sGOphfkJmV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, USB development list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 27, 2014 11:45:15 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so quite a few
> #ifdef blocks depending on CONFIG_PM_RUNTIME may now be changed to
> depend on CONFIG_PM (or even dropped in some cases).
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM in the USB core code.

Forgot to say, commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) is only in linux-next (via linux-pm) at the moment.

Rafael
