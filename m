From: Patrik Lundquist <patrik.lundquist@gmail.com>
Subject: Re: v3.13.5 intel_pstate: cpufreq: __cpufreq_add_dev: ->get() failed
Date: Wed, 12 Mar 2014 15:14:51 +0100
Message-ID: <CAA7pwKN2Rn2y9TaEYLtwVmJ0_7Syx0kVQHUNga5ga2BwB=q1fQ@mail.gmail.com>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com>
	<531F783B.7010100@gmail.com>
	<2792846.28xTH7a9zW@vostro.rjw.lan>
	<3509059.VnUUJct98J@vostro.rjw.lan>
	<CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47725 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbaCLOOx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 10:14:53 -0400
In-Reply-To: <CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 12 March 2014 12:42, Patrik Lundquist <patrik.lundquist@gmail.com> wrote:
> On 12 March 2014 00:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> So Patrik, please test this one (resending, so that it gets to linux-pm):
>
> Will do. Might take a couple of days.

Come to think of it, there's not much to test besides verifying that
cpufreq_driver->get() isn't called like before (i.e. no need to test
on the server).

So I inserted pr_err()s and they aren't printed when booting my Intel
Xeon CPU E3-1240 V2 while the intel_pstate driver still is used.

The patch works for me.
