From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/22 v2] cpufreq/acpi-cpufreq: Convert to hotplug state machine
Date: Mon, 28 Nov 2016 13:46:07 +0100
Message-ID: <CAJZ5v0i7LJXMgnC8+zwxoBm39ZpVrNUpicirNmtupti1m9QZJw@mail.gmail.com>
References: <20161126231350.10321-1-bigeasy@linutronix.de> <20161126231350.10321-2-bigeasy@linutronix.de>
 <20161128051520.GA9104@vireshk-i7> <20161128094908.o6f4itwnj4gssv46@linutronix.de>
 <20161128095101.psbseghv463lws76@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34994 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbcK1MqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 07:46:09 -0500
In-Reply-To: <20161128095101.psbseghv463lws76@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rt@linutronix.de

On Mon, Nov 28, 2016 at 10:51 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Install the callbacks via the state machine.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2: set msrs to NULL on error during init.

OK

Let me route this and the [2/22] through the PM tree (they are first
in the series anyway).

Thanks,
Rafael
