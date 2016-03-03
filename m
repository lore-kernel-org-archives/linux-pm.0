From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: Fix crash on graph trace through x86 suspend
Date: Thu, 3 Mar 2016 03:16:19 +0100
Message-ID: <CAJZ5v0hSCAeoZ5OzRawcHebevfo=gqG34JgwFCiiZUOqmUh8RQ@mail.gmail.com>
References: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
	<CAJZ5v0gX+FEHryK=dJvQ1kXO19Addk5nr4jid012CpZzVdE_tA@mail.gmail.com>
	<1456965812.5488.4.camel@linux.intel.com>
	<CAJZ5v0g2nwVO6=K=_=kJ83dCdA=A1V1fODfygFsrW3UxwjoMxw@mail.gmail.com>
	<CAJZ5v0g9uy=Ne5-+dKEphyhF6tZP-sVeKaPeE7utCOK27Xnxag@mail.gmail.com>
	<20160302210750.147efd34@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35397 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbcCCCQV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 21:16:21 -0500
In-Reply-To: <20160302210750.147efd34@grimm.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Mar 3, 2016 at 3:07 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 3 Mar 2016 02:36:26 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> > OK, applied, but let Steven and the x86 folks see it.
>
> The below patch looks fine to me. Anything else I should look at?

No, that was it, thanks!
