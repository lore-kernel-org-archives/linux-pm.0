From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Thu, 05 Feb 2015 00:20:10 +0100
Message-ID: <6147604.f4mimnOd4x@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <CAKohpomU7LAxCpXrcpzb3DY0yELGrj3vECL9Vyegjgde+-Tdvg@mail.gmail.com> <54D29D27.7080207@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62074 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754268AbbBDW5P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 17:57:15 -0500
In-Reply-To: <54D29D27.7080207@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On Wednesday, February 04, 2015 02:28:55 PM Saravana Kannan wrote:
> On 02/03/2015 10:20 PM, Viresh Kumar wrote:
> > On 4 February 2015 at 03:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> >> Can you explain why we need a fallback list in the first place? Now that we
> >> are not destroying and creating policy objects, I don't see any point in the
> >> fallback list.
> >
> > Because we wanted to mark the policy inactive. But as I have introduced another
> > field for that now, probably it can be fixed. Will check again on what
> > can be done.
> 
> Thanks. That's why I was asking. Now that you have another flag. Also, 
> you might not even need a flag. You can just check if policy->cpus is 
> empty (btw, I think we should let that go to empty)

So the idea would be to avoid clearig cpufreq_cpu_data during offline
tear-down (because we know that the CPU is offline anyway) and then start
using the same policy pointer during offline?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
